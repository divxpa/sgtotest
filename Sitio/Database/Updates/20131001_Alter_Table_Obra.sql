ALTER TABLE ssp.obra CHANGE Denominacion Denominacion VARCHAR(1000) NOT NULL;
ALTER TABLE ssp.alteracion CHANGE Importe Importe DECIMAL(14,2) NOT NULL;
ALTER TABLE ssp.certificacion ADD ManoObraOcupada INT(5) UNSIGNED AFTER OtrosConceptos;
ALTER TABLE ssp.certificacion CHANGE RetencionMulta RetencionMulta DECIMAL(14,2);
ALTER TABLE ssp.certificacion CHANGE ImporteNeto ImporteNeto DECIMAL(14,2) NOT NULL;
ALTER TABLE ssp.pago CHANGE OrdenPago OrdenPago VARCHAR(15) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL;