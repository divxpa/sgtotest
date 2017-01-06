<?php
class Update extends PageBaseSP{

	public function onLoad($param){
		parent::onLoad($param);

		if(!$this->IsPostBack){
			$idCertificacion = $this->Request["id"];
			$idRendicionCuentas = $this->Request["idc"];
			$this->LoadDataRelated($idCertificacion);

			if (!is_null($idCertificacion)) {
				$this->lblAccion->Text = "Rendición de Cuentas s/Aporte Nacional";
				$this->Refresh($idCertificacion);
				if (!is_null($idRendicionCuentas)) {
				$borrar = $this->Request["borrar"];
				if (!is_null($borrar)) {
					$this->borrarRendicionCuentas($idRendicionCuentas);
				}
				else
					$this->lblAccion->Text = "Guardar Cambios";
					$this->RefreshRendicionCuentas($idRendicionCuentas);
				}
			}
		}
	}

	public function LoadDataRelated($idCertificacion){
		$idContrato = $this->Request["idcontrato"];
		$idObra = $this->Request["ido"];

		$criteria = new TActiveRecordCriteria;
		$criteria->OrdersBy['Nombre'] = 'asc';
		$finder = LocalidadRecord::finder();
		$localidades = $finder->findAll($criteria);
		$this->ddlLocalidad->DataSource = $localidades;
		$this->ddlLocalidad->dataBind();

		$this->hlkVolver->NavigateUrl .= "&idc=$idContrato&ido=$idObra";
	}

	public function Refresh($idContrato){

		$this->lblAccion->Text = "Rendición de Cuentas";
		$this->LimpiarCampos();

		$data = $this->CreateDataSource("RendicionCuentasPeer","RendicionesByCertificacion", $idContrato);
		 		$this->dgCuentas->DataSource = $data;
		 		$this->dgCuentas->dataBind();		 
		 		if(count($data)){
		 		$this->lblCuentas->Visible = false;
		}

	}

	public function RefreshRendicionCuentas($idRendicionCuentas){
		$finder = RendicionCuentasRecord::finder();
		$RendicionCuentas = $finder->findByPk($idRendicionCuentas);
		$this->txtProyecto->Text = $RendicionCuentas->Proyecto;
		$this->ddlLocalidad->SelectedValue = $RendicionCuentas->IdLocalidad;
		$this->txtEmpresa->Text = $RendicionCuentas->Empresa;
		$this->txtCuit->Text = $RendicionCuentas->Cuit;
		$this->txtFacturaNro->Text = $RendicionCuentas->Factura;
		$this->txtReciboNro->Text = $RendicionCuentas->Recibo;
		if(!is_null($RendicionCuentas->FechaEmision)){
			$fecha = explode("-",$RendicionCuentas->FechaEmision);
			$this->dtpFechaEmision->Text = $fecha[2]."/".$fecha[1]."/".$fecha[0];
		}
		$this->txtConcepto->Text = $RendicionCuentas->Concepto;
		if(!is_null($RendicionCuentas->FechaCancelacion)){
			$fecha = explode("-",$RendicionCuentas->FechaCancelacion);
			$this->dtpFechaCancelacion->Text = $fecha[2]."/".$fecha[1]."/".$fecha[0];
		}		
		$this->txtOrdenPago->Text = $RendicionCuentas->OrdenDePago;
		$this->txtMonto->Text = $RendicionCuentas->Monto;
		$this->txtObservacion->Text = $RendicionCuentas->Observaciones; 
		
	}

	public function LimpiarCampos(){
		//$this->txtOrden->Text = "";
		$this->txtProyecto->Text = "";
		$this->ddlLocalidad->SelectedValue=0;
		$this->txtEmpresa->Text = "";
		$this->txtCuit->Text = "";
		$this->txtFacturaNro->Text = "";
		$this->txtReciboNro->Text = "";
		$this->dtpFechaEmision->Text = "";
		$this->txtConcepto->Text = "";
		$this->dtpFechaCancelacion->Text = "";
		$this->txtOrdenPago->Text = "";
		$this->txtMonto->Text = "";
		$this->txtObservacion->Text = "";	
	}

