
-- Creacion de la Pagina de Creacion y Modificacion de Items
INSERT INTO pagina
(Pagina, Descripcion, Activa, IdMenuActivo) 
VALUES ('Obra.Contrato.Item.Update', 'Items de Convenio', 1, 7);


-- Asigno el Rol de la pagina (Item.Update) al Usuario ("MUNICIPIOS Administrador")
INSERT INTO rolpagina (IdRol, IdPagina) VALUES (10, 55);


--Agrego la columna IdContratoItemPadre
ALTER TABLE `contratoitem` ADD COLUMN `IdContratoItemPadre` int(10) unsigned NOT NULL;


-- Agregar Columna IdContratoItemPadre 
ALTER TABLE `contratoitem`
ADD COLUMN `IdContratoItemPadre` INT(20) unsigned,
ADD CONSTRAINT `fk_contratoitem_contratoitempadre` FOREIGN KEY (`IdContratoItemPadre`)
REFERENCES `contratoitempadre` (`idContratoItemPadre`) ON DELETE NO ACTION ON UPDATE NO ACTION