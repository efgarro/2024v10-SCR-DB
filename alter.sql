ALTER TABLE scr_countries 
RENAME COLUMN country_name TO country;

ALTER TABLE scr_images 
RENAME COLUMN filename TO file_name;

ALTER TABLE scr_users
ADD UNIQUE (email)

DELETE FROM scr_users
WHERE user_id = '018e263e-4c8b-7fa6-a76d-41f630f4ca7d';

ALTER TABLE scr_places
ADD geom geometry(point, 4326);

ALTER TABLE scr_image_sets
ADD hasImages boolean;

ALTER TABLE scr_image_sets
ADD image_set_stack uuid[];




