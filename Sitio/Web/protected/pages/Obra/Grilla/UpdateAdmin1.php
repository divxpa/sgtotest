<?php
/**
 * Update
 * Funciones y métodos aplicados al alta o modificación de una localidad
 * @package
 * @author llepe
 * @copyright Copyright (c) 2010
 * @version $Id$
 * @access public
 */
class Update extends PageBaseSgc{

	public function onLoad($param){
		$idEmpresa = $this->EmpresaSeleccionada();

		if(!is_null($idEmpresa)){

			if(!$this->IsPostBack){
				$this->LoadDataRelated($idEmpresa);
				$id = $this->Request["id"];

				if (!is_null($id)) {
					$this->lblAccion->Text = "Edit accounting entry";
					$finder = AsientoContableRecord::finder();
					$asiento = $finder->findByPk($id);
					$this->ddlEjercicio->SelectedValue = $asiento->IdEjercicio;
					$fecha = explode("-",$asiento->Fecha);
					$this->dtpFecha->Text = $fecha[2]."/".$fecha[1]."/".$fecha[0];
					$this->txtLeyenda->Text = $asiento->Leyenda;
				}

				$this->LoadDetalle($id);
			}

		}

	}

	public function btnCancelar_OnClick($sender, $param)
	{
		$idMovimientoCuenta = $this->Request["idmc"];

		if(!is_null($idMovimientoCuenta)){
			$this->Response->Redirect("?page=Tesoreria.MovimientoCuenta.Home");
		}

		$idComprobanteCompra = $this->Request["idcc"];

		if(!is_null($idComprobanteCompra)){
			$this->Response->Redirect("?page=Movimientos.Comprobante.Compra.Home");
		}

		$idPago = $this->Request["idpa"];

		if(!is_null($idPago)){
			$this->Response->Redirect("?page=Movimientos.Pago.Home");
		}

		$idComprobanteVenta = $this->Request["idcv"];

		if(!is_null($idComprobanteVenta)){
			$this->Response->Redirect("?page=Movimientos.Comprobante.Venta.Home");
		}

		$idCobro = $this->Request["idco"];

		if(!is_null($idCobro)){
			$this->Response->Redirect("?page=Movimientos.Cobro.Home");
		}

		$this->Response->Redirect("?page=Contabilidad.AsientoContable.Home");
	}

