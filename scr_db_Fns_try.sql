

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

