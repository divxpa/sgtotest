ALTER TABLE ssp.localidad ADD Aniversario DATE AFTER CodigoPostal;

ALTER TABLE ssp.localidad
 ADD Categoria INT UNSIGNED COMMENT '1=1era 2=2da 3=3era 4=com. fomento' AFTER Aniversario,
 ADD Autoridad VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci,
 ADD FotoAutoridad VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci,
 ADD FotoEscudo VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci,
 ADD FotoLocalidad VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci;

update localidad set Aniversario='1999-08-27', Categoria=4, Autoridad='Sra. Viviana A. Moyano'  where IdLocalidad=5;
update localidad set Aniversario='1915-10-20', Categoria=2, Autoridad='Lic. Andrés G. Méndez', FotoEscudo='upload/localidad/escudo_alumine.jpg'  where IdLocalidad=9;
update localidad set Aniversario='1907-10-26', Categoria=2, Autoridad='Sr. Raúl Aravena', FotoEscudo='upload/localidad/escudo_andacollo.jpg'  where IdLocalidad=10;
update localidad set Aniversario='1915-10-20', Categoria=2, Autoridad='Sr. Darío Andrés Díaz', FotoEscudo='upload/localidad/escudo_anelo.jpg'  where IdLocalidad=11;
update localidad set Aniversario='1938-10-26', Categoria=3, Autoridad='Sr. Mario José Castro'  where IdLocalidad=24;
update localidad set Aniversario='1972-08-01', Categoria=3, Autoridad='Sr. Juvenal Urrutia', FotoEscudo='upload/localidad/escudo_barrancas.jpg'  where IdLocalidad=31;
update localidad set Aniversario='1931-11-06', Categoria=2, Autoridad='Sr. Hugo Horacio Salazar', FotoEscudo='upload/localidad/escudo_butaranquil.jpg'  where IdLocalidad=37;
update localidad set Aniversario='1986-04-08', Categoria=3, Autoridad='Sr. Oscar Mansegosa', FotoEscudo='upload/localidad/escudo_caviahue.jpg'  where IdLocalidad=62;
update localidad set Aniversario='1986-04-08', Categoria=3, Autoridad='Sr. Oscar Mansegosa', FotoEscudo='upload/localidad/escudo_caviahue.jpg'  where IdLocalidad=102;
update localidad set Aniversario='1922-10-11', Categoria=1, Autoridad='Sr. Javier César Bertoldi', FotoEscudo='upload/localidad/escudo_centenario.jpg', FotoAutoridad='upload/localidad/autoridad_centenario.jpg', FotoLocalidad='upload/localidad/localidad_centenario.jpg'  where IdLocalidad=64;
update localidad set Aniversario='1986-09-24', Categoria=4, Autoridad='Sr. José Victoriano Burnes'  where IdLocalidad=92;
update localidad set Aniversario='04/08/1887', Categoria=1, Autoridad='Cr. Rolando C. Figueroa', FotoEscudo='upload/localidad/escudo_chosmalal.jpg'  where IdLocalidad=93;
update localidad set Aniversario='1997-08-15', Categoria=4, Autoridad='Sr. Sergio Ariel Montecino'  where IdLocalidad=108;
update localidad set Aniversario='1999-05-07', Categoria=4, Autoridad='Sr. Domingo Rodríguez'  where IdLocalidad=111;
update localidad set Aniversario='1933-10-22', Categoria=1, Autoridad='Prof. Ramón Rioseco', FotoEscudo='upload/localidad/escudo_cutralco.jpg'  where IdLocalidad=116;
update localidad set Aniversario='1910-05-09', Categoria=3, Autoridad='Sr. Eduardo Carrasco'  where IdLocalidad=123;
update localidad set Aniversario='1933-02-01', Categoria=3, Autoridad='Sr. David Jesús Sánchez', FotoEscudo='upload/localidad/escudo_elhuecu.jpg'  where IdLocalidad=129;
update localidad set Aniversario='1988-05-27', Categoria=4, Autoridad='Sr. Fabián Edgardo Lauquén'  where IdLocalidad=141;
update localidad set Aniversario='1964-04-16', Categoria=3, Autoridad='Sr. Ceferino Víctor Moya', FotoEscudo='upload/localidad/escudo_huinganco.jpg'  where IdLocalidad=169;
update localidad set Aniversario='15/02/1883', Categoria=1, Autoridad='Sr. Juan Domingo Linares', FotoEscudo='upload/localidad/escudo_junindelosandes.jpg'  where IdLocalidad=177;
update localidad set Aniversario='1926-10-26', Categoria=3, Autoridad='Sr. Mercedes Lucrecio Varela', FotoEscudo='upload/localidad/escudo_lascoloradas.jpg'  where IdLocalidad=221;
update localidad set Aniversario='08/02/1897', Categoria=2, Autoridad='Sr. Raúl Monti', FotoEscudo='upload/localidad/escudo_laslajas.jpg'  where IdLocalidad=225;
update localidad set Aniversario='1937-05-21', Categoria=3, Autoridad='Sr. Nicomedes Navarrete', FotoEscudo='upload/localidad/escudo_lasovejas.jpg'  where IdLocalidad=228;
update localidad set Aniversario='1915-10-20', Categoria=2, Autoridad='Profa. María Fernanda Villone', FotoEscudo='upload/localidad/escudo_loncopue.jpg'  where IdLocalidad=244;
update localidad set Aniversario='1997-08-15', Categoria=4, Autoridad='Sr. Ramón Mercado'  where IdLocalidad=247;
update localidad set Aniversario='1996-09-17', Categoria=4, Autoridad='Sr. Gabriel F. Rojas'  where IdLocalidad=249;
update localidad set Aniversario='1988-04-21', Categoria=4, Autoridad='Sra. Graciela Noemi Arévalo'  where IdLocalidad=156;
update localidad set Aniversario='1973-10-24', Categoria=3, Autoridad='Sr. Victor Ortega', FotoEscudo='upload/localidad/escudo_losmiches.jpg'  where IdLocalidad=255;
update localidad set Aniversario='1988-04-21', Categoria=4, Autoridad='Sr. Alfonso Rubén Aravena', FotoEscudo='upload/localidad/escudo_manzanoamargo.jpg'  where IdLocalidad=276;
update localidad set Aniversario='1941-10-10', Categoria=2, Autoridad='Sr. Ramón Donato Zúñiga'  where IdLocalidad=278;
update localidad set Aniversario='1904-09-12', Categoria=1, Autoridad='D. Horacio Quiroga', FotoEscudo='upload/localidad/escudo_neuquen.jpg', FotoAutoridad='upload/localidad/autoridad_neuquen.jpg', FotoLocalidad='upload/localidad/localidad_neuquen.jpg'  where IdLocalidad=292;
update localidad set Aniversario='1973-12-15', Categoria=4, Autoridad='Sra. Silvia Cruces'  where IdLocalidad=297;
update localidad set Aniversario='1985-12-05', Categoria=4, Autoridad='Sr. Martin A. Carrupán'  where IdLocalidad=309;
update localidad set Aniversario='1971-12-12', Categoria=2, Autoridad='Sr. Clemente Casamajou', FotoEscudo='upload/localidad/escudo_picunleufu.jpg', FotoAutoridad='upload/localidad/autoridad_picunleufu.jpg', FotoLocalidad='upload/localidad/localidad_picunleufu.jpg'  where IdLocalidad=321;
update localidad set Aniversario='1987-04-08', Categoria=2, Autoridad='Sra. María Adriana Figueroa', FotoEscudo='upload/localidad/escudo_piedradelaguila.jpg'  where IdLocalidad=322;
update localidad set Aniversario='1998-04-07', Categoria=4, Autoridad='Sr. Norberto A. Ocares'  where IdLocalidad=327;
update localidad set Aniversario='1966-04-24', Categoria=1, Autoridad='Lic. Juan Carlos Giannattasio', FotoEscudo='upload/localidad/escudo_plazahuincul.jpg'  where IdLocalidad=331;
update localidad set Aniversario='1935-03-26', Categoria=1, Autoridad='Lic. Andrés Arturo Peressini', FotoEscudo='upload/localidad/escudo_plottier.jpg'  where IdLocalidad=332;
update localidad set Aniversario='1991-05-02', Categoria=4, Autoridad='Sr. Altidoro José López  '  where IdLocalidad=350;
update localidad set Aniversario='1998-02-27', Categoria=4, Autoridad='Sr. Hugo O. Sánchez'  where IdLocalidad=359;
update localidad set Aniversario='1971-12-20', Categoria=1, Autoridad='Sr. Marcelo Rucci', FotoEscudo='upload/localidad/escudo_rincondelossauces.jpg'  where IdLocalidad=368;
update localidad set Aniversario='04/02/1898', Categoria=1, Autoridad='Sr. Juan Carlos Fernández ', FotoEscudo='upload/localidad/escudo_sanmartindelosandes.jpg'  where IdLocalidad=381;
update localidad set Aniversario='1973-05-21', Categoria=1, Autoridad='Sr. Ramón Ángel Soto', FotoEscudo='upload/localidad/escudo_sanpatriciodelchanar.jpg'  where IdLocalidad=382;
update localidad set Aniversario='1975-11-19', Categoria=4, Autoridad='Sr. Rafael A. Vasquez '  where IdLocalidad=389;
update localidad set Aniversario='1989-04-01', Categoria=4, Autoridad='Sr. Zenón Vicente Sandoval'  where IdLocalidad=390;
update localidad set Aniversario='1951-07-26', Categoria=1, Autoridad='Sr. Hugo Moenne', FotoEscudo='upload/localidad/escudo_senillosa.jpg'  where IdLocalidad=391;
update localidad set Aniversario='1969-05-30', Categoria=3, Autoridad='Sr. Juan Carlos Montesino'  where IdLocalidad=393;
update localidad set Aniversario='1911-03-10', Categoria=3, Autoridad='Sr. Paulo Martín González', FotoEscudo='upload/localidad/escudo_tricaomalal.jpg'  where IdLocalidad=404;
update localidad set Aniversario='1973-10-16', Categoria=4, Autoridad='Sr. Martín Emiliano Medel'  where IdLocalidad=409;
update localidad set Aniversario='1988-03-11', Categoria=4, Autoridad='Sr. Adolfo Pérez'  where IdLocalidad=410;
update localidad set Aniversario='1989-04-17', Categoria=4, Autoridad='Sr. Héctor Octavio Latorre'  where IdLocalidad=288;
update localidad set Aniversario='1975-10-31', Categoria=3, Autoridad='Sr. Nicolás Di Fonzo', FotoEscudo='upload/localidad/escudo_villaelchocon.jpg'  where IdLocalidad=411;
update localidad set Aniversario='1932-05-15', Categoria=1, Autoridad='Prof. Roberto Enrique  Cacault', FotoEscudo='upload/localidad/escudo_villalaangostura.jpg'  where IdLocalidad=412;
update localidad set Aniversario='1989-01-18', Categoria=3, Autoridad='Sr. Sandro Badilla', FotoEscudo='upload/localidad/escudo_villapehuenia.jpg'  where IdLocalidad=414;
update localidad set Aniversario='1936-10-30', Categoria=4, Autoridad='Sr. Nicolas Osvaldo Lagos', FotoEscudo='upload/localidad/escudo_villatraful.jpg'  where IdLocalidad=417;
update localidad set Aniversario='1955-12-18', Categoria=2, Autoridad='Sr. Gabino Calixto Jofré', FotoEscudo='upload/localidad/escudo_vistaalegre.jpg'  where IdLocalidad=419;
update localidad set Aniversario='1955-12-18', Categoria=2, Autoridad='Sr. Gabino Calixto Jofré', FotoEscudo='upload/localidad/escudo_vistaalegre.jpg'  where IdLocalidad=420;
update localidad set Aniversario='1913-07-12', Categoria=1, Autoridad='Dra. María  Soledad Martínez', FotoEscudo='upload/localidad/escudo_zapala.jpg'  where IdLocalidad=422;