	public function btnAceptar_OnClick($sender, $param)
	{

		if($this->IsValid){
			$id = $this->Request["id"];

			if(!is_null($id)){
				$finder = AsientoContableRecord::finder();
				$asiento = $finder->findByPk($id);
			}
			else{
				$asiento = new AsientoContableRecord();
				$data = $this->CreateDataSource("Query","SiguienteNumeroAsiento",$this->ddlEjercicio->SelectedValue);
				$asiento->Numero = $data[0]["Numero"];
			}

			$asiento->IdEjercicio = $this->ddlEjercicio->SelectedValue;
			$fecha = explode("/", $this->dtpFecha->Text);
			$asiento->Fecha = $fecha[2]."-".$fecha[1]."-".$fecha[0];
			$total = str_replace(".", "", $this->dgDetalle->Footer->tcDebe->txtDebeTotal->Text);
			$total = floatval(str_replace(",", ".", $total));
			$total = round($total,2);
			$asiento->Total = $total;
			$asiento->Leyenda = $this->txtLeyenda->Text;

			try{
				$asiento->save();
				$criteria = new TActiveRecordCriteria;
				$criteria->Condition = 'IdAsientoContable = :idAsiento';
				$criteria->Parameters[':idAsiento'] = $asiento->IdAsientoContable;
				$finder = AsientoContableDetalleRecord::finder();
				$detalles = $finder->findAll($criteria);

				foreach($detalles as $d){
					$d->delete();
				}

				$detalles = $this->getViewState("Elementos", array());

				foreach($detalles as $d){
					$detalle = new AsientoContableDetalleRecord();
					$detalle->IdAsientoContable = $asiento->IdAsientoContable;
					$detalle->IdCuenta = $d["IdCuenta"];

					if($d["Debe"]!=""){
						$detalle->Debe = $d["Debe"];
					}
					else{
						$detalle->Debe = null;
					}

					if($d["Haber"]!=""){
						$detalle->Haber = $d["Haber"];
					}
					else{
						$detalle->Haber = null;
					}

					$detalle->Leyenda = $d["Leyenda"];
					$detalle->save();
				}

				$idMovimientoCuenta = $this->Request["idmc"];

				if(!is_null($idMovimientoCuenta)){
					$finder = CuentaBancariaMovimientoRecord::finder();
					$cuentaBancariaMovimiento = $finder->findByPk($idMovimientoCuenta);
					$cuentaBancariaMovimiento->IdAsientoContable = $asiento->IdAsientoContable;
					$cuentaBancariaMovimiento->save();

					if(!is_null($cuentaBancariaMovimiento->IdMovimientoOrigen)){
						$finder = CuentaBancariaMovimientoRecord::finder();
						$cuentaBancariaMovimientoOrigen = $finder->findByPk($cuentaBancariaMovimiento->IdMovimientoOrigen);
						$cuentaBancariaMovimientoOrigen->IdAsientoContable = $asiento->IdAsientoContable;
						$cuentaBancariaMovimientoOrigen->save();
					}

					$criteria = new TActiveRecordCriteria;
					$criteria->Condition = 'IdMovimientoOrigen = :idMovimiento';
					$criteria->Parameters[':idMovimiento'] = $idMovimientoCuenta;
					$finder = CuentaBancariaMovimientoRecord::finder();
					$cuentasBancariasDestino = $finder->findAll($criteria);

					foreach($cuentasBancariasDestino as $cbd){
						$cbd->IdAsientoContable = $asiento->IdAsientoContable;
						$cbd->save();
					}

					$this->Response->Redirect("?page=Tesoreria.MovimientoCuenta.Home");
				}

				$idComprobanteCompra = $this->Request["idcc"];

				if(!is_null($idComprobanteCompra)){
					$finder = ComprobanteRecord::finder();
					$comprobante = $finder->findByPk($idComprobanteCompra);
					$comprobante->IdAsientoContable = $asiento->IdAsientoContable;
					$comprobante->save();

					if(!is_null($comprobante->IdCuentaBancariaMovimiento)){
						$finder = CuentaBancariaMovimientoRecord::finder();
						$movimiento = $finder->findByPk($comprobante->IdCuentaBancariaMovimiento);
						$movimiento->IdAsientoContable = $asiento->IdAsientoContable;
						$movimiento->save();
					}

					$this->Response->Redirect("?page=Movimientos.Comprobante.Compra.Home");
				}

				$idPago = $this->Request["idpa"];

				if(!is_null($idPago)){
					$finder = PagoRecord::finder();
					$pago = $finder->findByPk($idPago);
					$pago->IdAsientoContable = $asiento->IdAsientoContable;
					$pago->save();

					//recupero las transferencias
					$criteria = new TActiveRecordCriteria;
					$criteria->Condition = 'IdPago = :idPago and IdFormaPago=3';
					$criteria->Parameters[':idPago'] = $idPago;
					$finder = PagoFormaPagoRecord::finder();
					$pagoFormaPago = $finder->findAll($criteria);

					foreach($pagoFormaPago as $p){
						$finder = CuentaBancariaMovimientoRecord::finder();
						$movimiento = $finder->findByPk($p->IdCuentaBancariaMovimiento);
						$movimiento->IdAsientoContable = $asiento->IdAsientoContable;
						$movimiento->save();
					}

					$this->Response->Redirect("?page=Movimientos.Pago.Home");
				}

				$idComprobanteVenta = $this->Request["idcv"];

				if(!is_null($idComprobanteVenta)){
					$finder = ComprobanteRecord::finder();
					$comprobante = $finder->findByPk($idComprobanteVenta);
					$comprobante->IdAsientoContable = $asiento->IdAsientoContable;
					$comprobante->save();

					if(!is_null($comprobante->IdCuentaBancariaMovimiento)){
						$finder = CuentaBancariaMovimientoRecord::finder();
						$movimiento = $finder->findByPk($comprobante->IdCuentaBancariaMovimiento);
						$movimiento->IdAsientoContable = $asiento->IdAsientoContable;
						$movimiento->save();
					}

					$this->Response->Redirect("?page=Movimientos.Comprobante.Venta.Home");
				}

				$idCobro = $this->Request["idco"];

				if(!is_null($idCobro)){
					$finder = CobroRecord::finder();
					$cobro = $finder->findByPk($idCobro);
					$cobro->IdAsientoContable = $cobro->IdAsientoContable;
					$cobro->save();

					//recupero las transferencias
					$criteria = new TActiveRecordCriteria;
					$criteria->Condition = 'IdCobro = :idCobro and IdFormaPago=3';
					$criteria->Parameters[':idCobro'] = $idCobro;
					$finder = CobroFormaPagoRecord::finder();
					$cobroFormaPago = $finder->findAll($criteria);

					foreach($cobroFormaPago as $c){
						$finder = CuentaBancariaMovimientoRecord::finder();
						$movimiento = $finder->findByPk($c->IdCuentaBancariaMovimiento);
						$movimiento->IdAsientoContable = $asiento->IdAsientoContable;
						$movimiento->save();
					}

					$this->Response->Redirect("?page=Movimientos.Cobro.Home");
				}

				$this->Response->Redirect("?page=Contabilidad.AsientoContable.Home");
			}
			catch(exception $e){
				$this->Log($e->getMessage(),true);
			}

		}

	}

