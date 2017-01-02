<?php
class Update extends PageBaseSP{

	public function onLoad($param){
		parent::onLoad($param);

		if(!$this->IsPostBack){
			$idCertificacion = $this->Request["id"];
			$this->LoadDataRelated($idCertificacion);

			if (!is_null($idCertificacion)) {
				$this->lblAccion->Text = "Rendición de Cuentas s/Aporte Nacional";
				$this->Refresh($idCertificacion);
			}
		}
	}

	public function LoadDataRelated($idCertifiacion){
		
	}

	public function Refresh($idContrato){

		$this->lblAccion->Text = "Nuevo item de Contrato";

		$data = $this->CreateDataSource("ContratoPeer","RendicionesByCertificacion", $idContrato);
		 		$this->dgCuentas->DataSource = $data;
		 		$this->dgCuentas->dataBind();		 
		 		if(count($data)){
		 		$this->lblItems->Visible = false;
		}
	}

	public function LimpiarCampos(){
		// $this->txtItem->Text = "";
		// $this->txtCantidad->Text = "";
		// $this->ddlUnidadDeMedida->SelectedValue = 0;
		// $this->txtPrecioUnitario->Text = "";
		// $this->txtPrecioTotal->Text = "";
	}

	public function btnCancelar_OnClick($sender, $param)
	{
		$ido = $this->Request["id"];
		//$this->Response->Redirect("?page=Obra.UpdateAdmin&id=$ido&idc=$idc");
		$this->Response->Redirect("?page=Obra.HomeAdmin");
	}

	public function btnAceptar_OnClick($sender, $param)
	{
		$this->Response->Redirect("?page=Obra.HomeAdmin");
	}

	public function btnAgregarRendicion_OnClick($sender, $param)
	{
		$idCertificacion = $this->Request["id"];
		
		if($this->IsValid){
			if(!is_null($idCertificacion)){
				$rendicioncuenta = new RendicionCuentasRecord();
				$rendicioncuenta->IdCertificacion = $this->idCertificacion;
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
				$rendicioncuenta->Estado = $this-> ->Text;
				$rendicioncuenta->Revision = $this-> ->Text;
				$rendicioncuenta->Activo = 1;

			try{
				$rendicioncuenta->save();
				$this->Refresh($idCertificacion);
				$this->LimpiarCampos();
				}

			catch(exception $e){
				$this->Log($e->getMessage(),true);
			}
		}
	}

	public function chkEsPadre_OnCheckedChanged($sender, $param)
	{		
		if($this->chkEsPadre->Checked){
			$this->pnlItem->Display = "None";
			$this->pnlItemPadre->Display = "None";
			//$this->ddlItemPadre->SelectedValue = 0;
			$this->ddlItemPadre->dataBind();
			//Controlar el ID de ItemPadre
		}
		else{
			$this->pnlItem->Display = "Dynamic";
			$this->pnlItemPadre->Display = "Dynamic";
		}
	}

	public function selectionChanged($sender,$param)
    {
       if ($this->ddlItemPadre->SelectedValue!="0"){
       		$this->pnlItem->Display = "Dynamic";
       }
       else{
       		$this->pnlItem->Display = "None";
       }

    }

}

?>
