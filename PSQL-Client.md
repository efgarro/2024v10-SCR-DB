### Postgresql24v10 EC2 Instance (54-205-165-107)
```sh

ssh -i "/c/00-CodeShop/99-References/ssh_auth_keys/postgresql24v10.pem" ubuntu@ec2-54-205-165-107.compute-1.amazonaws.com

scp -i /c/00-CodeShop/99-References/ssh_auth_keys/postgresql24v10.pem dvdrental.tar  ubuntu@ec2-54-205-165-107.compute-1.amazonaws.com:~/tmp/

sudo -i -u postgres

pg_restore -U postgres -d /var/postgresql/tmp/dvdrental.tar
sudo -i -u postgres

```

### psql Login

```sh

psql --host=54.205.165.107 --port=5432 --username=postgres --dbname=postgres [password: Pos***s]
psql --host=54.205.165.107 --port=5432 --username=efgarro --dbname=2024v10-scr-db [password: Due***ga]
psql --host=54.205.165.107 --port=5432 --username=efgarro --dbname=dvdrental [password: Due***ga]

```
### psql Command-line Options.

```sh
-f, --file=FILENAME      execute commands from file, then exit
```

### psql Backslash Commands.
```
\l list all databases
\c <db-name>   switch to another db
\dt list db tables
\d <table-name> describe a table
\d+ <table-name> more information about a table
\du lists users and their roles
\df lists all functions
\i <FILE> execute commands from file

\? get all psql commands
\? options get all psql commands-line
\x
\! cls
\q quit
```

```sh
\password postgres

sudo -u postgres psql

sudo systemctl is-active postgresql
sudo systemctl restart postgresql

vim /etc/postgresql/16/main/postgresql.conf
vim /etc/postgresql/16/main/pg_hba.conf

```