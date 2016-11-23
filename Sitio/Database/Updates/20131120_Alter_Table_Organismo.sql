ALTER TABLE organismo ADD Comitente INT(1) UNSIGNED NOT NULL DEFAULT 0;
update organismo set Comitente=1 where Nombre='UPEFE';
ALTER TABLE obra ADD IdComitente INT(10) UNSIGNED NOT NULL;
update obra set IdComitente=IdOrganismo;
ALTER TABLE obra ADD CONSTRAINT fk_obra_organismo_com FOREIGN KEY (IdComitente) REFERENCES ssp.organismo (IdOrganismo) ON UPDATE NO ACTION ON DELETE NO ACTION;
