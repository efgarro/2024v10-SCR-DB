

-- Version 2025-06-14

CREATE TYPE lodge AS (place_id uuid, image_set_id uuid, hub varchar, schema_type varchar)
RETURNS TABLE (place_id_out uuid, image_set_id_out uuid, hub_out varchar, schema_type_out varchar)

CREATE OR REPLACE FUNCTION register_lodge(schema_type varchar, hub varchar, name varchar, description varchar, latitude numeric, longitude numeric, email varchar)
RETURNS SETOF json
AS 
$$
DECLARE
    image_set_uuid uuid;
    place_uuid uuid;
    lodge_uuid uuid;
BEGIN
INSERT INTO scr_image_sets(image_set_id, schema_type) VALUES (uuid_generate_v7(), schema_type) RETURNING scr_image_sets.image_set_id INTO image_set_uuid;
INSERT INTO scr_places (place_id, image_set_id, schema_type, hub, name, description, latitude,  longitude, geo) VALUES (uuid_generate_v7(), image_set_uuid, schema_type, hub, name, description, latitude, longitude, POINT(longitude, latitude)::geometry) RETURNING scr_places.place_id INTO place_uuid;
INSERT INTO scr_lodging  (lodge_id, place_id, email) VALUES (uuid_generate_v7(), place_uuid, email);
RETURN QUERY SELECT json_agg(r) FROM (SELECT scr_places.place_id, scr_places.image_set_id, scr_places.hub, scr_places.schema_type FROM scr_places JOIN scr_lodging ON scr_places.place_id = scr_lodging.place_id) AS r WHERE r.place_id = place_uuid;
END;
$$
LANGUAGE plpgsql;


DROP FUNCTION register_lodge(uuid,character varying,character varying,character varying,character varying,numeric,numeric)

DROP FUNCTION register_lodge(character varying,character varying,character varying,character varying,numeric,numeric,character varying)

DROP FUNCTION register_lodge(character varying,character varying,character varying,character varying,numeric,numeric,character varying);

SELECT json_agg(lo) FROM (SELECT scr_places.place_id, scr_places.image_set_id, scr_places.hub, scr_places.schema_type FROM scr_places JOIN scr_lodging ON scr_places.place_id = scr_lodging.place_id) AS lo WHERE lo.place_id = '0197751d-f5a7-7e08-888a-52363a86ea82';
SELECT json_agg(r) FROM (SELECT scr_places.place_id, scr_places.image_set_id, scr_places.hub, scr_places.schema_type FROM scr_places WHERE scr_places.place_id = '0197751d-f5a7-7e08-888a-52363a86ea82') AS r;


-- TRIGGER FUNCTION

CREATE OR REPLACE FUNCTION image_set_trigger() 
RETURNS TRIGGER 
AS
$$
BEGIN
INSERT INTO scr_image_sets(image_set_id, schema_type) VALUES (uuid_generate_v7(), NEW.schema_type);
RAISE NOTICE NEW;
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER image_set_trigger BEFORE INSERT ON scr_places
FOR EACH ROW EXECUTE FUNCTION image_set_trigger();


CREATE OR REPLACE FUNCTION insert_image_into_db(p_image_id uuid, p_image_set_id uuid, p_file_name varchar, p_url varchar, p_orientation varchar)
RETURNS void
AS 
$$
BEGIN
INSERT INTO scr_images(image_id, image_set_id, file_name, uploaded, url, orientation) VALUES (p_image_id, p_image_set_id, now(), p_file_name, p_url, p_orientation);
UPDATE scr_image_sets SET image_set_stack = array_append(image_set_stack, p_image_id) WHERE image_set_id = p_image_set_id;
END;
$$
LANGUAGE plpgsql;

\latitude '0197aa20-b97b-7e9c-a359-09b239fbdffe';

UPDATE scr_image_sets SET image_set_stack = array_append(image_set_stack,'01978018-2d3f-7e24-a5fb-4036d50af2ef') WHERE image_set_id = '0197aa20-b97b-7e9c-a359-09b239fbdffe';

image_set_id:"0197aa20-b97b-7e9c-a359-09b239fbdffe"


CREATE TYPE image_set_stack AS (image_set_stack uuid[])

CREATE OR REPLACE FUNCTION get_image_set_stack(p_image_set_id uuid)
RETURNS SETOF uuid[]
AS 
$$
BEGIN
RETURN QUERY SELECT scr_image_sets.image_set_stack FROM scr_image_sets WHERE scr_image_sets.image_set_id = p_image_set_id;
END;
$$
LANGUAGE plpgsql;

