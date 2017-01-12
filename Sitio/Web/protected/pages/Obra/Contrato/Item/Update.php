<?php

class Update extends PageBaseSP{


	public function onLoad($param){
		parent::onLoad($param);

		if(!$this->IsPostBack){
			$idObra = $this->Request["ido"];
			$idContrato = $this->Request["idc"];
			$this->LoadDataRelated($idObra, $idContrato);
			if (!is_null($idContrato)) {
				$this->lblAccion->Text = "Modificar item de Contrato";
				$this->Refresh($idContrato);
			}
		}
	}

	public function LoadDataRelated($idObra, $idContrato){
		$finder = ObraRecord::finder();
		$obra = $finder->findByPk($idObra);
		$finder = OrganismoRecord::finder();
		$organismo = $finder->findByPk($obra->IdOrganismo);
		$localidades = $this->CreateDataSource("ObraPeer","LocalidadesPorObra", $idObra);
		$this->lblObra->Text = $organismo->PrefijoCodigo . '-' . $obra->Codigo . ' ' . $obra->Denominacion . " - " .$localidades[0]["Localidades"];
		$finder = ContratoRecord::finder();
		$contrato = $finder->findByPk($idContrato);
		$finder = ProveedorRecord::finder();
		$proveedor = $finder->findByPk($contrato->IdProveedor);
		$this->lblContrato->Text = $contrato->Numero . " - " . $proveedor->Cuit . " " . $proveedor->RazonSocial;

	}

	public function Refresh($idContrato){

		$this->lblAccion->Text = "Items de Convenio";
		$orden = $this->CreateDataSource("ContratoPeer", "SiguienteNumeroOrden", $idContrato);
		
		$criteria = new TActiveRecordCriteria;
		$criteria->OrdersBy['Orden'] = 'asc';
		$criteria = new TActiveRecordCriteria;
		$criteria->Condition = 'IdContrato = :idcontrato ';
		$criteria->Parameters[':idcontrato'] = $idContrato;
		$finder = ContratoItemPadreRecord::finder();
		$items = $finder->findAll($criteria);
		
		if (count($items) != 0) {
			$this->ddlItemPadre->DataSource = $items;
			$this->ddlItemPadre->dataBind();	
		}					

		$data = $this->CreateDataSource("ContratoPeer","ItemsByContratoConUnidadMedida", $idContrato);
		 		$this->dgItems->DataSource = $data;
		 		$this->dgItems->dataBind();		 
		 		if(count($data)){
		 		$this->lblItems->Visible = false;
		}

		$totalmonto = $this->CreateDataSource("ContratoPeer","TotalMontoItemsByContrato", $idContrato);
		$this->lblTotal->Text = $totalmonto[0]["monto"];
		$totalincidencia = $this->CreateDataSource("ContratoPeer","TotalIncidenciaItemsByContrato", $idContrato);
		$this->lblTotalIncidencia->Text = $totalincidencia[0]["incidencia"];
	}

	public function LimpiarCampos(){
		$this->txtItem->Text = "";
		$this->txtCantidad->Text = "";
		$this->ddlUnidadDeMedida->SelectedValue = 0;
		$this->txtPrecioUnitario->Text = "";
		$this->txtPrecioTotal->Text = "";
		$this->txtIncidencia->Text = "";	
	}

	public function btnCancelar_OnClick($sender, $param)
	{
		$ido = $this->Request["ido"];
		$idc = $this->Request["idc"];
		$this->Response->Redirect("?page=Obra.HomeAdmin");
	}

	public function btnAgregarItem_OnClick($sender, $param)
	{
		if($this->IsValid){
			$idItem = $this->Request["id"];
			$idObra = $this->Request["ido"];
			$idContrato = $this->Request["idc"];

			if($this->chkEsPadre->Checked){
				if(!is_null($idItem)){
					$finder = ContratoItemPadreRecord::finder();
					$contratoitempadre = $finder->findByPk($idItem);
				}
				else{
					$contratoitempadre = new ContratoItemPadreRecord();
					$orden = $this->CreateDataSource("ContratoPeer", "SiguienteNumeroOrden", $idContrato);	
					$contratoitempadre->Orden = $orden[0]["Orden"];
				}
				$contratoitempadre->IdContrato = $idContrato;
				$contratoitempadre->Item = $this->txtItem->Text;

				try{
					$contratoitempadre->save();
					$this->Refresh($idContrato);
					$this->LimpiarCampos();
					}
				
				catch(exception $e){
					$this->Log($e->getMessage(),true);				
				}
			}
			else
			{
				if(!is_null($idItem)){
					$finder = ContratoItemRecord::finder();
					$contratoitem = $finder->findByPk($idItem);
				}
				else{
					$contratoitem = new ContratoItemRecord();
					if($this->ddlItemPadre->SelectedValue!="" and $this->ddlItemPadre->SelectedValue!="0"){
						$idItemPadre = $this->ddlItemPadre->SelectedValue;
						$orden = $this->CreateDataSource("ContratoPeer", "SiguienteNumeroOrdenSubitem", $idContrato,$idItemPadre);	
						$contratoitem->IdContratoItemPadre = $idItemPadre;
						if (!is_null($orden[0]["Orden"])){
							$contratoitem->Orden = $orden[0]["Orden"];	
						}
						else{
							$contratoitem->Orden = 1;
						} 				
					}
					else
					{
						$orden = $this->CreateDataSource("ContratoPeer", "SiguienteNumeroOrden", $idContrato);	
						if (!is_null($orden[0]["Orden"])){
							$contratoitem->Orden = $orden[0]["Orden"];	
						}
						else{
							$contratoitem->Orden = 1;
						} 	
					}
				}
				$contratoitem->IdContrato = $idContrato;				
				$contratoitem->Item = $this->txtItem->Text;
				$contratoitem->Cantidad = $this->txtCantidad->Text;
				$contratoitem->UnidadMedida = $this->ddlUnidadDeMedida->SelectedValue;
				$contratoitem->PrecioUnitario = $this->txtPrecioUnitario->Text;
				$contratoitem->PrecioTotal = $this->txtPrecioTotal->Text;

				try{
					$contratoitem->save();
					}
				
				catch(exception $e){
					$this->Log($e->getMessage(),true);
				}
			}
		}
		$this->Response->Redirect("?page=Obra.Contrato.Item.Update&idc=$idContrato&ido=$idObra");
	}

	public function chkEsPadre_OnCheckedChanged($sender, $param)
	{		
		if($this->chkEsPadre->Checked){
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

    public function txtCantidad_OnTextChanged($sender, $param){
		$this->CalcularTotalItem();
	}

	    public function txtPrecioUnitario_OnTextChanged($sender, $param){
		$this->CalcularTotalItem();
	}


    public function CalcularTotalItem(){
    	$cantidad = floatval($this->txtCantidad->Text);
    	$preciounitario = floatval($this->txtPrecioUnitario->Text);
    	$preciototal = number_format($cantidad * $preciounitario, 2, ".", "");
    	$this->txtPrecioTotal->Text = $preciototal;

    	$idContrato = $this->Request["idc"];
    	$finder = ContratoRecord::finder();
		$contrato = $finder->findByPk($idContrato);
    	$this->txtIncidencia->Text = number_format((($preciototal * 100) / ($contrato->Monto)),2 ,".","") . " %";
	}

}

?>