	public function LoadDataRelated($idEmpresa)
	{
		$this->dtpFecha->Text = date('d/m/Y');
		$criteria = new TActiveRecordCriteria;
		$criteria->OrdersBy['FechaInicio'] = 'desc';
		$criteria->Condition = 'IdEmpresa = :idEmpresa And Abierto=1 ';
		$criteria->Parameters[':idEmpresa'] = $idEmpresa;
		$finder = EjercicioRecord::finder();
		$ejercicios = $finder->findAll($criteria);
		$this->ddlEjercicio->DataSource = $ejercicios;
		$this->ddlEjercicio->dataBind();

		if(count($ejercicios)==1){
			$this->ddlEjercicio->SelectedValue = $ejercicios[0]->IdEjercicio;
		}

		$idMovimientoCuenta = $this->Request["idmc"];

		if(!is_null($idMovimientoCuenta)){
			$finder = CuentaBancariaMovimientoRecord::finder();
			$cuentaBancariaMovimiento = $finder->findByPk($idMovimientoCuenta);
			$fecha = explode("-", $cuentaBancariaMovimiento->Fecha);
			$this->dtpFecha->Text = $fecha[2]."/".$fecha[1]."/".$fecha[0];
			$this->txtLeyenda->Text = $cuentaBancariaMovimiento->Comprobante;
			$this->lblImporte->Text = "Bank movement amount: " . number_format(abs($cuentaBancariaMovimiento->Importe),2,",",".");
		}

		$idComprobanteCompra = $this->Request["idcc"];

		if(!is_null($idComprobanteCompra)){
			$finder = ComprobanteRecord::finder();
			$comprobante = $finder->findByPk($idComprobanteCompra);
			$finder = TipoComprobanteRecord::finder();
			$tipoComprobante = $finder->findByPk($comprobante->IdTipoComprobante);
			$fecha = explode("-", $comprobante->Fecha);
			$this->dtpFecha->Text = $fecha[2]."/".$fecha[1]."/".$fecha[0];
			$this->txtLeyenda->Text = $tipoComprobante->Abreviatura." ".$comprobante->Numero;
			$this->lblImporte->Text = "Voucher amount: " . number_format($comprobante->ImporteTotal,2,",",".");
		}

		$idPago = $this->Request["idpa"];

		if(!is_null($idPago)){
			$finder = PagoRecord::finder();
			$pago = $finder->findByPk($idPago);
			$fecha = explode("-", $pago->Fecha);
			$this->dtpFecha->Text = $fecha[2]."/".$fecha[1]."/".$fecha[0];
			$this->txtLeyenda->Text = "O.P. " . $pago->OrdenPago;
			$this->lblImporte->Text = "Payment amount: " . number_format($pago->Importe,2,",",".");
		}

		$idComprobanteVenta = $this->Request["idcv"];

		if(!is_null($idComprobanteVenta)){
			$finder = ComprobanteRecord::finder();
			$comprobante = $finder->findByPk($idComprobanteVenta);
			$finder = TipoComprobanteRecord::finder();
			$tipoComprobante = $finder->findByPk($comprobante->IdTipoComprobante);
			$fecha = explode("-", $comprobante->Fecha);
			$this->dtpFecha->Text = $fecha[2]."/".$fecha[1]."/".$fecha[0];
			$this->txtLeyenda->Text = $tipoComprobante->Abreviatura." ".$comprobante->Numero;
			$this->lblImporte->Text = "Voucher amount: " . number_format($comprobante->ImporteTotal,2,",",".");
		}

		$idCobro = $this->Request["idco"];

		if(!is_null($idCobro)){
			$finder = CobroRecord::finder();
			$cobro = $finder->findByPk($idCobro);
			$fecha = explode("-", $cobro->Fecha);
			$this->dtpFecha->Text = $fecha[2]."/".$fecha[1]."/".$fecha[0];
			$this->txtLeyenda->Text = "R.C. " . $cobro->Recibo;
			$this->lblImporte->Text = "Collect amount: " . number_format($cobro->Importe,2,",",".");
		}

	}

