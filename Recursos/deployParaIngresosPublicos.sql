-- En Produccion
-- CREATE TABLE `contratoitempadre` (
--   `idContratoItemPadre` int(10) unsigned NOT NULL AUTO_INCREMENT,
--   `IdContrato` int(10) unsigned NOT NULL,
--   `Orden` int(10) unsigned NOT NULL,
--   `Item` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
--   PRIMARY KEY (`idContratoItemPadre`),
--   KEY `fk_contratoitempadre_contrato` (`IdContrato`),
--   CONSTRAINT `fk_contratoitempadre_contrato` FOREIGN KEY (`IdContrato`) REFERENCES `contrato` (`IdContrato`) ON DELETE NO ACTION ON UPDATE NO ACTION
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;


-- En Produccion
-- CREATE TABLE `contratoitem` (
--   `IdContratoItem` int(10) unsigned NOT NULL AUTO_INCREMENT,
--   `IdContrato` int(10) unsigned NOT NULL,
--   `Item` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
--   `Cantidad` decimal(14,2) unsigned NOT NULL,
--   `UnidadMedida` int(2) unsigned NOT NULL COMMENT '0. gl 1.ml 2.m2 3.m3 4.lt 5.kg 6.u 7.pza 8.cto 9ha',
--   `PrecioUnitario` decimal(14,2) unsigned NOT NULL,
--   `PrecioTotal` decimal(14,2) unsigned NOT NULL,
--   `Orden` int(10) unsigned NOT NULL,
--   `IdContratoItemPadre` int(10) unsigned,
--   PRIMARY KEY (`IdContratoItem`),
--   KEY `fk_contratoitem_contrato` (`IdContrato`),
--   CONSTRAINT `fk_contratoitem_contrato` FOREIGN KEY (`IdContrato`) REFERENCES `contrato` (`IdContrato`) ON DELETE NO ACTION ON UPDATE NO ACTION,
--   CONSTRAINT `fk_contratoitem_contratoitempadre` FOREIGN KEY (`IdContratoItemPadre`) REFERENCES `contratoitempadre` (`idContratoItemPadre`) ON DELETE NO ACTION ON UPDATE NO ACTION
-- ) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- En Produccion
-- INSERT INTO rol (Nombre) VALUES ('MUNICIPIO');
-- INSERT INTO rol (Nombre) VALUES ('MUNICIPIOS Administrador');

-- En Produccion
-- INSERT INTO pagina (Pagina, Descripcion, Activa, IdMenuActivo) VALUES ('Obra.HomeAdmin', 'Obras por administración', 1, 7);
-- INSERT INTO pagina (Pagina, Descripcion, Activa, IdMenuActivo) VALUES ('Obra.UpdateAdmin', 'Obras por administración ABM', 1, 7);
-- INSERT INTO pagina (Pagina, Descripcion, Activa, IdMenuActivo) VALUES ('Obra.Contrato.Certificacion.HomeAdmin', 'Certificaciones por administración', 1, 7);
-- INSERT INTO pagina (Pagina, Descripcion, Activa, IdMenuActivo) VALUES ('Obra.Contrato.Certificacion.UpdateAdmin', 'Certificaciones por administración ABM', 1, 7);
-- INSERT INTO pagina (Pagina, Descripcion, Activa, IdMenuActivo) VALUES ('Obra.Contrato.Item.Update', 'Items de Convenio', 1, 7);
-- INSERT INTO pagina (Pagina, Descripcion, Activa, IdMenuActivo) VALUES ('Obra.Contrato.HomeAdmin', 'Contratos por administración', 1, 7);
-- INSERT INTO pagina (Pagina, Descripcion, Activa, IdMenuActivo) VALUES ('Obra.Contrato.UpdateAdmin', 'Contratos por administración ABM', 1, 7);


-- en Produccion
-- Roles para Municipio
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (10, (Select IdPagina from pagina where pagina like '%Obra.HomeAdmin%'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (10, (Select IdPagina from pagina where pagina like '%Obra.Contrato.Certificacion.HomeAdmin%'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (10, (Select IdPagina from pagina where pagina like '%Obra.Contrato.Certificacion.UpdateAdmin%'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (10, (Select IdPagina from pagina where pagina like '%Obra.Contrato.HomeAdmin%'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (10, (Select IdPagina from pagina where pagina like '%Obra.Contrato.UpdateAdmin%'));

--en Produccion
-- Roles para Municipio Administracion
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina like '%Login%'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Logout'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Home'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='CambioPassword'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Obra.Home'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Obra.Update'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Obra.Contrato.Home'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Obra.Contrato.Update'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Obra.Contrato.Certificacion.Home'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Obra.Contrato.Certificacion.Update'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Obra.Contrato.CertificacionPeriodo'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Tesoreria.Pago.Home'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Tesoreria.Pago.Update'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Admin.Usuario.Home'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Admin.Usuario.Update'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Admin.FuenteFinanciamiento.Home'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Admin.FuenteFinanciamiento.Update'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Tesoreria.Pago.PagosByCertificado'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Obra.Contrato.Alteracion.Update'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Obra.Contrato.ContratoPlazo.Update'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Obra.Contrato.RecepcionContrato.Update'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Obra.Contrato.Redeterminacion.Update'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Admin.Proveedor.Home'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Admin.Proveedor.Update'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Obra.Contrato.OrdenTrabajo.Update'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Obra.Contrato.OrdenTrabajo.Deductivo.Update'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Reportes.ObrasReport'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='DetalleAlarma'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='DetalleAlarmaObra'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='ComentariosAlarma'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Obra.RefuerzoPartida.Update'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Obra.UpdateAgil'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Obra.SolicitudProyecto.Home'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Obra.SolicitudProyecto.Update'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Obra.SolicitudProyecto.UpdateProyecto'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Obra.HomeAdmin'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Obra.UpdateAdmin'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Obra.Contrato.Certificacion.HomeAdmin'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Obra.Contrato.Certificacion.UpdateAdmin'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Obra.Contrato.HomeAdmin'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Obra.Contrato.UpdateAdmin'));
-- INSERT INTO rolpagina (IdRol, IdPagina) VALUES (11, (Select IdPagina from pagina where pagina ='Obra.Contrato.Item.Update'));

-- En Produccion
-- INSERT INTO menu (IdMenuContenedor, IdPagina, Nombre, Orden, Target, Activo) VALUES (7, 48, 'Obras de Municipios', 5, '_self', 1);


--Agrego la columna IdContratoItemPadre
ALTER TABLE `contratoitem` ADD COLUMN `IdContratoItemPadre` int(10) unsigned NOT NULL;


-- Agregar Columna IdContratoItemPadre 
ALTER TABLE `contratoitem`
ADD COLUMN `IdContratoItemPadre` INT(20) unsigned,
ADD CONSTRAINT `fk_contratoitem_contratoitempadre` FOREIGN KEY (`IdContratoItemPadre`)
REFERENCES `contratoitempadre` (`idContratoItemPadre`) ON DELETE NO ACTION ON UPDATE NO ACTION