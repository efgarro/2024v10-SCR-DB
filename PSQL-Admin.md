## psql Command-line Options.

psql --host=localhost --port=5432 --username=postgres --dbname=postgres

-f, --file=FILENAME execute commands from file, then exit

## psql Backslash Commands.

\l list all databases
\c <db-name> switch to another db
\dt list db tables
\d <table-name> describe a table
\d+ <table-name> more information about a table
\du lists users and their roles
\df lists all functions
\i <file-name> execute commands from file

\? get all psql commands
\? options get all psql commands-line
\x
\! cls
\q quit
