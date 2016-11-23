insert into menu (IdMenuContenedor, IdPagina, Nombre, Orden, Target, Activo) VALUES (null, null, 'Reportes', 5, '_self', 1);
insert into pagina (Pagina, Descripcion, Activa, IdMenuActivo) VALUES ('Reportes.ObrasReport', 'Reporte de obras', 1, (select IdMenu from menu where Nombre='Reportes'));
insert into menu (IdMenuContenedor, IdPagina, Nombre, Orden, Target, Activo) VALUES (20, (select IdPagina from pagina where Pagina='Reportes.ObrasReport'), 'Obras', null, '_self', 1);
insert into rolpagina (IdRol, IdPagina) VALUES (2, (select IdPagina from pagina where Pagina='Reportes.ObrasReport'));
insert into rolpagina (IdRol, IdPagina) VALUES (3, (select IdPagina from pagina where Pagina='Reportes.ObrasReport'));
insert into rolpagina (IdRol, IdPagina) VALUES (5, (select IdPagina from pagina where Pagina='Reportes.ObrasReport'));