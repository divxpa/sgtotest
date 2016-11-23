DROP FUNCTION IF EXISTS ssp.fnLocalidadesxObra;
DELIMITER $$
CREATE FUNCTION ssp.`fnLocalidadesxObra`(pIdObra INT, pFinLinea VARCHAR(10)) RETURNS varchar(1000) CHARSET utf8
DETERMINISTIC
READS SQL DATA
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

DROP FUNCTION IF EXISTS ssp.fnActualizarMonto;
DELIMITER $$
CREATE FUNCTION ssp.`fnActualizarMonto`(pMonto DECIMAL, pPeriodoMonto VARCHAR(6), pPeriodoActualiz VARCHAR(6)) RETURNS decimal(14,2)
DETERMINISTIC
READS SQL DATA
BEGIN
  /*DECLARE vIndice DECIMAL(20,15) DEFAULT 0;
  DECLARE vReturn DECIMAL(14,2) DEFAULT 0;
  DECLARE vDone INT DEFAULT 0;  
  DECLARE vCur CURSOR FOR select Indice from indiceipc where Periodo > pPeriodoMonto and Periodo <= pPeriodoActualiz order by Periodo asc;
  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET vDone = 1;
  
  SET vDone = 0;
  SET vReturn = pMonto;
  OPEN vCur;
  
  REPEAT
    FETCH vCur INTO vIndice;
    
    IF NOT vDone THEN
      SET vReturn = vReturn + (vReturn*vIndice)/100;
    END IF;
  
  UNTIL vDone END REPEAT;*/
  declare vIpcBase decimal(20,4);
  declare vIpcActual decimal(20,4);
  
  select Indice into vIpcBase from indiceipc where Periodo=pPeriodoMonto;
  select Indice into vIpcActual from indiceipc where Periodo<=pPeriodoActualiz order by Periodo desc limit 1;

  return (pMonto * vIpcActual) / vIpcBase;
END;
$$
DELIMITER ;

DROP FUNCTION IF EXISTS ssp.fnCodigosFufixObra;
DELIMITER $$
CREATE FUNCTION ssp.`fnCodigosFufixObra`(pIdObra INT) RETURNS varchar(1000) CHARSET utf8
DETERMINISTIC
READS SQL DATA
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
DELIMITER ;

DROP FUNCTION IF EXISTS ssp.fnDescripcionesFufixObra;
DELIMITER $$
CREATE FUNCTION ssp.`fnDescripcionesFufixObra`(pIdObra INT) RETURNS varchar(1000) CHARSET utf8
DETERMINISTIC
READS SQL DATA
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

DROP FUNCTION IF EXISTS ssp.fnFufisxObra;
DELIMITER $$
CREATE FUNCTION ssp.`fnFufisxObra`(pIdObra INT) RETURNS varchar(1000) CHARSET utf8
DETERMINISTIC
READS SQL DATA
BEGIN
  DECLARE vNombre VARCHAR(255);
  DECLARE vFufi VARCHAR(4);
  DECLARE vReturn VARCHAR(1000);
  DECLARE vDone INT DEFAULT 0;
  DECLARE vCurFufis CURSOR FOR select f.CodigoFufi, f.Descripcion from obrafuentefinanciamiento of inner join fuentefinanciamiento f on of.IdFuenteFinanciamiento=f.IdFuenteFinanciamiento where of.IdObra=pIdObra order by f.CodigoFufi;
  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET vDone = 1;
  
  SET vReturn = '';
  SET vDone = 0;
  OPEN vCurFufis;
  
  REPEAT
    FETCH vCurFufis INTO vFufi, vNombre;
    
    IF NOT vDone THEN
      
      IF vReturn='' THEN
        SET vReturn = CONCAT(vFufi,' ',vNombre);
      ELSE
        SET vReturn = CONCAT(vReturn,'<br />', vFufi,' ',vNombre);
      END IF;
      
    END IF;
  
  UNTIL vDone END REPEAT;
	
  RETURN vReturn;
END;
$$
DELIMITER ;