	public function btnCancelar_OnClick($sender, $param){
		$ido = $this->Request["id"];
		//$this->Response->Redirect("?page=Obra.UpdateAdmin&id=$ido&idc=$idc");
		$this->Response->Redirect("?page=Obra.HomeAdmin");
	}

	public function btnAceptar_OnClick($sender, $param){
		$this->Response->Redirect("?page=Obra.HomeAdmin");
	}


	public function btnAgregarRendicion_OnClick($sender, $param){
		$idCertificacion = $this->Request["id"];
		$idRendicion = $this->Request["idc"];
		
		if($this->IsValid){
			if(!is_null($idCertificacion)){
				if(!is_null($idRendicion)){
					$finder = RendicionCuentasRecord::finder();
					$rendicioncuenta = $finder->findByPk($idRendicion);					
				}
				else{
					$rendicioncuenta = new RendicionCuentasRecord();
					$orden = $this->CreateDataSource("RendicionCuentasPeer", "ProximaOrderRendicionesByCertificacion", $idCertificacion);
					$this->$rendicioncuenta->Orden = $orden;
					$rendicioncuenta->IdCertificacion = $idCertificacion;
					$rendicioncuenta->Activo = 1;
					$rendicioncuenta->Estado = 0;
				}								
				$rendicioncuenta->Proyecto = $this->txtProyecto ->Text;
				$rendicioncuenta->IdLocalidad = $this->ddlLocalidad ->SelectedValue;
				$rendicioncuenta->Empresa = $this->txtEmpresa ->Text;
				$rendicioncuenta->Cuit = $this->txtCuit->Text;
				$rendicioncuenta->Factura = $this->txtFacturaNro->Text;
				$rendicioncuenta->Recibo = $this->txtReciboNro->Text;

				if($this->dtpFechaEmision->Text!=""){
					$fecha = explode("/", $this->dtpFechaEmision->Text);
					$rendicioncuenta->FechaEmision = $fecha[2]."-".$fecha[1]."-".$fecha[0];
				}

				$rendicioncuenta->Concepto = $this->txtConcepto->Text;

				if($this->dtpFechaCancelacion->Text!=""){
					$fecha = explode("/", $this->dtpFechaCancelacion->Text);
					$rendicioncuenta->FechaCancelacion = $fecha[2]."-".$fecha[1]."-".$fecha[0];
				}

				$rendicioncuenta->OrdenDePago = $this->txtOrdenPago->Text;
				$rendicioncuenta->Monto = $this->txtMonto->Text;
				$rendicioncuenta->Observaciones = $this->txtObservacion->Text;
				//$rendicioncuenta->Estado = $this-> ->Text;
				//$rendicioncuenta->Revision = $this-> ->Text;
				

			try{
				$rendicioncuenta->save();
				$this->Refresh($idCertificacion);
				}

			catch(exception $e){
				$this->Log($e->getMessage(),true);
			}
		}
		}
	}

	public function btnAgregarRendicion2_OnClick($sender, $param){
		$finder = RendicionCuentasRecord::finder();
		$rendicioncuenta = $finder->findByPk($idRendicionCuentas);
		$rendicioncuenta->Activo = 0;
		try{
				$rendicioncuenta->save();
				$this->Refresh($idCertificacion);
				}

			catch(exception $e){
				$this->Log($e->getMessage(),true);
			}

	}

	public function borrarRendicionCuentas($idRendicionCuentas){
		$finder = RendicionCuentasRecord::finder();
		$rendicioncuenta = $finder->findByPk($idRendicionCuentas);
		$rendicioncuenta->Activo = 0;
		try{
				//echo "<pre>";print_r($rendicioncuenta); die();
				$rendicioncuenta->save();
				//$this->Refresh($idCertificacion);
				}

			catch(exception $e){
				$this->Log($e->getMessage(),true);
			}

	}

	public function ObtenerProximaRendicion($idCertificacion){

	}
}
?>
