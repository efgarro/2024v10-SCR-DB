-- scr_schema_types

INSERT INTO scr_schema_types(schema_type_id,schema_type,schema_type_name) VALUES ('018e20ea-7585-7d81-bcab-6fbeb701e61e','users','Users');
INSERT INTO scr_schema_types(schema_type_id,schema_type,schema_type_name) VALUES ('018e20ea-7588-71ca-b77e-6e14f491751d','lodge','Lodging');
INSERT INTO scr_schema_types(schema_type_id,schema_type,schema_type_name) VALUES ('018e20ea-7588-71ca-b77e-6e15f22c724f','resta','Restaurants');
INSERT INTO scr_schema_types(schema_type_id,schema_type,schema_type_name) VALUES ('018e20ea-7588-71ca-b77e-6e175d7f107a','trail','Hiking Trails');
INSERT INTO scr_schema_types(schema_type_id,schema_type,schema_type_name) VALUES ('018e20ea-7588-71ca-b77e-6e163377e646','wfall','Waterfalls');
INSERT INTO scr_schema_types(schema_type_id,schema_type,schema_type_name) VALUES ('0190c60d-554f-767f-a512-00df3c7da50c','hub--','Hub');
INSERT INTO scr_schema_types(schema_type_id,schema_type,schema_type_name) VALUES ('0190c5a2-a83c-7009-a375-559ddf73106d','rgion','Region');

INSERT INTO scr_image_sets(image_set_id,schema_type) VALUES ('0190c390-2168-7d7a-afb2-7190a890cd5e','rgion');
INSERT INTO scr_image_sets(image_set_id,schema_type) VALUES ('0190c390-216b-7e4d-9eb1-d5fbb1acb72b','rgion');
INSERT INTO scr_image_sets(image_set_id,schema_type) VALUES ('0190c390-216b-7e4d-9eb1-d5fdb8da1b52','rgion');
INSERT INTO scr_image_sets(image_set_id,schema_type) VALUES ('0190c390-216b-7e4d-9eb1-d5fc2bfaae69','rgion');

INSERT INTO scr_image_sets(image_set_id,schema_type) VALUES ('0190c3f6-1eda-7429-9655-ef86e7b4385d','hub--');
INSERT INTO scr_image_sets(image_set_id,schema_type) VALUES ('0190c3f6-1edc-78f1-9443-8989ee63f136','hub--');
INSERT INTO scr_image_sets(image_set_id,schema_type) VALUES ('0190c3f6-1edc-78f1-9443-89884a9d8ad8','hub--');
INSERT INTO scr_image_sets(image_set_id,schema_type) VALUES ('0190c3f6-1edc-78f1-9443-898a0eb37bcc','hub--');
INSERT INTO scr_image_sets(image_set_id,schema_type) VALUES ('0190c3f6-1edd-7a06-935f-8db8a6dcf8c6','hub--');
INSERT INTO scr_image_sets(image_set_id,schema_type) VALUES ('0190c3f6-1edd-7a06-935f-8db9167d3b5e','hub--');
INSERT INTO scr_image_sets(image_set_id,schema_type) VALUES ('0190c3f6-1edd-7a06-935f-8dbae2fa27a4','hub--');
INSERT INTO scr_image_sets(image_set_id,schema_type) VALUES ('0190c3f6-1edd-7a06-935f-8dbbea7b9cab','hub--');
INSERT INTO scr_image_sets(image_set_id,schema_type) VALUES ('0190c3f6-1edd-7a06-935f-8dbc40aa61be','hub--');


INSERT INTO scr_regions(region_id,image_set_id,region_name,region) VALUES ('0190c374-d611-716f-8f87-29523d088d26','0190c390-2168-7d7a-afb2-7190a890cd5e','Caribe','caribe');
INSERT INTO scr_regions(region_id,image_set_id,region_name,region) VALUES ('0190c374-d614-7633-8070-e0516d1afd9d','0190c390-216b-7e4d-9eb1-d5fbb1acb72b','Guanacaste','guanac');
INSERT INTO scr_regions(region_id,image_set_id,region_name,region) VALUES ('0190c374-d614-7633-8070-e0521cc6a1f8','0190c390-216b-7e4d-9eb1-d5fdb8da1b52','Zona Sur','zonsur');
INSERT INTO scr_regions(region_id,image_set_id,region_name,region) VALUES ('0190c374-d614-7633-8070-e05326dc2a82','0190c390-216b-7e4d-9eb1-d5fc2bfaae69','Pacifico Central','pactrl');


INSERT INTO scr_hubs(hub_id,region,image_set_id,hub_name,hub,Latitude,Longitude) VALUES ('0190c372-ffe0-797f-a6f5-a8e8854c64b7','caribe','0190c3f6-1eda-7429-9655-ef86e7b4385d','Ciudad Limon','climon',9.99077,-83.03105);
INSERT INTO scr_hubs(hub_id,region,image_set_id,hub_name,hub,Latitude,Longitude) VALUES ('0190c373-0019-710d-98c8-3de7a9ccd6aa','caribe','0190c3f6-1edc-78f1-9443-8989ee63f136','Puerto Viejo','ptovjo',9.65612,-82.75216);
INSERT INTO scr_hubs(hub_id,region,image_set_id,hub_name,hub,Latitude,Longitude) VALUES ('0190c373-0019-710d-98c8-3de8a68810d6','guanac','0190c3f6-1edc-78f1-9443-89884a9d8ad8','Tamarindo','tmrndo',10.30082,-85.84005);
INSERT INTO scr_hubs(hub_id,region,image_set_id,hub_name,hub,Latitude,Longitude) VALUES ('0190c373-0019-710d-98c8-3dea86e85f3a','guanac','0190c3f6-1edc-78f1-9443-898a0eb37bcc','Santa Cruz','stacrz',10.26304,-85.58588);
INSERT INTO scr_hubs(hub_id,region,image_set_id,hub_name,hub,Latitude,Longitude) VALUES ('0190c373-0019-710d-98c8-3de94ce04342','guanac','0190c3f6-1edd-7a06-935f-8db8a6dcf8c6','Nicoya','nicoya',10.14858,-85.45381);
INSERT INTO scr_hubs(hub_id,region,image_set_id,hub_name,hub,Latitude,Longitude) VALUES ('0190c373-0019-710d-98c8-3debd3804cb5','guanac','0190c3f6-1edd-7a06-935f-8db9167d3b5e','Liberia','lberia',10.62967,-85.4382);
INSERT INTO scr_hubs(hub_id,region,image_set_id,hub_name,hub,Latitude,Longitude) VALUES ('0190c373-0019-710d-98c8-3deca3d0218a','zonsur','0190c3f6-1edd-7a06-935f-8dbae2fa27a4','Perez Zeledon','perzel',9.3739,-83.70303);
INSERT INTO scr_hubs(hub_id,region,image_set_id,hub_name,hub,Latitude,Longitude) VALUES ('0190c373-0019-710d-98c8-3ded5d0d98da','pactrl','0190c3f6-1edd-7a06-935f-8dbbea7b9cab','Dominical','domcal',9.25555,-83.86293);
INSERT INTO scr_hubs(hub_id,region,image_set_id,hub_name,hub,Latitude,Longitude) VALUES ('0190c373-0019-710d-98c8-3deea928e704','pactrl','0190c3f6-1edd-7a06-935f-8dbc40aa61be','Jaco / Herradura','jacher',9.6182,-84.63153);