insert into rol (Nombre) VALUES ('RELACIONES INSTITUCIONALES');
update menu set Orden=6 where Nombre='Reportes';
insert into menu (IdMenuContenedor, IdPagina, Nombre, Orden, Target, Activo) VALUES (null, null, 'Rel. Instituc.', 5, '_self', 1);
insert into pagina (Pagina, Descripcion, Activa, IdMenuActivo) VALUES ('Prensa.Home', 'Aniversarios', 1, (select IdMenu from menu where Nombre='Rel. Instituc.'));
insert into menu (IdMenuContenedor, IdPagina, Nombre, Orden, Target, Activo) VALUES (22, (select IdPagina from pagina where Pagina='Prensa.Home'), 'Aniversarios', null, '_self', 1);
insert into rolpagina (IdRol, IdPagina) VALUES ((select IdRol from rol where Nombre='RELACIONES INSTITUCIONALES'), (select IdPagina from pagina where Pagina='Prensa.Home'));
insert into rolpagina (IdRol, IdPagina) VALUES ((select IdRol from rol where Nombre='RELACIONES INSTITUCIONALES'), 1);
insert into rolpagina (IdRol, IdPagina) VALUES ((select IdRol from rol where Nombre='RELACIONES INSTITUCIONALES'), 2);
insert into rolpagina (IdRol, IdPagina) VALUES ((select IdRol from rol where Nombre='RELACIONES INSTITUCIONALES'), 3);
insert into rolpagina (IdRol, IdPagina) VALUES ((select IdRol from rol where Nombre='RELACIONES INSTITUCIONALES'), 4);

insert into pagina (Pagina, Descripcion, Activa, IdMenuActivo) VALUES ('Prensa.Aniversario', 'Aniversario', 1, (select IdMenu from menu where Nombre='Rel. Instituc.'));
insert into rolpagina (IdRol, IdPagina) VALUES ((select IdRol from rol where Nombre='RELACIONES INSTITUCIONALES'), (select IdPagina from pagina where Pagina='Prensa.Aniversario'));