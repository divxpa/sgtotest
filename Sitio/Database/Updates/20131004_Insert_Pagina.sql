insert into pagina (Pagina, Descripcion, Activa, IdMenuActivo) VALUES ('Obra.Contrato.Redeterminacion.Update', 'Redeterminaciones de Precio ABM', 1, (select IdMenu from menu where Nombre='Obras'));
insert into rolpagina (IdRol, IdPagina) VALUES (2, (select IdPagina from pagina where Pagina='Obra.Contrato.Redeterminacion.Update'));
insert into rolpagina (IdRol, IdPagina) VALUES (3, (select IdPagina from pagina where Pagina='Obra.Contrato.Redeterminacion.Update'));