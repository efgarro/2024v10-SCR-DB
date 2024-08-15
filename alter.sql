ALTER TABLE scr_countries 
RENAME COLUMN country_name TO country;

ALTER TABLE scr_users
ADD UNIQUE (email)

DELETE FROM scr_users
WHERE user_id = '018e263e-4c8b-7fa6-a76d-41f630f4ca7d';