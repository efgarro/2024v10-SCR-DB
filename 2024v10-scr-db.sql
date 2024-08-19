CREATE TABLE "scr_places" (
  "place_id" uuid PRIMARY KEY,
  "hub" varchar(6),
  "schema_type" varchar(5),
  "image_set_id" uuid UNIQUE,
  "name" varchar(50),
  "description" varchar(255),
  "latitude" numeric(8,6),
  "longitude" numeric(8,6)
);

CREATE TABLE "scr_restaurants" (
  "resta_id" uuid PRIMARY KEY,
  "place_id" uuid UNIQUE,
  "phone" varchar(50),
  "email" varchar(100),
  "url" varchar(255),
  "food_gendre" varchar(50),
  "price_range" varchar(50),
  "opening_hours" varchar(100)
);

CREATE TABLE "scr_lodging" (
  "lodge_id" uuid PRIMARY KEY,
  "place_id" uuid UNIQUE,
  "phone" varchar(50),
  "email" varchar(100),
  "price_range" varchar(50),
  "url" varchar(255)
);

CREATE TABLE "scr_waterfalls" (
  "wfall_id" uuid PRIMARY KEY,
  "place_id" uuid UNIQUE,
  "vertical_drop" varchar(50)
);

CREATE TABLE "scr_schema_types" (
  "schema_type_id" uuid PRIMARY KEY,
  "schema_type_name" varchar(50),
  "schema_type" varchar(5) UNIQUE
);

CREATE TABLE "scr_images" (
  "image_id" uuid PRIMARY KEY,
  "image_set_id" uuid,
  "filename" varchar(50),
  "uploaded" varchar(50),
  "url" varchar(255),
  "orientation" char(3)
);

CREATE TABLE "scr_hubs" (
  "hub_id" uuid PRIMARY KEY,
  "region" varchar(6),
  "image_set_id" uuid UNIQUE,
  "hub_name" varchar(50),
  "hub" varchar(6) UNIQUE,
  "latitude" numeric(8,6),
  "longitude" numeric(8,6)
);

CREATE TABLE "scr_regions" (
  "region_id" uuid PRIMARY KEY,
  "image_set_id" uuid UNIQUE,
  "region_name" varchar(50),
  "region" varchar(6) UNIQUE
);

CREATE TABLE "scr_image_sets" (
  "image_set_id" uuid PRIMARY KEY,
  "schema_type" varchar(5)
);

CREATE TABLE "scr_user_roles" (
  "user_role_id" uuid PRIMARY KEY,
  "user_role" varchar(6) UNIQUE,
  "user_role_name" varchar(50)
);

CREATE TABLE "scr_countries" (
  "country_id" uuid PRIMARY KEY,
  "country_code" varchar(2) UNIQUE,
  "country" varchar(50)
);

CREATE TABLE "scr_users" (
  "user_id" uuid PRIMARY KEY,
  "user_role" varchar(50),
  "country_code" varchar(2),
  "image_set_id" uuid UNIQUE,
  "first_name" varchar(50),
  "last_name" varchar(50),
  "email" varchar(100),
  "hash" varchar(256),
  "salt" varchar(128)
);

CREATE INDEX ON "scr_places" ("image_set_id");

CREATE INDEX ON "scr_images" ("image_set_id");

CREATE INDEX ON "scr_hubs" ("image_set_id");

CREATE INDEX ON "scr_regions" ("image_set_id");

CREATE INDEX ON "scr_users" ("image_set_id");

ALTER TABLE "scr_users" ADD FOREIGN KEY ("user_role") REFERENCES "scr_user_roles" ("user_role");

ALTER TABLE "scr_users" ADD FOREIGN KEY ("country_code") REFERENCES "scr_countries" ("country_code");

ALTER TABLE "scr_users" ADD FOREIGN KEY ("image_set_id") REFERENCES "scr_image_sets" ("image_set_id");

ALTER TABLE "scr_image_sets" ADD FOREIGN KEY ("schema_type") REFERENCES "scr_schema_types" ("schema_type");

ALTER TABLE "scr_images" ADD FOREIGN KEY ("image_set_id") REFERENCES "scr_image_sets" ("image_set_id");

ALTER TABLE "scr_regions" ADD FOREIGN KEY ("image_set_id") REFERENCES "scr_image_sets" ("image_set_id");

ALTER TABLE "scr_hubs" ADD FOREIGN KEY ("region") REFERENCES "scr_regions" ("region");

ALTER TABLE "scr_hubs" ADD FOREIGN KEY ("image_set_id") REFERENCES "scr_image_sets" ("image_set_id");

ALTER TABLE "scr_places" ADD FOREIGN KEY ("hub") REFERENCES "scr_hubs" ("hub");

ALTER TABLE "scr_places" ADD FOREIGN KEY ("schema_type") REFERENCES "scr_schema_types" ("schema_type");

ALTER TABLE "scr_places" ADD FOREIGN KEY ("image_set_id") REFERENCES "scr_image_sets" ("image_set_id");

ALTER TABLE "scr_lodging" ADD FOREIGN KEY ("place_id") REFERENCES "scr_places" ("place_id");

ALTER TABLE "scr_restaurants" ADD FOREIGN KEY ("place_id") REFERENCES "scr_places" ("place_id");

ALTER TABLE "scr_waterfalls" ADD FOREIGN KEY ("place_id") REFERENCES "scr_places" ("place_id");
