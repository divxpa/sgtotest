<?php
class ContratoPeer
{
	public static function ContratosHome($idObra){
		$where = " where c.IdObra=$idObra ";

		$sql = "select
				  c.IdContrato,
				  c.IdObra,
				  concat(p.Cuit,' ',p.RazonSocial) as Proveedor,
				  c.Numero,
				  date_format(c.Fecha, '%d/%m/%Y') as Fecha,
				  c.Monto,
				  ifnull((select sum(Importe*(case when AdicionalDeductivo=0 then 1 else -1 end)) from alteracion where IdContrato=c.IdContrato),0) as Alteracion,
				  ifnull((select sum(Importe) from redeterminacion where IdContrato=c.IdContrato),0) as RedeterminacionPrecios,
				  date_format(c.FechaBaseMonto, '%d/%m/%Y') as FechaBaseMonto,
				  c.NormaLegalAutorizacion,
				  c.NormaLegalAdjudicacion,
				  c.PlazoEjecucion,
				  date_format(c.FechaInicio, '%d/%m/%Y') as FechaInicio,
				  ifnull((select sum(CantidadDias) from contratoplazo where IdContrato=c.IdContrato),0) as Ampliacion,
				  date_format(ifnull((select max(NuevaFechaFinalizacion) from contratoplazo where IdContrato=c.IdContrato),c.FechaFinalizacion), '%d/%m/%Y') as FechaFinalizacion,
				  ifnull((select sum(montoavance) from certificacion where IdContrato=c.IdContrato),0)/(c.Monto+ifnull((select sum(Importe*(case when AdicionalDeductivo=0 then 1 else -1 end)) from alteracion where IdContrato=c.IdContrato),0))*100 as PorcentajeAvance,
				  ifnull((select sum(montoavance) from certificacion where IdContrato=c.IdContrato),0) as MontoAvance
				from
				  contrato c inner join
				  proveedor p on c.IdProveedor = p.IdProveedor
				$where
				order by
				  c.Numero";
		return $sql;
	}

	public static function AlteracionesByContrato($idContrato){
		$sql = "select
				  a.IdAlteracion,
				  a.IdContrato,
				  c.IdObra,
				  date_format(a.Fecha, '%d/%m/%Y') as Fecha,
				  a.NormaLegalAprobacion,
				  (case
				    when a.AdicionalDeductivo=0 then 'Adicional'
				    else 'Deductivo'
				  end) as Tipo,
				  a.Importe
				from
				  alteracion a inner join
				  contrato c on a.IdContrato=c.IdContrato
				where
					a.IdContrato=$idContrato
				order by
				  a.Fecha";
		return $sql;
	}

	public static function AmpliacionesByContrato($idContrato, $idOrganismo){
		$sql = "select
				  cp.IdContratoPlazo,
				  cp.IdContrato,
				  c.IdObra,
				  cp.NormaLegalAprobacion,
				  cp.CantidadDias,
				  date_format(cp.NuevaFechaFinalizacion, '%d/%m/%Y') as NuevaFechaFinalizacion,
				  (case
				  	when o.IdOrganismo=o.IdComitente then 'true'
				  	when o.IdComitente=$idOrganismo then 'false'
				  	else 'true'
				  end) as EditarVisible
				from
				  contratoplazo cp inner join
				  contrato c on cp.IdContrato=c.IdContrato inner join
				  obra o on c.IdObra=o.IdObra
				where
				  cp.IdContrato=$idContrato
				order by
				  cp.NuevaFechaFinalizacion";
		return $sql;
	}