-- CREATE OR REPLACE FUNCTION get_image_set_stack(p_image_set_id uuid)


CREATE OR REPLACE FUNCTION get_image_set_stack()
RETURNS void
AS 
$$
DECLARE
v_image_set_stack uuid[];
v_image_id uuid;
BEGIN
SELECT scr_image_sets.image_set_stack INTO v_image_set_stack FROM scr_image_sets WHERE scr_image_sets.image_set_id = '0197b3f0-a25d-737e-9b5d-a4d618102baa';
FOREACH v_image_id SLICE 0 IN ARRAY v_image_set_stack
LOOP
RAISE NOTICE 'The uuid is: %', v_image_id;
END LOOP;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_image_set_stack()
RETURNS SETOF json
AS 
$$
DECLARE
v_image_set_stack uuid[];
v_image_id uuid;
BEGIN
SELECT scr_image_sets.image_set_stack INTO v_image_set_stack FROM scr_image_sets WHERE scr_image_sets.image_set_id = '0197b3f0-a25d-737e-9b5d-a4d618102baa';
RETURN QUERY SELECT json_agg(img) FROM (SELECT scr_images.url FROM scr_images WHERE scr_images.image_id = ANY (v_image_set_stack)) AS img;
END;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION get_image_set_stack(p_image_set_id uuid)
RETURNS SETOF json
AS 
$$
DECLARE
v_image_set_stack uuid[];
BEGIN
SELECT scr_image_sets.image_set_stack INTO v_image_set_stack FROM scr_image_sets WHERE scr_image_sets.image_set_id = p_image_set_id;
RETURN QUERY SELECT json_agg(img) FROM (SELECT scr_images.image_id AS id, scr_images.url FROM scr_images WHERE scr_images.image_id = ANY (v_image_set_stack)) AS img;
END;
$$
LANGUAGE plpgsql;


-- unnest() WITH ORDINALITY

CREATE OR REPLACE FUNCTION get_image_set_stack(p_image_set_id uuid)
RETURNS SETOF json
AS 
$$
DECLARE
v_image_set_stack uuid[];
BEGIN
SELECT scr_image_sets.image_set_stack INTO v_image_set_stack FROM scr_image_sets WHERE scr_image_sets.image_set_id = p_image_set_id;
RETURN QUERY SELECT json_agg(img) FROM (SELECT scr_images.image_id AS id, scr_images.url FROM scr_images INNER JOIN unnest(v_image_set_stack) WITH ORDINALITY tbl(id, idx) ON scr_images.image_id = tbl.id ORDER BY tbl.idx) AS img;
END;
$$
LANGUAGE plpgsql;

-- FOREACH

CREATE TYPE t_image_set_stack AS (id uuid, url varchar);

CREATE OR REPLACE FUNCTION get_image_set_stack(p_image_set_id uuid)
RETURNS SETOF json
AS 
$$
DECLARE
v_image_set_stack t_image_set_stack[];
v_image t_image_set_stack;
v_image_set_uuids uuid[];
v_uuid uuid;
BEGIN
SELECT scr_image_sets.image_set_stack INTO v_image_set_uuids FROM scr_image_sets WHERE scr_image_sets.image_set_id = p_image_set_id;
FOREACH v_uuid IN ARRAY v_image_set_uuids
LOOP
SELECT scr_images.image_id AS id, scr_images.url INTO v_image FROM scr_images WHERE scr_images.image_id = v_uuid;
SELECT array_append(v_image_set_stack, v_image);
END LOOP;
RETURN QUERY SELECT json_agg(v_image_set_stack);
END;
$$
LANGUAGE plpgsql;

'0197b3f0-a25d-737e-9b5d-a4d618102baa'
-- RETURNS SETOF uuid[]
-- RETURN v_image_set_stack;



-- query directly from API, hence it was not used
CREATE OR REPLACE FUNCTION update_image_set_stack(p_image_set_stack uuid[])
RETURNS void
AS 
$$
BEGIN

SELECT scr_image_sets.image_set_stack INTO v_image_set_stack FROM scr_image_sets WHERE scr_image_sets.image_set_id = p_image_set_id;
RETURN QUERY SELECT json_agg(img) FROM (SELECT scr_images.url FROM scr_images WHERE scr_images.image_id = ANY (v_image_set_stack)) AS img;
END;
$$
LANGUAGE plpgsql;