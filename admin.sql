CREATE USER your_new_username WITH PASSWORD 'your_password';

CREATE USER your_new_username WITH PASSWORD 'your_password' SUPERUSER;

-- to write comments
/* 
also like this
*/

SET role efgarro; --to change user from session user

SELECT session_user current_user; -- to show users

GRANT ALL PRIVILEGES ON DATABASE "2024-v10-scr-db" TO efgarro;