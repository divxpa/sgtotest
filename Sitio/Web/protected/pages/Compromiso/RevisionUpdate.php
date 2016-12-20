<?php
class RevisionUpdate extends PageBaseSP{

	public function onLoad($param){
		parent::onLoad($param);

		if(!$this->IsPostBack){
			$this->LoadDataRelated();
			$id = $this->Request["idRevision"];
			if (!is_null($id)) {
				$this->lblAccion->Text = "Modificar Revision Compromiso";
				$this->Refresh($id);
			}			
		}		
	}

	
	public function LoadDataRelated(){		
		
		// $criteria = new TActiveRecordCriteria;
		// $criteria->OrdersBy['Nombre'] = 'asc';
		// $finder = LocalidadRecord::finder();
		// $localidades = $finder->findAll($criteria);
		// $this->ddlLocalidad->DataSource = $localidades;
		// $this->ddlLocalidad->dataBind();
		
		// $responsables = $this->CreateDataSource("CompromisoResponsablePeer","CompromisoResponsableSelect");		
		// $this->ddlResponsable->DataSource = $responsables;
		// $this->ddlResponsable->dataBind();

		
	}
		
	public function Refresh($IdCompromisoRevision){
		
		$finder = CompromisoRevisionRecord::finder();
		$compromisoRevision = $finder->findByPk($IdCompromisoRevision);
		
		if(!is_null($compromisoRevision->Fecha)){
			$fecha = explode("-",$compromisoRevision->Fecha);
			$this->lblFecha->Text = $fecha[2]."/".$fecha[1]."/".$fecha[0];
		} 

		$this->txtDenominacion->Text = $compromisoRevision->Revision;

	}

	
	public function btnCancelar_OnClick($sender, $param){
		$idCompromiso = $this->Request["idCompromiso"];
		$this->Response->Redirect("?page=Compromiso.Update&id=$idCompromiso");
	}

	public function btnAceptar_OnClick($sender, $param)	{ 
		if($this->IsValid){
			$idCompromiso = $this->Request["idCompromiso"];
			$idRevision = $this->Request["idRevision"];

			if(!is_null($idRevision)){
				$finder = CompromisoRevisionRecord::finder();
				$compromisoRevision = $finder->findByPk($idRevision);
			}
			else{
				$compromisoRevision = new CompromisoRevisionRecord();
			}
			
			$compromisoRevision->IdCompromiso = $idCompromiso;
			$compromisoRevision->Revision = $this->txtDenominacion->Text;
			$idUsuario = $this->Session["SPIdUsuario"];
			$finder = UsuarioRecord::finder();
			$usuario = $finder->findByPk($idUsuario);
			$compromisoRevision->IdUsuario = $usuario->IdUsuario;						
			$compromisoRevision->Activo = True;
			
			try{
				$compromisoRevision->Fecha = date('Y-m-d H:i:s');
				$compromisoRevision->save();
				$this->Response->Redirect("?page=Compromiso.Update&id=$idCompromiso");
			}
			catch(exception $e){
				$this->Log($e->getMessage(),true);
			}
		}
	 }
}
?>
