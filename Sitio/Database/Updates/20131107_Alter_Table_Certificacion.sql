ALTER TABLE ssp.certificacion CHANGE TipoCertificado TipoCertificado INT(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '0 Obra, 1 Anticipo, 2 Redeterminacion, 3 Adicionales';