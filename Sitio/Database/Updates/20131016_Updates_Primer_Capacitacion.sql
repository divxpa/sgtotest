ALTER TABLE recepcioncontrato ADD PorcentajeRecepcion DECIMAL(5,2) UNSIGNED NOT NULL;
ALTER TABLE obraestado ADD DetalleEstado TEXT CHARACTER SET utf8 COLLATE utf8_spanish_ci;
ALTER TABLE obra ADD DetalleEstado TEXT CHARACTER SET utf8 COLLATE utf8_spanish_ci;

CREATE TABLE ordentrabajo (
   IdOrdenTrabajo INT(10) UNSIGNED AUTO_INCREMENT NOT NULL,
   IdContrato INT(10) UNSIGNED NOT NULL,
   Numero INT(3) UNSIGNED NOT NULL,
   NormaLegalAutorizacion VARCHAR(10) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
   Monto DECIMAL(14,2) UNSIGNED NOT NULL,
  CONSTRAINT fk_ordentrabajo_contrato FOREIGN KEY (IdContrato) REFERENCES ssp.contrato (IdContrato) ON UPDATE NO ACTION ON DELETE NO ACTION,
  PRIMARY KEY (IdOrdenTrabajo)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;

ALTER TABLE certificacion
 ADD RedeterminacionPrecios DECIMAL(14,2) AFTER Observaciones,
 ADD RetencionFondoReparo DECIMAL(14,2),
 ADD TipoCertificado INT(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '0 Obra, 1 Anticipo, 2 Redeterminacion',
 ADD IdOrdenTrabajo INT(10) UNSIGNED;
 
ALTER TABLE certificacion ADD CONSTRAINT fk_certificacion_ordentrabajo FOREIGN KEY (IdOrdenTrabajo) REFERENCES ordentrabajo (IdOrdenTrabajo) ON UPDATE NO ACTION ON DELETE NO ACTION;

CREATE TABLE ordentrabajolocalidad (
   IdOrdenTrabajo INT(10) UNSIGNED NOT NULL,
   IdLocalidad INT(10) UNSIGNED NOT NULL,
  CONSTRAINT fk_ordentrabajolocalidad_ordentrabajo FOREIGN KEY (IdOrdenTrabajo) REFERENCES ordentrabajo (IdOrdenTrabajo) ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_ordentrabajolocalidad_localidad FOREIGN KEY (IdLocalidad) REFERENCES localidad (IdLocalidad) ON UPDATE NO ACTION ON DELETE NO ACTION,
  PRIMARY KEY (IdOrdenTrabajo, IdLocalidad)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;

CREATE TABLE ordentrabajodeductivo (
   IdOrdenTrabajoDeductivo INT(10) UNSIGNED AUTO_INCREMENT NOT NULL,
   IdOrdenTrabajo INT(10) UNSIGNED NOT NULL,
   Importe DECIMAL(14,2) NOT NULL,
  CONSTRAINT fk_ordentrabajodeductivo_ordentrabajo FOREIGN KEY (IdOrdenTrabajo) REFERENCES ordentrabajo (IdOrdenTrabajo) ON UPDATE NO ACTION ON DELETE NO ACTION,
  PRIMARY KEY (IdOrdenTrabajoDeductivo)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;

ALTER TABLE ordentrabajodeductivo
 ADD Fecha DATE NOT NULL AFTER Importe,
 ADD NormaLegalAprobacion VARCHAR(10) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL;
 
ALTER TABLE certificacion CHANGE NroCertificado NroCertificado INT(3) UNSIGNED;

insert into rol (Nombre) VALUES ('CONSULTA');
insert into rolpagina (IdRol, IdPagina) VALUES ((select IdRol from rol where Nombre='CONSULTA'), (select IdPagina from pagina where Pagina='Login'));
insert into rolpagina (IdRol, IdPagina) VALUES ((select IdRol from rol where Nombre='CONSULTA'), (select IdPagina from pagina where Pagina='Logout'));
insert into rolpagina (IdRol, IdPagina) VALUES ((select IdRol from rol where Nombre='CONSULTA'), (select IdPagina from pagina where Pagina='Home'));
insert into rolpagina (IdRol, IdPagina) VALUES ((select IdRol from rol where Nombre='CONSULTA'), (select IdPagina from pagina where Pagina='CambioPassword'));
insert into rolpagina (IdRol, IdPagina) VALUES ((select IdRol from rol where Nombre='CONSULTA'), (select IdPagina from pagina where Pagina='Obra.Home'));
insert into rolpagina (IdRol, IdPagina) VALUES ((select IdRol from rol where Nombre='CONSULTA'), (select IdPagina from pagina where Pagina='Obra.Contrato.Home'));
insert into rolpagina (IdRol, IdPagina) VALUES ((select IdRol from rol where Nombre='CONSULTA'), (select IdPagina from pagina where Pagina='Obra.Contrato.Certificacion.Home'));
insert into rolpagina (IdRol, IdPagina) VALUES ((select IdRol from rol where Nombre='CONSULTA'), (select IdPagina from pagina where Pagina='Tesoreria.Pago.Home'));
insert into rolpagina (IdRol, IdPagina) VALUES ((select IdRol from rol where Nombre='CONSULTA'), (select IdPagina from pagina where Pagina='Tesoreria.Pago.PagosByCertificado'));

insert into pagina (Pagina, Descripcion, Activa, IdMenuActivo) VALUES ('Obra.Contrato.OrdenTrabajo.Update', 'Órdenes de Trabajo ABM', 1, (select IdMenu from menu where Nombre='Obras'));
insert into rolpagina (IdRol, IdPagina) VALUES (2, (select IdPagina from pagina where Pagina='Obra.Contrato.OrdenTrabajo.Update'));
insert into rolpagina (IdRol, IdPagina) VALUES (3, (select IdPagina from pagina where Pagina='Obra.Contrato.OrdenTrabajo.Update'));

insert into pagina (Pagina, Descripcion, Activa, IdMenuActivo) VALUES ('Obra.Contrato.OrdenTrabajo.Deductivo.Update', 'Deductivos de Órdenes de Trabajo ABM', 1, (select IdMenu from menu where Nombre='Obras'));
insert into rolpagina (IdRol, IdPagina) VALUES (2, (select IdPagina from pagina where Pagina='Obra.Contrato.OrdenTrabajo.Deductivo.Update'));
insert into rolpagina (IdRol, IdPagina) VALUES (3, (select IdPagina from pagina where Pagina='Obra.Contrato.OrdenTrabajo.Deductivo.Update'));

DROP PROCEDURE IF EXISTS spRecalcularCertificaciones;
CREATE PROCEDURE spRecalcularCertificaciones(pIdContrato INT)
BEGIN
  DECLARE vMontoTotal DECIMAL(14,2);
	select co.Monto + ifnull((select sum(Importe*(case when AdicionalDeductivo=0 then 1 else -1 end)) from alteracion where IdContrato=co.IdContrato),0) into vMontoTotal from contrato co where co.IdContrato=pIdContrato;
  update certificacion set PorcentajeAvance = (MontoAvance / vMontoTotal * 100) where IdContrato=pIdContrato and IdOrdenTrabajo is null;
END;

DROP PROCEDURE IF EXISTS spRecalcularCertificacionesOT;
CREATE PROCEDURE spRecalcularCertificacionesOT(pIdOrdenTrabajo INT)
BEGIN
  DECLARE vMontoTotal DECIMAL(14,2);
	select ot.Monto - ifnull((select sum(Importe) from ordentrabajodeductivo where IdOrdenTrabajo=ot.IdOrdenTrabajo),0) into vMontoTotal from ordentrabajo ot where ot.IdOrdenTrabajo=pIdOrdenTrabajo;
  update certificacion set PorcentajeAvance = (MontoAvance / vMontoTotal * 100) where IdOrdenTrabajo=pIdOrdenTrabajo;
END;
