<?php
class Aniversario extends PageBaseSP{

	public function onPreInit($param){
		parent::onPreInit($param);
		$this->MasterClass = "Application.layouts.DialogLayout";
	}

	public function onLoad($param){
		parent::onLoad($param);

		if(!$this->IsPostBack){
			$this->LoadDataRelated();
			$id = $this->Request["id"];
			//$this->Refresh($id);
			
			// NUEVO
			//$this->ddlLocalidad->SelectedValue = $this->GetSearchMemory($this->PagePath, $this->ddlLocalidad->ID);
			$this->ddlOrganismo->SelectedValue = $this->GetSearchMemory($this->PagePath, $this->ddlOrganismo->ID);
			$this->Refresh($id);
		}
	}
	
		public function LoadDataRelated(){
		$idUsuario = $this->Session["SPIdUsuario"];
		$finder = UsuarioRecord::finder();
		$usuario = $finder->findByPk($idUsuario);
		
		$criteria = new TActiveRecordCriteria;
		$criteria->OrdersBy['Nombre'] = 'asc';
		$finder = OrganismoRecord::finder();

		if($usuario->IdRol!=1){
			$criteria->Condition = 'IdOrganismo = :idorganismo ';
			$criteria->Parameters[':idorganismo'] = $usuario->IdOrganismo;
			$this->SaveSearchMemory($this->PagePath, $this->ddlOrganismo->ID, $usuario->IdOrganismo);
		}
		else{
			$this->ddlOrganismo->PromptValue="0";
			$this->ddlOrganismo->PromptText="Seleccione";
		}

		$organismos = $finder->findAll($criteria);
		$this->ddlOrganismo->DataSource = $organismos;
		$this->ddlOrganismo->dataBind();
		
		//$localidades = $this->CreateDataSource("LocalidadPeer","Aniversarios", $idOrganismo);
		// $this->ddlLocalidad->DataSource = $localidades;
		// $this->ddlLocalidad->dataBind();
	}

	public function Refresh($id)
	{
		$finder = LocalidadRecord::finder();
		$localidad = $finder->findByPk($id);

		$this->lblLocalidad->Text = 
		$this->lblLocalidad2->Text = $localidad->Nombre;

		$fecha = explode("-", $localidad->Aniversario);
		$this->lblAniversario->Text = $fecha[2]."/".$fecha[1]."/".$fecha[0];
		$cargoAutoridad = "";

		switch ($localidad->Categoria) {
			case 1:
				$cargoAutoridad = "Intendente";
				$this->lblCategoria->Text = "Municipalidad de 1° Categoría";
				break;
			case 2:
				$cargoAutoridad = "Intendente";
				$this->lblCategoria->Text = "Municipalidad de 2° Categoría";
				break;
			case 3:
				$cargoAutoridad = "Intendente";
				$this->lblCategoria->Text = "Municipalidad de 3° Categoría";
				break;
			case 4:
				$cargoAutoridad = "Presidente";
				$this->lblCategoria->Text = "Comisión de Fomento";
				break;
		}

		$this->lblAutoridades->Text = $cargoAutoridad . " - " . $localidad->Autoridad;
		$this->lblHabitantes->Text = number_format($localidad->Habitantes, 0, "", ".");

		$this->lblEscudo->Text = "Escudo de la localidad";

		if(!is_null($localidad->FotoEscudo) and $localidad->FotoEscudo!=""){
			$this->imgEscudo->ImageUrl = $localidad->FotoEscudo;
		}
		else{
			$this->imgEscudo->ImageUrl = "upload/localidad/no_image.jpg";
		}

		$this->lblAutoridades2->Text = $cargoAutoridad . " - " . $localidad->Autoridad;

		if(!is_null($localidad->FotoAutoridad) and $localidad->FotoAutoridad!=""){
			$this->imgAutoridad->ImageUrl = $localidad->FotoAutoridad;
		}
		else{
			$this->imgAutoridad->ImageUrl = "upload/localidad/no_image.jpg";
		}

		$this->lblLocalidad3->Text = "Fotografía de la localidad";

		if(!is_null($localidad->FotoLocalidad) and $localidad->FotoLocalidad!=""){
			$this->imgLocalidad->ImageUrl = $localidad->FotoLocalidad;
		}
		else{
			$this->imgLocalidad->ImageUrl = "upload/localidad/no_image.jpg";
		}

		$data = $this->CreateDataSource("ObraPeer","ObrasByLocalidad", $id);
		//echo"<pre>";print_r($data);echo"</pre>";exit;
		$this->dgDatos->DataSource = $data;
		$this->dgDatos->dataBind();
		$this->setViewState("Data",$data);
		$monto =
		$beneficiarios = 
		$manoobra = 0;

		foreach ($data as $d) {
			$monto += $d["Monto"];
			$beneficiarios += $d["CantidadBeneficiarios"];
			$manoobra += $d["CantidadManoObra"];
		}

		$this->lblTotalObras->Text = count($data);
		$this->lblTotalMonto->Text = "$ ".number_format($monto, 2, ",", ".");
		/*$this->lblTotalBeneficiarios->Text = number_format($beneficiarios, 0, "", ".");
		$this->lblTotalManoObra->Text = number_format($manoobra, 0, "", ".");*/
		
		
		$idOrganismo = $this->ddlOrganismo->SelectedValue;
		$localidades = $this->CreateDataSource("LocalidadPeer","Aniversarios", $idOrganismo);
		
	}

	public function btnPdf_OnClick($sender, $param)
	{

		$obras = $this->getViewState("Data", array());
		$data = array(
					"Localidad" => $this->lblLocalidad->Text,
					"Aniversario" => $this->lblAniversario->Text,
					"Categoria" => $this->lblCategoria->Text,
					"Autoridades" => $this->lblAutoridades->Text,
					"Habitantes" => $this->lblHabitantes->Text,
					"FotoEscudo" => $this->imgEscudo->ImageUrl,
					"FotoLocalidad" => $this->imgLocalidad->ImageUrl,
					"FotoAutoridad" => $this->imgAutoridad->ImageUrl,
					"CantidadObras" => $this->lblTotalObras->Text,
					"MontoTotal" => $this->lblTotalMonto->Text,
					/*"TotalBeneficiarios" => $this->lblTotalBeneficiarios->Text,
					"TotalManoObra" => $this->lblTotalManoObra->Text,*/
					"Obras" => $obras
				);
		$file = $this->GenerarReporte("AniversarioReport", "A4-L", array(), $data);
		$this->CallbackClient->callClientFunction("Imprimir",array($file));
	}

}

?>