<?php
class RendicionCuentasRecord extends TActiveRecord
{
  const TABLE='rendicioncuentas';

  public $IdRendicionCuentas;
  public $IdCertificacion;
  public $Orden;
  public $IdLocalidad
  public $Empresa;
  public $Cuit;
  public $Factura;
  public $Recibo;
  public $FechaEmision;
  public $Concepto;
  public $Monto;
  public $FechaCancelacion;
  public $Observaciones;
  public $Estado;
  public $Revision;
  public $Activo;

  public static function finder($className=__CLASS__)
  {
    return parent::finder($className);
  }
}
?>
