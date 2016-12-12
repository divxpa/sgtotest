<?php
class Update extends PageBaseSP{

	public function onLoad($param){
		parent::onLoad($param);

		if(!$this->IsPostBack){
			$idObra = $this->Request["ido"];
			$idContrato = $this->Request["idc"];
			$this->LoadDataRelated($idObra, $idContrato);
			$id = $this->Request["id"];

			if (!is_null($id)) {
				$this->lblAccion->Text = "Modificar item de Contrato";
				$this->Refresh($id);
			}
			else
			{
				$this->lblAccion->Text = "Nuevo item de Contrato";
				$orden = $this->CreateDataSource("ContratoPeer", "SiguienteNumeroOrden", $idContrato);
				$this->txtOrden->Text = $orden[0]["Orden"];
				if ($orden>1){
					$this->pnlItemPadre->Display = "Dynamic";
					$criteria = new TActiveRecordCriteria;
					$criteria->OrdersBy['Orden'] = 'asc';
					$criteria = new TActiveRecordCriteria;
					$criteria->Condition = 'IdContrato = :idcontrato ';
					$criteria->Parameters[':idcontrato'] = $idContrato;
					$finder = ContratoItemRecord::finder();
					$items = $finder->findAll($criteria);
					$this->ddlItemPadre->DataSource = $items;
					$this->ddlItemPadre->dataBind();	
				}				
			}
		}
	}

	public function LoadDataRelated($idObra, $idContrato){
		//Lista de Items padre
		//Proximo nro de orden
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

	public function Refresh($idContratoItem){

		$finder = ContratoItemRecord::finder();
		$contratoitem = $finder->findByPk($idContratoItem);

		$this->txtOrden->Text = $contratoitem->Orden;
		$this->txtItem->Text = $contratoitem->Item;
		$this->txtCantidad->Text = $contratoitem->Cantidad;
		$this->ddlUnidadDeMedida->SelectedValue = $contratoitem->UnidadMedida;
		$this->txtPrecioUnitario->Text = $contratoitem->PrecioUnitario;
		$this->txtPrecioTotal->Text = $contratoitem->PrecioTotal;

	}

	public function btnCancelar_OnClick($sender, $param)
	{
		$ido = $this->Request["ido"];
		$idc = $this->Request["idc"];
		$this->Response->Redirect("?page=Obra.UpdateAdmin&id=$ido&idc=$idc");
	}

	public function btnAceptar_OnClick($sender, $param)
	{
		$ido = $this->Request["ido"];
		$idc = $this->Request["idc"];
		if($this->IsValid){
			$id = $this->Request["id"];
			$idObra = $this->Request["ido"];
			$idContrato = $this->Request["idc"];

			if(!is_null($id)){
				$finder = ContratoItemRecord::finder();
				$contratoitem = $finder->findByPk($id);
			}
			else{
				$contratoitem = new ContratoItemRecord();
			}
			$contratoitem->IdContrato = $idContrato;
			$contratoitem->Orden = $this->txtOrden->Text;
			$contratoitem->Item = $this->txtItem->Text;
			$contratoitem->Cantidad = $this->txtCantidad->Text;
			$contratoitem->UnidadMedida = $this->ddlUnidadDeMedida->SelectedValue;
			$contratoitem->PrecioUnitario = $this->txtPrecioUnitario->Text;
			$contratoitem->PrecioTotal = $this->txtPrecioTotal->Text;

			try{
				$contratoitem->save();
				//$this->Response->Redirect("?page=Obra.UpdateAdmin&id=$idObra&idc=$idContrato");
				$this->Response->Redirect("?page=Obra.UpdateAdmin&id=$ido&idc=$idc");
			}
			catch(exception $e){
				$this->Log($e->getMessage(),true);
			}
		}
	}
}

?>
