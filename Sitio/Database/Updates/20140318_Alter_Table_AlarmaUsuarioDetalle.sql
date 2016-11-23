ALTER TABLE alarmausuariodetalle ADD Comentario TEXT CHARACTER SET utf8 COLLATE utf8_spanish_ci AFTER IdObra;
ALTER TABLE alarmausuariodetalle ADD IdCertificacion INT UNSIGNED;
ALTER TABLE alarmausuariodetalle ADD CONSTRAINT fk_alarmausuariodet_certif FOREIGN KEY (IdCertificacion) REFERENCES certificacion (IdCertificacion) ON UPDATE NO ACTION ON DELETE NO ACTION;
insert into pagina (Pagina,Descripcion,Activa,IdMenuActivo) VALUES ('ComentariosAlarma', 'Comentarios de Alarma', 1, 1);
insert into rolpagina (IdRol,IdPagina) select IdRol, (select IdPagina from pagina where Pagina='ComentariosAlarma') from rol;
