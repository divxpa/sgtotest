-- actualizo los estados de las obras que corresponden a finalizada
update obra set IdEstadoObra=8, DetalleEstado=(case when DetalleEstado is null or DetalleEstado='' then (select Descripcion from estadoobra where IdEstadoObra=obra.IdEstadoObra) else DetalleEstado end) where IdEstadoObra in (9,10,11,12);
update obraestado set IdEstadoObra=8, DetalleEstado=(case when DetalleEstado is null or DetalleEstado='' then (select Descripcion from estadoobra where IdEstadoObra=obraestado.IdEstadoObra) else DetalleEstado end) where IdEstadoObra in (9,10,11,12);
-- elimino los estados de obra
delete from estadoobra where IdEstadoObra in (9,10,11,12);