	public function acpCuentaAdd_OnSuggestionSelected($sender, $param)
	{
		$this->dgDetalle->Footer->tcCuenta->txtCuentaAdd->Text = $sender->Suggestions->DataKeys[$param->SelectedIndex];
	}

	public function acpCuentaAdd_OnSuggest($sender, $param)
	{
		$this->dgDetalle->Footer->tcCuenta->txtCuentaAdd->Text = "";
		$token = $param->Token;
		$data = $this->CreateDataSource("Query","CuentasSearch",$this->EmpresaSeleccionada(),$token);

		if (count($data) == 0) {
			$data = array(
							array(
								'IdElemento' => '',
								'Elemento' => 'No matches found'
							)
						);
		}

		$sender->DataSource = $data;
		$sender->dataBind();
	}

	public function txtDebeAdd_OnTextChanged($sender, $param)
	{

		if($sender->Text!=""){
			$sender->Text = str_replace(",",".",$sender->Text);
			$sender->Text = number_format(floatval($sender->Text),2,".","");
			$sender->Parent->Parent->tcHaber->txtHaberAdd->Text = "";
		}

	}

	public function txtHaberAdd_OnTextChanged($sender, $param)
	{

		if($sender->Text!=""){
			$sender->Text = str_replace(",",".",$sender->Text);
			$sender->Text = number_format(floatval($sender->Text),2,".","");
			$sender->Parent->Parent->tcDebe->txtDebeAdd->Text = "";
		}

	}

	public function txtDebeAdd_OnServerValidate($sender, $param)
	{

		if($sender->Parent->txtDebeAdd->Text=="" and $sender->Parent->Parent->tcHaber->txtHaberAdd->Text==""){
			$param->IsValid = false;
		}
		else{
			$param->IsValid = true;
		}

	}

	public function LoadDetalle($id)
	{

		if(is_null($id)){
			$data = array(
						array(
							"IdAsientoContableDetalle" => "",
							"IdCuenta" => "",
							"CuentaDesc" => "",
							"Debe" => "",
							"Haber" => "",
							"Leyenda" => ""
						)
					);
		}
		else{
			$data = $this->CreateDataSource("Query","AsientoContableDetalle",$id);
			$this->setViewState("Elementos", $data);
		}

		$this->dgDetalle->DataSource = $data;
		$this->dgDetalle->dataBind();
	}

	public function dgDetalle_OnItemDataBound($sender, $param)
	{

		if(($param->Item->ItemType == TListItemType::Item)||($param->Item->ItemType == TListItemType::AlternatingItem)){

			if($param->Item->tcCuenta->lblCuenta->Text == ""){
				$param->Item->tcEditar->btnEditar->Visible =
				$param->Item->tcEditar->btnBorrar->Visible = false;
			}
			else{

				if($param->Item->tcDebe->lblDebe->Text!=""){
					$param->Item->tcDebe->lblDebe->Text = number_format(floatval($param->Item->tcDebe->lblDebe->Text),2,",",".");
				}

				if($param->Item->tcHaber->lblHaber->Text!=""){
					$param->Item->tcHaber->lblHaber->Text = number_format(floatval($param->Item->tcHaber->lblHaber->Text),2,",",".");
				}

			}

		}

	}

