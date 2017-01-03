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
				$this->RefreshRendicionCuentas($idRendicionCuentas);
			}
			}
		}
	}

	public function LoadDataRelated($idCertificacion){
		$criteria = new TActiveRecordCriteria;
		$criteria->OrdersBy['Nombre'] = 'asc';
		$finder = LocalidadRecord::finder();
		$localidades = $finder->findAll($criteria);
		$this->ddlLocalidad->DataSource = $localidades;
		$this->ddlLocalidad->dataBind();
	}

	public function Refresh($idContrato){

		$this->lblAccion->Text = "Nuevo item de Contrato";
		$this->LimpiarCampos();

		$data = $this->CreateDataSource("ContratoPeer","RendicionesByCertificacion", $idContrato);
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
		$this->txtOrden->Text = "";
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
		
		if($this->IsValid){
			if(!is_null($idCertificacion)){
				$rendicioncuenta = new RendicionCuentasRecord();
				$rendicioncuenta->IdCertificacion = $idCertificacion;
				$rendicioncuenta->Orden = $this->txtOrden ->Text;
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
				$rendicioncuenta->Activo = 1;

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
}
?>
