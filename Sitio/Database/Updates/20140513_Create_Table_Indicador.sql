﻿CREATE TABLE indicador (
   IdIndicador INT UNSIGNED AUTO_INCREMENT NOT NULL,
   Nombre VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
   Query TEXT CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
   Activo INT(1) UNSIGNED NOT NULL,
  PRIMARY KEY (IdIndicador)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;

