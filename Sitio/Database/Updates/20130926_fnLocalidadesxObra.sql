DROP FUNCTION IF EXISTS ssp.fnLocalidadesxObra;
DELIMITER $$
CREATE FUNCTION ssp.`fnLocalidadesxObra`(pIdObra INT, pFinLinea VARCHAR(10)) RETURNS varchar(1000) CHARSET utf8
BEGIN
  DECLARE vNombre VARCHAR(100);
  DECLARE vReturn VARCHAR(1000);
  DECLARE vDone INT DEFAULT 0;
  DECLARE vCurLocalidades CURSOR FOR select l.Nombre from obralocalidad ol inner join localidad l on ol.IdLocalidad=l.IdLocalidad where ol.IdObra=pIdObra order by l.Nombre;
  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET vDone = 1;
  
  SET vReturn = '';
  SET vDone = 0;
  OPEN vCurLocalidades;
  
  REPEAT
    FETCH vCurLocalidades INTO vNombre;
    
    IF NOT vDone THEN
      
      IF vReturn='' THEN
        SET vReturn = vNombre;
      ELSE
        SET vReturn = CONCAT(vReturn,pFinLinea, vNombre);
      END IF;
      
    END IF;
  
  UNTIL vDone END REPEAT;
	
  RETURN vReturn;
END;
$$
DELIMITER ;