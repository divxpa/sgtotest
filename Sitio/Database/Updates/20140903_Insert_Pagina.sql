insert into pagina (Pagina,Descripcion,Activa,IdMenuActivo) VALUES ('Obra.UpdateAgil','Obras carga ágil',1,7);
insert into menu (IdMenuContenedor,IdPagina,Nombre,Orden,Target,Activo) VALUES (7,(select IdPagina from pagina where Pagina='Obra.UpdateAgil'),'Carga ágil',3,'_self',1);
insert into rolpagina (IdRol,IdPagina) VALUES (2,(select IdPagina from pagina where Pagina='Obra.UpdateAgil'));
insert into rolpagina (IdRol,IdPagina) VALUES (3,(select IdPagina from pagina where Pagina='Obra.UpdateAgil'));