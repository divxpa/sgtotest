DELIMITER $$
CREATE PROCEDURE spRecalcularCertificaciones(pIdContrato INT)
BEGIN
  DECLARE vMontoTotal DECIMAL(14,2);
	select co.Monto + ifnull((select sum(Importe*(case when AdicionalDeductivo=0 then 1 else -1 end)) from alteracion where IdContrato=co.IdContrato),0) into vMontoTotal from contrato co where co.IdContrato=pIdContrato;
  update certificacion set PorcentajeAvance = (MontoAvance / vMontoTotal * 100) where IdContrato=pIdContrato;
END;
$$
DELIMITER ;