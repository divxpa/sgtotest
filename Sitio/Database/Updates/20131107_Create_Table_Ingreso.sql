CREATE TABLE ssp.ingreso (
   IdIngreso INT(10) UNSIGNED AUTO_INCREMENT NOT NULL,
   IdUsuario INT(10) UNSIGNED NOT NULL,
   FechaHoraLogin DATETIME NOT NULL,
   FechaHoraLogout DATETIME,
  PRIMARY KEY (IdIngreso),
  KEY fk_ingreso_usuario (IdUsuario),
  CONSTRAINT fk_ingreso_usuario FOREIGN KEY (IdUsuario) REFERENCES usuario (IdUsuario) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;

ALTER TABLE ssp.ingreso ADD Ip VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL AFTER IdUsuario;
