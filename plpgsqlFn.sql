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