	public function dgDetalle_OnItemCommand($sender, $param)
	{

		if($param->CommandName == "Add"){

			if($this->IsValid){
				$elementos = $this->getViewState("Elementos", array());
				$elemento = array(
								"IdAsientoContableDetalle" => "",
								"IdCuenta" => $this->dgDetalle->Footer->tcCuenta->txtCuentaAdd->Text,
								"CuentaDesc" => $this->dgDetalle->Footer->tcCuenta->acpCuentaAdd->Text,
								"Debe" => $this->dgDetalle->Footer->tcDebe->txtDebeAdd->Text,
								"Haber" => $this->dgDetalle->Footer->tcHaber->txtHaberAdd->Text,
								"Leyenda" => $this->dgDetalle->Footer->tcLeyenda->txtLeyendaAdd->Text
							);
				$elementos[] = $elemento;
				$this->setViewState("Elementos", $elementos);
				$this->dgDetalle->DataSource = $elementos;
				$this->dgDetalle->dataBind();
			}

		}

	}

	public function dgDetalle_OnDataBound($sender, $param)
	{
		$debe =
		$haber = 0;

		foreach($this->dgDetalle->Items as $i){

			if(($i->ItemType == TListItemType::Item)||($i->ItemType == TListItemType::AlternatingItem)){

				if($i->tcDebe->lblDebe->Text!=""){
					$valor = str_replace(".", "", $i->tcDebe->lblDebe->Text);
					$valor = floatval(str_replace(",", ".", $valor));
					$valor = round($valor,2);
					$debe += $valor;
				}

				if($i->tcHaber->lblHaber->Text!=""){
					$valor = str_replace(".", "", $i->tcHaber->lblHaber->Text);
					$valor = floatval(str_replace(",", ".", $valor));
					$valor = round($valor,2);
					$haber += $valor;
				}

			}

			if($i->ItemType == TListItemType::EditItem){

				if($i->tcDebe->txtDebeEdit->Text!=""){
					$valor = floatval($i->tcDebe->txtDebeEdit->Text);
					$valor = round($valor,2);
					$debe += $valor;
				}

				if($i->tcHaber->txtHaberEdit->Text!=""){
					$valor = floatval($i->tcHaber->txtHaberEdit->Text);
					$valor = round($valor,2);
					$haber += $valor;
				}

			}

		}

		$this->dgDetalle->Footer->tcDebe->txtDebeTotal->Text = number_format($debe, 2, ",", ".");
		$this->dgDetalle->Footer->tcHaber->txtHaberTotal->Text = number_format($haber, 2, ",", ".");

		if($debe>$haber){
			$this->dgDetalle->Footer->tcHaber->txtHaberAdd->Text = round($debe - $haber,2);
		}
		else{

			if($haber>$debe){
				$this->dgDetalle->Footer->tcDebe->txtDebeAdd->Text = round($haber-$debe,2);
			}

		}

	}

	public function DebeHaberTotal_OnServerValidate($sender, $param)
	{
		$param->IsValid = ($this->dgDetalle->Footer->tcHaber->txtHaberTotal->Text == $this->dgDetalle->Footer->tcDebe->txtDebeTotal->Text);
	}

	public function acpCuentaEdit_OnSuggest($sender, $param)
	{
		$sender->Parent->txtCuentaEdit->Text = "";
		$token = $param->Token;
		$data = $this->CreateDataSource("Query","CuentasSearch",$this->EmpresaSeleccionada(),$token);

		if (count($data) == 0) {
			$data = array(
							array(
								'IdElemento' => '',
								'Elemento' => 'No matches found'
							)
						);
		}

		$sender->DataSource = $data;
		$sender->dataBind();
	}

	public function acpCuentaEdit_OnSuggestionSelected($sender, $param)
	{
		$sender->Parent->txtCuentaEdit->Text = $sender->Suggestions->DataKeys[$param->SelectedIndex];
	}

