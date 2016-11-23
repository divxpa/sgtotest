ALTER TABLE ssp.pagina ADD IdMenuActivo INT(10) UNSIGNED AFTER Activa;
ALTER TABLE ssp.pagina ADD CONSTRAINT fk_pagina_menu FOREIGN KEY (IdMenuActivo) REFERENCES ssp.menu (IdMenu) ON UPDATE NO ACTION ON DELETE NO ACTION;

update pagina set IdMenuActivo=(select IdMenu from menu where Nombre='Inicio') where instr(Pagina, '.') = 0;
update pagina set IdMenuActivo=(select IdMenu from menu where Nombre='Obras') where instr(Pagina, 'Obra.') > 0;
update pagina set IdMenuActivo=(select IdMenu from menu where Nombre='Tesorer�a') where instr(Pagina, 'Tesoreria.') > 0;
update pagina set IdMenuActivo=(select IdMenu from menu where Nombre='Administraci�n') where instr(Pagina, 'Admin.') > 0;