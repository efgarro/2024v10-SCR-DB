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