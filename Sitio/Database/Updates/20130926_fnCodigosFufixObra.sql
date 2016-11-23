DROP FUNCTION IF EXISTS ssp.fnCodigosFufixObra;
DROP FUNCTION IF EXISTS ssp.fnDescripcionesFufixObra;
DELIMITER $$
CREATE FUNCTION ssp.`fnCodigosFufixObra`(pIdObra INT) RETURNS varchar(1000) CHARSET utf8
BEGIN
  DECLARE vFufi VARCHAR(4);
  DECLARE vReturn VARCHAR(1000);
  DECLARE vDone INT DEFAULT 0;
  DECLARE vCurFufis CURSOR FOR select f.CodigoFufi from obrafuentefinanciamiento of inner join fuentefinanciamiento f on of.IdFuenteFinanciamiento=f.IdFuenteFinanciamiento where of.IdObra=pIdObra order by f.CodigoFufi;
  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET vDone = 1;
  
  SET vReturn = '';
  SET vDone = 0;
  OPEN vCurFufis;
  
  REPEAT
    FETCH vCurFufis INTO vFufi;
    
    IF NOT vDone THEN
      
      IF vReturn='' THEN
        SET vReturn = CONCAT(vFufi);
      ELSE
        SET vReturn = CONCAT(vReturn,'\n', vFufi);
      END IF;
      
    END IF;
  
  UNTIL vDone END REPEAT;
	
  RETURN vReturn;
END;
$$
CREATE FUNCTION ssp.`fnDescripcionesFufixObra`(pIdObra INT) RETURNS varchar(1000) CHARSET utf8
BEGIN
  DECLARE vNombre VARCHAR(255);
  DECLARE vReturn VARCHAR(1000);
  DECLARE vDone INT DEFAULT 0;
  DECLARE vCurFufis CURSOR FOR select f.Descripcion from obrafuentefinanciamiento of inner join fuentefinanciamiento f on of.IdFuenteFinanciamiento=f.IdFuenteFinanciamiento where of.IdObra=pIdObra order by f.CodigoFufi;
  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET vDone = 1;
  
  SET vReturn = '';
  SET vDone = 0;
  OPEN vCurFufis;
  
  REPEAT
    FETCH vCurFufis INTO vNombre;
    
    IF NOT vDone THEN
      
      IF vReturn='' THEN
        SET vReturn = CONCAT(vNombre);
      ELSE
        SET vReturn = CONCAT(vReturn,'\n', vNombre);
      END IF;
      
    END IF;
  
  UNTIL vDone END REPEAT;
	
  RETURN vReturn;
END;
$$
DELIMITER ;