	public static function RecepcionesByContrato($idContrato, $idOrganismo){
		$sql = "select
				  rc.IdRecepcionContrato,
				  rc.IdContrato,
				  c.IdObra,
				  rc.NormaLegalAprobacion,
				  date_format(rc.Fecha, '%d/%m/%Y') as Fecha,
				  (case
				    when rc.ProvisoriaDefinitiva=0 then 'Provisoria'
				    else 'Definitiva'
				  end) as Tipo,
				  (case
				    when rc.ParcialTotal=0 then 'Parcial'
				    else 'Total'
				  end) as ParcialTotal,
				  rc.PorcentajeRecepcion,
				  (case
				  	when o.IdOrganismo=o.IdComitente then 'true'
				  	when o.IdComitente=$idOrganismo then 'false'
				  	else 'true'
				  end) as EditarVisible
				from
				  recepcioncontrato rc inner join
				  contrato c on rc.IdContrato=c.IdContrato inner join
				  obra o on c.IdObra=o.IdObra
				where
				  rc.IdContrato=$idContrato
				order by
				  rc.Fecha";
		return $sql;
	}

	public static function RecalcularCertificacionesByContrato($idContrato){
		$sql = "call spRecalcularCertificaciones($idContrato)";
		return $sql;
	}

	public static function MontoContrato($idContrato){
		$sql = "select
				  c.Monto + ifnull((select sum(Importe*(case when AdicionalDeductivo=0 then 1 else -1 end)) from alteracion where IdContrato=c.IdContrato),0) as MontoTotal
				from
				  contrato c
				where
				  c.IdContrato=$idContrato";
		return $sql;
	}

	public static function RedeterminacionesByContrato($idContrato){
		$sql = "select
				  r.IdRedeterminacion,
				  r.IdContrato,
				  c.IdObra,
				  date_format(r.Fecha, '%d/%m/%Y') as Fecha,
				  r.NormaLegalAprobacion,
				  r.Importe
				from
				  redeterminacion r inner join
				  contrato c on r.IdContrato=c.IdContrato
				where
					r.IdContrato=$idContrato
				order by
				  r.Fecha";
		return $sql;
	}

	public static function OrdenesTrabajoByContrato($idContrato, $idOrganismo){
		$sql = "select
				  ot.IdOrdenTrabajo,
				  ot.Numero,
				  ot.NormaLegalAutorizacion,
				  ot.Monto,
				  ifnull((select sum(Importe) from ordentrabajodeductivo where IdOrdenTrabajo=ot.IdOrdenTrabajo), 0) as Deductivos,
				  ifnull((select sum(PorcentajeAvance) from certificacion where IdOrdenTrabajo=ot.IdOrdenTrabajo), 0) as PorcentajeAvance,
				  ifnull((select sum(MontoAvance) from certificacion where IdOrdenTrabajo=ot.IdOrdenTrabajo), 0) as MontoAvance,
				  ot.IdContrato,
				  c.IdObra,
				  (case
				  	when o.IdOrganismo=o.IdComitente then 'true'
				  	when o.IdComitente=$idOrganismo then 'false'
				  	else 'true'
				  end) as EditarVisible
				from 
				  ordentrabajo ot inner join
				  contrato c on ot.IdContrato=c.IdContrato inner join
				  obra o on c.IdObra=o.IdObra
				where
				  ot.IdContrato=$idContrato
				order by
				  ot.Numero";
		return $sql;
	}

	public static function PorcentajeAvance($idContrato, $idCertificacion){
		$where = "";

		if(!is_null($idCertificacion)){
			$where = "and IdCertificacion<>$idCertificacion";
		}

		$sql = "select
					ifnull((select sum(montoavance) from certificacion ce where ce.IdContrato=co.IdContrato $where),0)/(co.Monto+ifnull((select sum(Importe*(case when AdicionalDeductivo=0 then 1 else -1 end)) from alteracion where IdContrato=co.IdContrato),0))*100 as PorcentajeAvance
				from
					contrato co
				where
					co.IdContrato=$idContrato";

		return $sql;
	}


	public static function ItemsByContrato ($idContrato){
		$sql = "Select
				    ci.IdContratoItem, ci.IdContrato, ci.Item, ci.Cantidad, 
				    ci.UnidadMedida, ci.PrecioUnitario, ci.PrecioTotal, ci.Orden 
				From 
				    contratoitem ci
				Where
				    ci.IdContrato = $idContrato
				Order by 
				    ci.Orden";
		return $sql;
	}


