CREATE OR REPLACE FUNCTION fn_1()
RETURNS int
AS 
$$
DECLARE
result int; 
BEGIN
result := (SELECT 2 * 3);
RAISE NOTICE 'Result: %', result;
RETURN result;
END;
$$
LANGUAGE plpgsql;


DO $$
BEGIN
RAISE NOTICE 'Hellow Bella';
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_2(min_val int, max_val int)
RETURNS int
AS 
$$
DECLARE
    result int; 
BEGIN
    SELECT random() * (max_val - min_val) + min_val INTO result;
    RAISE NOTICE 'Result: %', result;
    RETURN result;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_3(min_val int, max_val int)
RETURNS varchar AS 
$body$
DECLARE
    rand_id int;
    person_actor record; 
BEGIN
    SELECT random() * (max_val - min_val) + min_val INTO rand_id;
    SELECT * FROM actor INTO person_actor WHERE rand_id = actor.actor_id;
    RAISE NOTICE 'Result: %', person_actor;
    RETURN CONCAT(person_actor.first_name, ' ', person_actor.last_name);
END;
$body$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_5(IN the_month int, OUT lu_month int, OUT lu_day int, 
                                OUT f_name varchar, OUT l_name varchar)
AS 
$body$
BEGIN
    SELECT EXTRACT(MONTH FROM last_update), EXTRACT(DAY FROM last_update), first_name, last_name
    FROM actor INTO lu_month, lu_day, f_name, l_name WHERE EXTRACT(MONTH FROM last_update) = the_month
    LIMIT 10; 
END;
$body$
LANGUAGE plpgsql;


SELECT EXTRACT(MONTH FROM last_update), EXTRACT(DAY FROM last_update), first_name, last_name
    FROM actor LIMIT 10;


CREATE OR REPLACE FUNCTION fn_6()
RETURNS SETOF actor
AS 
$body$
BEGIN
    RETURN QUERY
    SELECT * FROM actor
    LIMIT 10;
END;
$body$
LANGUAGE plpgsql;


SELECT *
FROM film
NATURAL JOIN film_category;

SELECT *
FROM film
INNER JOIN film_category USING (film_id)
INNER JOIN category USING (category_id)
LIMIT 4;


NATURAL JOIN category

CREATE OR REPLACE FUNCTION fn_7()
RETURNS void
AS 
$body$
DECLARE
    actor_rec record;
BEGIN
    INSERT INTO actor(first_name, last_name) VALUES('Felip', 'LeMont') RETURNING * INTO actor_rec;
    RAISE NOTICE 'id: % first name: %, last name: %', 
    actor_rec.actor_id, actor_rec.first_name, actor_rec.last_name;
END;
$body$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION fn_8()
RETURNS void
AS 
$body$
DECLARE
    actor_last_name varchar(45);
BEGIN
    INSERT INTO actor(first_name, last_name) VALUES('Felip', 'LeMont') RETURNING actor.last_name INTO actor_last_name;
    RAISE NOTICE 'last name: %', actor_last_name;
END;
$body$
LANGUAGE plpgsql;

CREATE TABLE employees (
  employee_id serial primary key,
  department_id integer references departments(department_id),
  name text,
  start_date date,
  fingers integer,
  geom geography(point, 4326)
  );