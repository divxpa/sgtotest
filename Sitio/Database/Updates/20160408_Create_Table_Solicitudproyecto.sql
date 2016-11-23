CREATE TABLE `solicitudproyecto` (
  `IdSolicitudProyecto` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `FechaSolicitud` date NOT NULL,
  `Solicitante` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `DepartamentoSolicitante` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `AutoridadSolicitante` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `DomicilioSolicitante` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `TelefonoSolicitante` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `EmailSolicitante` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Referente` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `DniReferente` varchar(8) COLLATE utf8_spanish_ci DEFAULT NULL,
  `CargoReferente` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `DomicilioReferente` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `TelefonoReferente` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `EmailReferente` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `IdOrganismo` int(10) unsigned NOT NULL,
  PRIMARY KEY (`IdSolicitudProyecto`),
  KEY `fk_solicitudproyecto_organismo` (`IdOrganismo`),
  CONSTRAINT `fk_solicitudproyecto_organismo` FOREIGN KEY (`IdOrganismo`) REFERENCES `organismo` (`IdOrganismo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE solicitudproyectodetalle (
   IdSolicitudProyectoDetalle INT UNSIGNED AUTO_INCREMENT NOT NULL,
   IdSolicitudProyecto INT UNSIGNED NOT NULL,
   Localizacion VARCHAR(100) NOT NULL,
   Proyecto VARCHAR(255) NOT NULL,
   Descripcion TEXT ASCII,
   MontoEstimado DECIMAL(14,2) UNSIGNED,
   Moneda INT(1) UNSIGNED COMMENT '0 pesos 1 dolares',
   FechaEstimacionCosto DATE,
   Estado INT(1) UNSIGNED NOT NULL COMMENT '0 perfil 1 anteproyecto 2 proyecto 3 licitacion 4 ejecucion',
   Prioridad INT(1) UNSIGNED NOT NULL COMMENT '0 urgente 1 estructural 2 estrategica',
  CONSTRAINT fk_solicituddetalle_solicitud FOREIGN KEY (IdSolicitudProyecto) REFERENCES solicitudproyecto (IdSolicitudProyecto) ON UPDATE NO ACTION ON DELETE NO ACTION,
  PRIMARY KEY (IdSolicitudProyectoDetalle)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;

insert into pagina (Pagina,Descripcion,Activa,IdMenuActivo) VALUES ('Obra.SolicitudProyecto.Home', 'Solicitudes de proyectos de inversión', 1, 7);
insert into pagina (Pagina,Descripcion,Activa,IdMenuActivo) VALUES ('Obra.SolicitudProyecto.Update', 'ABM Solicitudes de proyectos de inversión', 1, 7);
insert into menu (IdMenuContenedor,IdPagina,Nombre,Orden,Target,Activo) VALUES (7,(select IdPagina from pagina where Pagina='Obra.SolicitudProyecto.Home'),'Proyectos de inversión',4,'_self',1);
insert into rolpagina (IdRol,IdPagina) VALUES (2, (select IdPagina from pagina where Pagina='Obra.SolicitudProyecto.Home'));
insert into rolpagina (IdRol,IdPagina) VALUES (3, (select IdPagina from pagina where Pagina='Obra.SolicitudProyecto.Home'));
insert into rolpagina (IdRol,IdPagina) VALUES (5, (select IdPagina from pagina where Pagina='Obra.SolicitudProyecto.Home'));
insert into rolpagina (IdRol,IdPagina) VALUES (2, (select IdPagina from pagina where Pagina='Obra.SolicitudProyecto.Update'));
insert into rolpagina (IdRol,IdPagina) VALUES (3, (select IdPagina from pagina where Pagina='Obra.SolicitudProyecto.Update'));
insert into rolpagina (IdRol,IdPagina) VALUES (5, (select IdPagina from pagina where Pagina='Obra.SolicitudProyecto.Update'));
insert into pagina (Pagina,Descripcion,Activa,IdMenuActivo) VALUES ('Obra.SolicitudProyecto.UpdateProyecto', 'ABM proyectos de inversión', 1, 7);
insert into rolpagina (IdRol,IdPagina) VALUES (2, (select IdPagina from pagina where Pagina='Obra.SolicitudProyecto.UpdateProyecto'));
insert into rolpagina (IdRol,IdPagina) VALUES (3, (select IdPagina from pagina where Pagina='Obra.SolicitudProyecto.UpdateProyecto'));
insert into rolpagina (IdRol,IdPagina) VALUES (5, (select IdPagina from pagina where Pagina='Obra.SolicitudProyecto.UpdateProyecto'));

ALTER TABLE solicitudproyectodetalle ADD Observaciones TEXT CHARACTER SET utf8 AFTER Prioridad;