	public function txtDebeEdit_OnServerValidate($sender, $param)
	{

		if($sender->Parent->txtDebeEdit->Text=="" and $sender->Parent->Parent->tcHaber->txtHaberEdit->Text==""){
			$param->IsValid = false;
		}
		else{
			$param->IsValid = true;
		}

	}

	public function txtDebeEdit_OnTextChanged($sender, $param)
	{

		if($sender->Text!=""){
			$sender->Text = str_replace(",",".",$sender->Text);
			$sender->Text = number_format(floatval($sender->Text),2,".","");
			$sender->Parent->Parent->tcHaber->txtHaberEdit->Text = "";
		}

	}

	public function txtHaberEdit_OnTextChanged($sender, $param)
	{

		if($sender->Text!=""){
			$sender->Text = str_replace(",",".",$sender->Text);
			$sender->Text = number_format(floatval($sender->Text),2,".","");
			$sender->Parent->Parent->tcDebe->txtDebeEdit->Text = "";
		}

	}

	public function dgDetalle_OnEditCommand($sender, $param)
	{
		$itemIndex = $param->Item->ItemIndex;
		$this->dgDetalle->EditItemIndex = $itemIndex;
		$elementos = $this->getViewState("Elementos", array());
		$this->dgDetalle->DataSource = $elementos;
		$this->dgDetalle->dataBind();
	}

	public function dgDetalle_OnCancelCommand($sender, $param){
		$this->dgDetalle->EditItemIndex = -1;
		$elementos = $this->getViewState("Elementos", array());
		$this->dgDetalle->DataSource = $elementos;
		$this->dgDetalle->dataBind();
	}

	public function dgDetalle_OnUpdateCommand($sender, $param)
	{

		if ($this->IsValid) {
			$elementos = $this->getViewState("Elementos", array());
			$itemIndex = $param->Item->ItemIndex;
			$elementos[$itemIndex]["IdAsientoContableDetalle"] = $param->Item->tcIdDetalle->lblIdAsientoContableDetalleEdit->Text;
			$elementos[$itemIndex]["IdCuenta"] = $param->Item->tcCuenta->txtCuentaEdit->Text;
			$elementos[$itemIndex]["CuentaDesc"] = $param->Item->tcCuenta->acpCuentaEdit->Text;
			$elementos[$itemIndex]["Debe"] = $param->Item->tcDebe->txtDebeEdit->Text;
			$elementos[$itemIndex]["Haber"] = $param->Item->tcHaber->txtHaberEdit->Text;
			$elementos[$itemIndex]["Leyenda"] = $param->Item->tcLeyenda->txtLeyendaEdit->Text;
			$this->dgDetalle->EditItemIndex = -1;
			$this->setViewState("Elementos", $elementos);
			$this->dgDetalle->DataSource = $elementos;
			$this->dgDetalle->dataBind();
		}

	}

	public function dgDetalle_OnDeleteCommand($sender, $param)
	{
		$elementos = $this->getViewState("Elementos", array());
		array_splice($elementos,$param->Item->ItemIndex,1);

		if(count($elementos)){
			$this->setViewState("Elementos",$elementos);
		}
		else{
			$elementos = array(
						array(
							"IdAsientoContableDetalle" => "",
							"IdCuenta" => "",
							"CuentaDesc" => "",
							"Debe" => "",
							"Haber" => "",
							"Leyenda" => ""
						)
					);
			$this->setViewState("Elementos",array());
		}

		$this->dgDetalle->DataSource = $elementos;
		$this->dgDetalle->dataBind();
	}

	public function Cuentas_OnServerValidate($sender, $param)
	{
		$detalles = $this->getViewState("Elementos", array());

		if(count($detalles) > 1){
			$param->IsValid = true;
		}
		else{
			$param->IsValid = false;
		}

	}

	public function Balance_OnServerValidate($sender, $param)
	{
		$detalles = $this->getViewState("Elementos", array());
		$debe =
		$haber = 0;

		foreach ($detalles as $detalle) {
			$debe += floatval($detalle['Debe']);
			$haber += floatval($detalle['Haber']);
		}

		$param->IsValid = (bccomp($debe, $haber)==0);
	}

}

?>