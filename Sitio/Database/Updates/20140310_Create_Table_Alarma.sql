CREATE TABLE alarma (
  IdAlarma int(10) unsigned NOT NULL AUTO_INCREMENT,
  Nombre varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  Query text COLLATE utf8_spanish_ci NOT NULL,
  Activo int(1) unsigned NOT NULL DEFAULT '1',
  Alcance int(1) unsigned NOT NULL DEFAULT '3' COMMENT '1. Sgo 2. Tablero 3. Todos',
  PRIMARY KEY (`IdAlarma`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE alarmarol (
   IdAlarma INT UNSIGNED NOT NULL,
   IdRol INT UNSIGNED NOT NULL,
  CONSTRAINT fk_alarmarol_alarma FOREIGN KEY (IdAlarma) REFERENCES ssp.alarma (IdAlarma) ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_alarmarol_rol FOREIGN KEY (IdRol) REFERENCES ssp.rol (IdRol) ON UPDATE NO ACTION ON DELETE NO ACTION,
  PRIMARY KEY (IdAlarma, IdRol)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;

CREATE TABLE alarmausuario (
   IdAlarmaUsuario INT UNSIGNED AUTO_INCREMENT NOT NULL,
   IdAlarma INT UNSIGNED NOT NULL,
   IdUsuario INT UNSIGNED NOT NULL,
   FechaHora DATETIME NOT NULL,
  CONSTRAINT fk_alarmausuario_alarma FOREIGN KEY (IdAlarma) REFERENCES ssp.alarma (IdAlarma) ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_alarmausuario_usuario FOREIGN KEY (IdUsuario) REFERENCES ssp.usuario (IdUsuario) ON UPDATE NO ACTION ON DELETE NO ACTION,
  PRIMARY KEY (IdAlarmaUsuario)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;

ALTER TABLE alarmausuario ADD Cantidad INT UNSIGNED NOT NULL;

insert into pagina (Pagina,Descripcion,Activa,IdMenuActivo) VALUES ('DetalleAlarma','Detalle de alarma',1,1);
insert into rolpagina (IdRol,IdPagina) select IdRol, (select IdPagina from pagina where Pagina='DetalleAlarma') from rol;

ALTER TABLE alarma ADD Tipo VARCHAR(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL COMMENT '(D)atos (G)estion';

insert into pagina (Pagina,Descripcion,Activa,IdMenuActivo) VALUES ('DetalleAlarmaObra','Detalle de alarma por obra',1,1);
insert into rolpagina (IdRol,IdPagina) select IdRol, (select IdPagina from pagina where Pagina='DetalleAlarmaObra') from rol;

CREATE TABLE ssp.alarmausuariodetalle (
   IdAlarmaUsuarioDetalle INT UNSIGNED AUTO_INCREMENT NOT NULL,
   IdAlarmaUsuario INT UNSIGNED NOT NULL,
   IdObra INT UNSIGNED NOT NULL,
  CONSTRAINT fk_alarmausuariodet_alarmausuario FOREIGN KEY (IdAlarmaUsuario) REFERENCES ssp.alarmausuario (IdAlarmaUsuario) ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_alarmausuariodet_obra FOREIGN KEY (IdObra) REFERENCES ssp.obra (IdObra) ON UPDATE NO ACTION ON DELETE NO ACTION,
  PRIMARY KEY (IdAlarmaUsuarioDetalle)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;
