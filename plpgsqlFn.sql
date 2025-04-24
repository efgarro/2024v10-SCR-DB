CREATE OR REPLACE FUNCTION fn_one()
RETURNS VARCHAR
AS 
$$
DECLARE
name VARCHAR; 
BEGIN
SELECT first_name INTO name FROM actor WHERE actor_id = 1;
RETURN name;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_one()
RETURNS VARCHAR
AS 
$$
DECLARE
name VARCHAR; 
uuid VARCHAR;
BEGIN
SELECT region_name INTO name FROM scr_regions WHERE region_id = '0190c374-d614-7633-8070-e0516d1afd9d';
SELECT INTO uuid uuid_generate_v7();
RETURN name;
END;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION register_lodge(schema_type varchar, hub varchar, name varchar, description varchar, latitude numeric, longitude numeric, email varchar)
RETURNS void
AS 
$$
DECLARE
    image_set_id uuid;
    place_id uuid;
    lodge_id uuid;
BEGIN
INSERT INTO scr_image_sets(image_set_id, schema_type) VALUES (uuid_generate_v7(), schema_type) RETURNING scr_image_sets.image_set_id INTO image_set_id;
INSERT INTO scr_places (place_id, image_set_id, schema_type, hub, name, description, latitude,  longitude, geo) VALUES (uuid_generate_v7(), image_set_id, schema_type, hub, name, description, latitude, longitude, POINT(longitude, latitude)::geometry) RETURNING scr_places.place_id INTO place_id;
INSERT INTO scr_lodging  (lodge_id, place_id, email) VALUES (uuid_generate_v7(), place_id, email);
END;
$$
LANGUAGE plpgsql;


SELECT uuid_generate_v7();

DROP FUNCTION register_lodge(uuid,character varying,character varying,character varying,character varying,numeric,numeric)
DROP FUNCTION register_lodge(uuid, uuid, uuid,  varchar, varchar, varchar, varchar, numeric, numeric, varchar)


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

SELECT * FROM scr_places JOIN scr_lodging ON scr_places.place_id = scr_lodging.place_id;


DO
$body$
