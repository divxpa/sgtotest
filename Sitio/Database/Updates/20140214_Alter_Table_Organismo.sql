ALTER TABLE organismo ADD Color VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_spanish_ci AFTER Comitente;
update organismo set Color='909aff' where IdOrganismo=1;
update organismo set Color='ff8822' where IdOrganismo=2;
update organismo set Color='ee90ff' where IdOrganismo=6;
update organismo set Color='000000' where IdOrganismo not in (1,2,6);

ALTER TABLE localidad ADD Zona VARCHAR(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci COMMENT '(N)orte (C)entro (S)ur Con(F)luencia' AFTER FotoLocalidad;

update localidad set Zona='N' where IdLocalidad in (31, 37, 38, 62, 76, 172, 276);
update localidad set Zona='S' where IdLocalidad in (61, 177);
update localidad set Zona='F' where IdLocalidad in (64, 338);
update localidad set Zona='C' where IdLocalidad in (278);