	public static function ItemsByContratoConUnidadMedida ($idContrato){
		$sql = "Select
				    ci.IdContratoItem, ci.IdContrato, ci.Item, ci.Cantidad, 
				    CASE ci.UnidadMedida
              WHEN 0 THEN 'gl.'
              WHEN 1 THEN 'ml.'
              WHEN 2 THEN 'm2.'
              WHEN 3 THEN 'm3.'
              WHEN 4 THEN 'lt.'
              WHEN 5 THEN 'kg.'
              WHEN 6 THEN 'u.'
              WHEN 7 THEN 'pza'
              WHEN 8 THEN 'cto.'
              WHEN 9 THEN 'ha.'
              END as UnidadMedida,
            ci.PrecioUnitario, ci.PrecioTotal, ci.Orden ,c.IdObra,
            CONCAT(ROUND(((ci.preciototal * 100)/c.monto), 2),' %') as Incidencia            
				From 
				    contratoitem ci inner join contrato c on c.idContrato = ci.IdContrato
				Where
				    ci.IdContrato = $idContrato
				Order by 
				    ci.Orden";
		return $sql;
	}


	public static function SiguienteNumeroOrden($idContrato){
		$sql = "Select				  
				   max(ci.Orden) +1 as Orden
				from
				  contratoitem ci
				where
          			ci.IdContrato = $idContrato";
        return $sql;
	}
	
	public static function SiguienteNumeroOrdenSubitem($idContrato,$idItemPadre){
		$sql = "Select				  
				   max(ci.Orden) +1 as Orden
				from
				  contratoitem ci
				where
          			ci.IdContrato = $idContrato
          			and ci.IdContratoItemPadre = $idItemPadre";
        return $sql;
	}

    public static function ItemsByContratoCertificacion ($idContrato,$periodo,$idCertificacion){
            
        if(!empty($idCertificacion)) {
            $porcentajeActual = "(".
            	"SELECT PorcentajeActual
            	FROM certificacionitem 
            	WHERE IdContratoItem=ci.IdcontratoItem AND IdCertificacion=$idCertificacion"
            .")";
            $importeActual = "(".
            	"SELECT ImporteActual 
            	FROM certificacionitem 
            	WHERE IdContratoItem=ci.IdcontratoItem AND IdCertificacion=$idCertificacion"
            .")";
            $idCertificacionItem= "(".
            	"SELECT IdCertificacionItem 
            	FROM certificacionitem 
            	WHERE IdContratoItem=ci.IdContratoItem AND IdCertificacion=$idCertificacion"
            .")";
        }
        else {
            $porcentajeActual = "0.0";
            $importeActual = "0.0";
            $idCertificacionItem = "0.0";
        }
           
        // Desactivadas las '@variables' por algunos errores de precisión
        $incidencia = "(ci.PrecioTotal/c.Monto)";
        $importe_anterior = "(".
        	"SELECT IFNULL(sum(cei.ImporteActual), 0) 
			FROM certificacionitem cei 
			INNER JOIN certificacion ce on ce.IdCertificacion=cei.IdCertificacion
			WHERE cei.IdContratoItem=ci.IdContratoItem AND ce.Periodo < '$periodo'".
		")";

		$sql = "SELECT * FROM (
					(SELECT 
						$idCertificacionItem AS IdCertificacionItem,
	                    ci.IdContratoItem, 
	                    ci.IdContrato, 
	                    ci.Cantidad, 
				    	ci.UnidadMedida, 
				    	ci.PrecioUnitario, 
				    	IFNULL(cip.orden,ci.orden) AS OrdenItem,
				    	IF(cip.orden,ci.orden,0) AS OrdenSubitem,
				    	CONCAT(IF(cip.orden IS NULL,'','&nbsp;&nbsp;&nbsp;&nbsp;'), ci.Item) AS Item, -- , 
				    	ci.PrecioTotal, 
	                	$incidencia AS Incidencia,
	                    $incidencia * 100 AS IncidenciaPorcentaje,
				    	$importe_anterior AS ImporteAnterior,
	                    ($importe_anterior / ci.PrecioTotal * 100) AS PorcentajeAnterior, 
	                    $importeActual AS ImporteActual,
	                    $porcentajeActual AS PorcentajeActual, 
	                    ($importe_anterior + $importeActual) AS ImporteAcum,
	                    (($importe_anterior / ci.PrecioTotal * 100) + $porcentajeActual) AS PorcentajeAcum,
	                    IF(cip.orden IS NULL,1,3) as tipo, -- 1 as tipo,
	                    CONCAT('hijo',ci.IdContratoItemPadre) AS claseVinculadora,
	                    IFNULL(cip.orden,ci.orden) AS orderby
					FROM 
					    contratoitem AS ci 
					    LEFT JOIN contratoitempadre AS cip ON ci.IdContratoItemPadre = cip.IdContratoItemPadre
					    INNER JOIN contrato AS c ON c.IdContrato = ci.IdContrato
					WHERE
					    ci.IdContrato = $idContrato
					ORDER BY 
					    ci.Orden)
					UNION
					(SELECT 
						cip.idcontratoitempadre AS IdCertificacionItem, 
						0,0,0,0,0, -- de los 5 campos de ci que había comentado previamente
						cip.orden AS OrdenItem,
						0 AS OrdenSubitem,
						cip.item AS Item,
						0.0 AS PrecioTotal,
						0.0 AS Incidencia,
						0.0,0.0,0.0,0.0,0.0,0.0,0.0,
						2 as tipo,
						CONCAT('padre',cip.idcontratoitempadre) AS claseVinculadora,
	                    cip.orden AS orderby
					FROM 
						contratoitempadre AS cip
					WHERE cip.IdContrato = $idContrato)
				) AS t 
				ORDER BY OrdenItem, OrdenSubitem";

