CREATE TABLE refuerzopartida (
   IdRefuerzoPartida INT UNSIGNED AUTO_INCREMENT NOT NULL,
   IdObra INT UNSIGNED NOT NULL,
   Fecha DATE NOT NULL,
   NormaLegal VARCHAR(10) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
   Importe DECIMAL(14,2) NOT NULL,
  CONSTRAINT fk_refuerzopartida_obra FOREIGN KEY (IdObra) REFERENCES ssp.obra (IdObra) ON UPDATE NO ACTION ON DELETE NO ACTION,
  PRIMARY KEY (IdRefuerzoPartida)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;

insert into pagina (Pagina,Descripcion,Activa,IdMenuActivo) VALUES ('Obra.RefuerzoPartida.Update','Refuerzos de Partida ABM',1,7);
insert into rolpagina (IdRol,IdPagina) VALUES (2,(select IdPagina from pagina where Pagina='Obra.RefuerzoPartida.Update'));
insert into rolpagina (IdRol,IdPagina) VALUES (3,(select IdPagina from pagina where Pagina='Obra.RefuerzoPartida.Update'));