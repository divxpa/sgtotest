CREATE TABLE `redeterminacion` (
  `IdRedeterminacion` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IdContrato` int(10) unsigned NOT NULL,
  `Fecha` date NOT NULL,
  `NormaLegalAprobacion` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  `Importe` decimal(14,2) NOT NULL,
  PRIMARY KEY (`IdRedeterminacion`),
  KEY `fk_redeterminacion_contrato` (`IdContrato`),
  CONSTRAINT `fk_redeterminacion_contrato` FOREIGN KEY (`IdContrato`) REFERENCES `contrato` (`IdContrato`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