		return $sql;
	}


	public static function RendicionesByCertificacion($idCertificacion){
		$sql= "SELECT 
				  IdRendicionCuentas, 
				  IdCertificacion, 
				  Orden, 
				  Proyecto,  
				  localidad.Nombre as 'Localidad', 
				  Empresa, 
				  Cuit, 
				  Factura, 
				  Recibo, 
				  DATE_FORMAT(FechaEmision,'%d/%m/%Y') as FechaEmision,
				  Concepto,
				  DATE_FORMAT(FechaCancelacion,'%d/%m/%Y') as FechaCancelacion,
				  OrdenDePago, 
				  Monto, 
				  Observaciones, 
				  Estado, 
				  Revision, 
				  Activo 
			FROM rendicioncuentas inner join localidad on rendicioncuentas.IdLocalidad = localidad.IdLocalidad
			WHERE idCertificacion = $idCertificacion and rendicioncuentas.Activo=1";
		return $sql;
	}

	public static function TotalMontoItemsByContrato($idContrato){
		$sql= "Select sum(preciototal) as monto from contratoitem where idContrato = $idContrato";	
		return $sql;
	}

	public static function TotalIncidenciaItemsByContrato($idContrato){
		$sql= "Select round((sum(ci.preciototal)*100)/c.monto,2) as incidencia 
				From contratoitem ci inner join contrato c on c.idContrato = ci.IdContrato
				Where ci.idContrato =  $idContrato";	
		return $sql;
	}

	public static function FechaPagoAnticipoFinanciero($idContrato)
	{
		$sql = "SELECT 
			date_format(p.Fecha, '%d/%m/%Y') as Fecha
		FROM 
			pago p
			INNER JOIN pagocertificacion pc on p.IdPago = pc.IdPago
			INNER JOIN certificacion c on pc.IdCertificacion = c.IdCertificacion and c.NroCertificado = 0
		WHERE 
			c.IdContrato = '$idContrato'
		ORDER BY 
			p.Fecha DESC
		LIMIT 1";

		return $sql;
	}
}
