
CREATE OR REPLACE FUNCTION register_lodge(uuid, uuid, uuid,  varchar, varchar, varchar, varchar, numeric, numeric, varchar)
RETURNS void
AS 
$$
BEGIN
INSERT INTO scr_image_sets(image_set_id, schema_type) VALUES ($3, $4);
INSERT INTO scr_places (place_id, image_set_id, schema_type, hub, name, description, latitude,  longitude) VALUES ($1, $3, $4, $5, $6, $7, $8, $9);
INSERT INTO scr_lodging  (lodge_id, place_id, email) VALUES ($2, $1, $10);
END;
$$
LANGUAGE plpgsql;


DROP FUNCTION register_lodge(uuid,character varying,character varying,character varying,character varying,numeric,numeric)


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

