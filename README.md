### Technologies Used

- Postgres 16.2
- dbdiagram.io / Entity-Relationships Design Tool
- psql - PostgreSQL interactive terminal
- PL/pgSQL - SQL Procedural Language


### ssh Login to EC2 Instance

```sh
ssh -i "/c/00-CodeShop/99-References/ssh_auth_keys/postgresql24v10.pem" ubuntu@ec2-54-205-165-107.compute-1.amazonaws.com
```


### psql Login to EC2 Instance 

```sh
psql --host=54.205.165.107 --port=5432 --username=efgarro --dbname=2024v10-scr-db [password: Due***ga]
```


### Git Setup

```sh
git init
git add *
git commit -m "0301a"
git branch -M main
git remote add origin https://github.com/efgarro/2024v10-SCR-DB.git
git push -u origin main
```


### Tags Naming Convention

```sh
schema_type:
wfall
lodge
trail
resta
users
hubxx
rgion

hub:
climon
ptovjo
tmrndo
stacrz
nicoya
lberia
perzel
domcal
jacher

region:
guanac
caribe
zonsur
pactrl
```

### AWS Postgres Server

https://ubuntu.com/server/docs/install-and-configure-postgresql
https://medium.com/@pantaanish/setting-up-postgresql-on-an-ec2-instance-a-step-by-step-guide-9be2e3348fdb


## pg_uuidv7 Extension

https://pgxn.org/dist/pg_uuidv7/#build

```sql
SELECT uuid_generate_v7();

           uuid_generate_v7           
--------------------------------------
 018570bb-4a7d-7c7e-8df4-6d47afd8c8fc
(1 row)
```