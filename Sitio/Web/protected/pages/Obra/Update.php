<?php
class Update extends PageBaseSP{

	public function onLoad($param){
		parent::onLoad($param);

		if(!$this->IsPostBack){				//Si es es Distinto de un Post
			$this->LoadDataRelated();		//Cargo todos los valores iniciales de la pagina con los valores de la obra
			$id = $this->Request["id"];		//al $id le asigno el valor del Request id

			if (!is_null($id)) {
				$this->lblAccion->Text = "Modificar Obra";
				$this->Refresh($id);
			}
			else{
				$idOrganismo = $this->Session["SPOrganismo"];
				$codigo = $this->CreateDataSource("ObraPeer", "SiguienteCodigoObra", $idOrganismo);
				$this->txtCodigo->Text = $codigo[0]["Codigo"];
			}

		}

	}

	public function LoadDataRelated(){
		$idOrganismo = $this->Session["SPOrganismo"]; 	//Obtengo el Organismo del Usuario de la sesion
		$criteria = new TActiveRecordCriteria; 			//Creo una nueva instancia del criterio de la busqueda
		$criteria->OrdersBy['Nombre'] = 'asc'; 			//Ordeno el resultado de la busqueda
		$criteria = new TActiveRecordCriteria; 			//Creo una nueva instancia del criterio de la busqueda
		$criteria->Condition = 'IdOrganismo = :idorganismo OR Comitente=1 ';	//Condicion del Where, que el organismo sea igual a idOrganismo o que Comitente = 1 //RESOLVER
		$criteria->Parameters[':idorganismo'] = $idOrganismo;					//Parametros: idorganismo le asigno el organismo del usuario
		$finder = OrganismoRecord::finder();			//Busco la Clase OrganismoRecord
		$organismos = $finder->findAll($criteria);		//Busco todos los organismos
		$this->ddlComitente->DataSource = $organismos;	//Cargo el Combo ddlComitente con todos los organismos
		$this->ddlComitente->dataBind();				//Databind del ddlComitente
		$this->ddlComitente->SelectedValue = $idOrganismo; //Selecciono el Organismo correspondiente al Organismo del usuario

		$criteria = new TActiveRecordCriteria;			//Creo una nueva instancia del criterio de la busqueda
		$criteria->OrdersBy['Nombre'] = 'asc';			//Ordeno el resultado de la busqueda
		$finder = LocalidadRecord::finder();			//Busco la Clase LocalidadRecord
		$localidades = $finder->findAll($criteria);		//Busco todas las Localidades con el criterio de busqueda
		$this->ddlLocalidad1->DataSource = $localidades;	//Cargo a todos los Combos con las localidades
		$this->ddlLocalidad1->dataBind();
		$this->ddlLocalidad2->DataSource = $localidades;
		$this->ddlLocalidad2->dataBind();
		$this->ddlLocalidad3->DataSource = $localidades;
		$this->ddlLocalidad3->dataBind();
		$this->ddlLocalidad4->DataSource = $localidades;
		$this->ddlLocalidad4->dataBind();
		$this->ddlLocalidad5->DataSource = $localidades;
		$this->ddlLocalidad5->dataBind();
		$this->ddlLocalidad6->DataSource = $localidades;
		$this->ddlLocalidad6->dataBind();
		$this->ddlLocalidad7->DataSource = $localidades;
		$this->ddlLocalidad7->dataBind();
		$this->ddlLocalidad8->DataSource = $localidades;
		$this->ddlLocalidad8->dataBind();
		$this->ddlLocalidad9->DataSource = $localidades;
		$this->ddlLocalidad9->dataBind();
		$this->ddlLocalidad10->DataSource = $localidades;
		$this->ddlLocalidad10->dataBind();
		$this->ddlLocalidad11->DataSource = $localidades;
		$this->ddlLocalidad11->dataBind();
		$this->ddlLocalidad12->DataSource = $localidades;
		$this->ddlLocalidad12->dataBind();
		$this->ddlLocalidad13->DataSource = $localidades;
		$this->ddlLocalidad13->dataBind();
		$this->ddlLocalidad14->DataSource = $localidades;
		$this->ddlLocalidad14->dataBind();
		$this->ddlLocalidad15->DataSource = $localidades;
		$this->ddlLocalidad15->dataBind();
		$this->ddlLocalidad16->DataSource = $localidades;
		$this->ddlLocalidad16->dataBind();
		$this->ddlLocalidad17->DataSource = $localidades;
		$this->ddlLocalidad17->dataBind();
		$this->ddlLocalidad18->DataSource = $localidades;
		$this->ddlLocalidad18->dataBind();
		$this->ddlLocalidad19->DataSource = $localidades;
		$this->ddlLocalidad19->dataBind();
		$this->ddlLocalidad20->DataSource = $localidades;
		$this->ddlLocalidad20->dataBind();

		$criteria = new TActiveRecordCriteria;		//Creo una nueva instancia del criterio de la busqueda
		$criteria->OrdersBy['Descripcion'] = 'asc'; //Ordeno el resultado de la busqueda
		$finder = EstadoObraRecord::finder();		//Busco la Clase EstadoObraRecord
		$estados = $finder->findAll($criteria);		//Busco todos los estados con el criterio de busqueda
		$this->ddlEstado->DataSource = $estados;	//Cargo todos el combo con todos los estados
		$this->ddlEstado->dataBind();

		$fuentesfinanciamiento = $this->CreateDataSource("FuenteFinanciamientoPeer","FuentesFinanciamientoSelect"); //Creo un DataSource con todas las FUFIS concatenadas Codigo + Descripcion
		$this->ddlFufi1->DataSource = $fuentesfinanciamiento; //Cargo en los combos las fuentes de financiamiento
		$this->ddlFufi1->dataBind();
		$this->ddlFufi2->DataSource = $fuentesfinanciamiento;
		$this->ddlFufi2->dataBind();
		$this->ddlFufi3->DataSource = $fuentesfinanciamiento;
		$this->ddlFufi3->dataBind();

		$criteria = new TActiveRecordCriteria;
		$criteria->OrdersBy['Descripcion'] = 'asc';
		$finder = TipoObraRecord::finder();
		$tipos = $finder->findAll($criteria);
		$this->ddlTipo->DataSource = $tipos;
		$this->ddlTipo->dataBind();
	}

	public function Refresh($idObra){
		$idOrganismo = $this->Session["SPOrganismo"];	//Obtengo ei Organismo del Usuario
		$finder = ObraRecord::finder();					//Busco la Clase ObraRecord
		$obra = $finder->findByPk($idObra);				//Busco la obra mediante el IdObra

		if(!$this->ValidarObraOrganismo($idOrganismo, $idObra)){	//Controlo que la obra sea del mismo organismo 
			$this->Response->Redirect("?page=Obra.Home");			//Redireccion al Home de Obra
		}
		//Asigno los valores de la Obra a los campos correspondientes
		$this->txtCodigo->Text = $obra->Codigo;						
		$this->txtDenominacion->Text = $obra->Denominacion;
		$this->txtExpediente->Text = $obra->Expediente;
		$this->ddlComitente->SelectedValue = $obra->IdComitente;
		$this->txtCreditoPresup->Text = $obra->CreditoPresupuestarioAprobado;

		$criteria = new TActiveRecordCriteria;			//Creo una instancia del criterio de la busqueda
		$criteria->Condition = 'IdObra = :idobra ';		//Como condicion coloco 
		$criteria->Parameters[':idobra'] = $idObra;
		$criteria->OrdersBy['IdFuenteFinanciamiento'] = 'asc';
		$finder = ObraFuenteFinanciamientoRecord::finder();
		$fufis = $finder->findAll($criteria);			//Busco todas las fuentes de financiamiento de la obra
		$i = 1;	

		foreach($fufis as $f){	//Para cada fuente de financiamiento, selecciono un ddl con la fufi que tiene la obra
			$controlName = "ddlFufi$i";
			$this->$controlName->SelectedValue = $f->IdFuenteFinanciamiento;
			$i++;
		}

		$this->txtPresupuestoOficial->Text = $obra->PresupuestoOficial;

		if(!is_null($obra->FechaPresupuestoOficial)){
			$fecha = explode("-",$obra->FechaPresupuestoOficial);
			$this->dtpFechaPresupOficial->Text = $fecha[2]."/".$fecha[1]."/".$fecha[0];
		}

		$criteria = new TActiveRecordCriteria;
		$criteria->Condition = 'IdObra = :idobra ';
		$criteria->Parameters[':idobra'] = $idObra;
		$criteria->OrdersBy['IdLocalidad'] = 'asc';
		$finder = ObraLocalidadRecord::finder();
		$localidades = $finder->findAll($criteria);
		$i = 1;

		foreach($localidades as $l){
			$controlName = "ddlLocalidad$i";
			$this->$controlName->SelectedValue = $l->IdLocalidad;
			$i++;
		}

		if($i>4){
			$this->pnlMasLocalidades->Display = "Dynamic";
		}

		$this->txtLatitud->Text = $obra->Latitud;
		$this->txtLongitud->Text = $obra->Longitud;

		if(!is_null($obra->IdTipoObra)){
			$this->ddlTipo->SelectedValue = $obra->IdTipoObra;
		}

		$this->txtBeneficiarios->Text = $obra->CantidadBeneficiarios;

		if(!is_null($obra->FechaInauguracion)){
			$fecha = explode("-",$obra->FechaInauguracion);
			$this->dtpFechaInauguracion->Text = $fecha[2]."/".$fecha[1]."/".$fecha[0];
		}

		$this->ddlEstado->SelectedValue = $obra->IdEstadoObra;
		$this->txtDetalleEstado->Text = $obra->DetalleEstado;
		$this->txtMemoriaDescriptiva->Text = $obra->MemoriaDescriptiva;

		$this->pnlModificacionObra->Visible = true;

		$this->btnAgregarRefuerzo->NavigateUrl .= "&ido=".$idObra;
		$data = $this->CreateDataSource("ObraPeer","RefuerzosPartidaByObra", $idObra);
		$this->dgRefuerzosPartida->DataSource = $data;
		$this->dgRefuerzosPartida->dataBind();

		if(count($data)){
			$this->lblRefuerzosPartida->Visible = false;
		}

	}

	public function cvCodigo_OnServerValidate($sender, $param)
	{
		$idOrganismo = $this->Session["SPOrganismo"];
		$codigo = $this->txtCodigo->Text;
		
		$criteria = new TActiveRecordCriteria;
		$criteria->Condition = 'IdOrganismo = :idorganismo AND Codigo like :codigo ';
		$criteria->Parameters[':idorganismo'] = $idOrganismo;
		$criteria->Parameters[':codigo'] = $codigo;

		$id = $this->Request["id"];

		if(!is_null($id)){
			$criteria->Condition .=  ' AND IdObra <> :idobra';
			$criteria->Parameters[':idobra'] = $id;
		}

		$finder = ObraRecord::finder();
		$obra = $finder->find($criteria);

		if (is_object($obra)) {
			$param->IsValid = false;
		}
		else {
			$param->IsValid = true;
		}

	}

	public function btnCancelar_OnClick($sender, $param)
	{
		$this->Response->Redirect("?page=Obra.Home");
	}

	public function btnAceptar_OnClick($sender, $param)
	{

		if($this->IsValid){									//Si la pagina es Valida
			$id = $this->Request["id"];						//$id le asigna el Id
			$idOrganismo = $this->Session["SPOrganismo"];	//Obtiene el Organismo de la sesion

			if(!is_null($id)){								//Si $id no es null, actualizo la obra
				$finder = ObraRecord::finder();				//Buscla la clase ObraRecord
				$obra = $finder->findByPk($id);				//Obtiene la Obra por medio del Id

				$criteria = new TActiveRecordCriteria;		//Crea un criterio de busqueda
				$criteria->Condition = 'IdObra = :idobra ';	//Condicion
				$criteria->Parameters[':idobra'] = $id;		//Parametros
				$finder = ObraFuenteFinanciamientoRecord::finder(); //Busca la clase ObraFuenteFinanciamiento
				$fufis = $finder->findAll($criteria);				//Busca las FUFIS en base a los criterios de busqueda

				foreach($fufis as $f){						//Borra todas las FUFIS de la OBRA
					$f->delete();
				}

				$criteria = new TActiveRecordCriteria;		//Crea un criterio de busqueda
				$criteria->Condition = 'IdObra = :idobra ';	//Condicion
				$criteria->Parameters[':idobra'] = $id;		//Parametros
				$finder = ObraLocalidadRecord::finder();	//Busca la clase ObraLocalidadRecord
				$localidades = $finder->findAll($criteria);	//Busco las localidades con el criterio de busqueda

				foreach($localidades as $l){				//Borro todas las localidades de la OBRA
					$l->delete();
				}

			}
			else{//La obra no existe, entonces la creo
				$obra = new ObraRecord();	//Creo una nueva obra
				$obra->IdOrganismo = $idOrganismo;	//a la Obra le asigno el Organismo
			}

			$obra->Codigo = $this->txtCodigo->Text;
			$obra->Denominacion = mb_strtoupper($this->txtDenominacion->Text, 'utf-8');
			$obra->Expediente = $this->txtExpediente->Text;
			$obra->IdComitente = $this->ddlComitente->SelectedValue;

			if($this->txtCreditoPresup->Text!=""){
				$obra->CreditoPresupuestarioAprobado = $this->txtCreditoPresup->Text;
			}
			else{
				$obra->CreditoPresupuestarioAprobado = null;
			}

			if($this->txtPresupuestoOficial->Text!=""){
				$obra->PresupuestoOficial = $this->txtPresupuestoOficial->Text;
			}
			else{
				$obra->PresupuestoOficial = null;
			}

			if($this->dtpFechaPresupOficial->Text!=""){
				$fecha = explode("/", $this->dtpFechaPresupOficial->Text);
				$obra->FechaPresupuestoOficial = $fecha[2]."-".$fecha[1]."-".$fecha[0];
			}
			else{
				$obra->FechaPresupuestoOficial = null;
			}

			$obra->Latitud = $this->txtLatitud->Text;
			$obra->Longitud = $this->txtLongitud->Text;

			if($this->ddlTipo->SelectedValue!="" and $this->ddlTipo->SelectedValue!="0"){
				$obra->IdTipoObra = $this->ddlTipo->SelectedValue;
			}
			else{
				$obra->IdTipoObra = null;
			}

			if($this->txtBeneficiarios->Text!=""){
				$obra->CantidadBeneficiarios = $this->txtBeneficiarios->Text;
			}
			else{
				$obra->CantidadBeneficiarios = null;
			}

			if($this->dtpFechaInauguracion->Text!=""){
				$fecha = explode("/", $this->dtpFechaInauguracion->Text);
				$obra->FechaInauguracion = $fecha[2]."-".$fecha[1]."-".$fecha[0];
			}
			else{
				$obra->FechaInauguracion = null;
			}

			$obra->IdEstadoObra = $this->ddlEstado->SelectedValue;
			$obra->DetalleEstado = mb_strtoupper($this->txtDetalleEstado->Text, 'utf-8');
			$obra->MemoriaDescriptiva = mb_strtoupper($this->txtMemoriaDescriptiva->Text, 'utf-8');

			try{
				$obra->save();

				$obraFufi = new ObraFuenteFinanciamientoRecord();
				$obraFufi->IdObra = $obra->IdObra;
				$obraFufi->IdFuenteFinanciamiento = $this->ddlFufi1->SelectedValue;
				$obraFufi->save();

				if($this->ddlFufi2->SelectedValue!="" and $this->ddlFufi2->SelectedValue!="0"){
					$obraFufi = new ObraFuenteFinanciamientoRecord();
					$obraFufi->IdObra = $obra->IdObra;
					$obraFufi->IdFuenteFinanciamiento = $this->ddlFufi2->SelectedValue;
					$obraFufi->save();
				}

				if($this->ddlFufi3->SelectedValue!="" and $this->ddlFufi3->SelectedValue!="0"){
					$obraFufi = new ObraFuenteFinanciamientoRecord();
					$obraFufi->IdObra = $obra->IdObra;
					$obraFufi->IdFuenteFinanciamiento = $this->ddlFufi3->SelectedValue;
					$obraFufi->save();
				}

				$obraLocalidad = new ObraLocalidadRecord();
				$obraLocalidad->IdObra = $obra->IdObra;
				$obraLocalidad->IdLocalidad = $this->ddlLocalidad1->SelectedValue;
				$obraLocalidad->save();

				if($this->ddlLocalidad2->SelectedValue!="" and $this->ddlLocalidad2->SelectedValue!="0"){
					$obraLocalidad = new ObraLocalidadRecord();
					$obraLocalidad->IdObra = $obra->IdObra;
					$obraLocalidad->IdLocalidad = $this->ddlLocalidad2->SelectedValue;
					$obraLocalidad->save();
				}

				if($this->ddlLocalidad3->SelectedValue!="" and $this->ddlLocalidad3->SelectedValue!="0"){
					$obraLocalidad = new ObraLocalidadRecord();
					$obraLocalidad->IdObra = $obra->IdObra;
					$obraLocalidad->IdLocalidad = $this->ddlLocalidad3->SelectedValue;
					$obraLocalidad->save();
				}

				if($this->ddlLocalidad4->SelectedValue!="" and $this->ddlLocalidad4->SelectedValue!="0"){
					$obraLocalidad = new ObraLocalidadRecord();
					$obraLocalidad->IdObra = $obra->IdObra;
					$obraLocalidad->IdLocalidad = $this->ddlLocalidad4->SelectedValue;
					$obraLocalidad->save();
				}

				if($this->ddlLocalidad5->SelectedValue!="" and $this->ddlLocalidad5->SelectedValue!="0"){
					$obraLocalidad = new ObraLocalidadRecord();
					$obraLocalidad->IdObra = $obra->IdObra;
					$obraLocalidad->IdLocalidad = $this->ddlLocalidad5->SelectedValue;
					$obraLocalidad->save();
				}

				if($this->ddlLocalidad6->SelectedValue!="" and $this->ddlLocalidad6->SelectedValue!="0"){
					$obraLocalidad = new ObraLocalidadRecord();
					$obraLocalidad->IdObra = $obra->IdObra;
					$obraLocalidad->IdLocalidad = $this->ddlLocalidad6->SelectedValue;
					$obraLocalidad->save();
				}

				if($this->ddlLocalidad7->SelectedValue!="" and $this->ddlLocalidad7->SelectedValue!="0"){
					$obraLocalidad = new ObraLocalidadRecord();
					$obraLocalidad->IdObra = $obra->IdObra;
					$obraLocalidad->IdLocalidad = $this->ddlLocalidad7->SelectedValue;
					$obraLocalidad->save();
				}

				if($this->ddlLocalidad8->SelectedValue!="" and $this->ddlLocalidad8->SelectedValue!="0"){
					$obraLocalidad = new ObraLocalidadRecord();
					$obraLocalidad->IdObra = $obra->IdObra;
					$obraLocalidad->IdLocalidad = $this->ddlLocalidad8->SelectedValue;
					$obraLocalidad->save();
				}

				if($this->ddlLocalidad9->SelectedValue!="" and $this->ddlLocalidad9->SelectedValue!="0"){
					$obraLocalidad = new ObraLocalidadRecord();
					$obraLocalidad->IdObra = $obra->IdObra;
					$obraLocalidad->IdLocalidad = $this->ddlLocalidad9->SelectedValue;
					$obraLocalidad->save();
				}

				if($this->ddlLocalidad10->SelectedValue!="" and $this->ddlLocalidad10->SelectedValue!="0"){
					$obraLocalidad = new ObraLocalidadRecord();
					$obraLocalidad->IdObra = $obra->IdObra;
					$obraLocalidad->IdLocalidad = $this->ddlLocalidad10->SelectedValue;
					$obraLocalidad->save();
				}

				if($this->ddlLocalidad11->SelectedValue!="" and $this->ddlLocalidad11->SelectedValue!="0"){
					$obraLocalidad = new ObraLocalidadRecord();
					$obraLocalidad->IdObra = $obra->IdObra;
					$obraLocalidad->IdLocalidad = $this->ddlLocalidad11->SelectedValue;
					$obraLocalidad->save();
				}

				if($this->ddlLocalidad12->SelectedValue!="" and $this->ddlLocalidad12->SelectedValue!="0"){
					$obraLocalidad = new ObraLocalidadRecord();
					$obraLocalidad->IdObra = $obra->IdObra;
					$obraLocalidad->IdLocalidad = $this->ddlLocalidad12->SelectedValue;
					$obraLocalidad->save();
				}

				if($this->ddlLocalidad13->SelectedValue!="" and $this->ddlLocalidad13->SelectedValue!="0"){
					$obraLocalidad = new ObraLocalidadRecord();
					$obraLocalidad->IdObra = $obra->IdObra;
					$obraLocalidad->IdLocalidad = $this->ddlLocalidad13->SelectedValue;
					$obraLocalidad->save();
				}

				if($this->ddlLocalidad14->SelectedValue!="" and $this->ddlLocalidad14->SelectedValue!="0"){
					$obraLocalidad = new ObraLocalidadRecord();
					$obraLocalidad->IdObra = $obra->IdObra;
					$obraLocalidad->IdLocalidad = $this->ddlLocalidad14->SelectedValue;
					$obraLocalidad->save();
				}

				if($this->ddlLocalidad15->SelectedValue!="" and $this->ddlLocalidad15->SelectedValue!="0"){
					$obraLocalidad = new ObraLocalidadRecord();
					$obraLocalidad->IdObra = $obra->IdObra;
					$obraLocalidad->IdLocalidad = $this->ddlLocalidad15->SelectedValue;
					$obraLocalidad->save();
				}

				if($this->ddlLocalidad16->SelectedValue!="" and $this->ddlLocalidad16->SelectedValue!="0"){
					$obraLocalidad = new ObraLocalidadRecord();
					$obraLocalidad->IdObra = $obra->IdObra;
					$obraLocalidad->IdLocalidad = $this->ddlLocalidad16->SelectedValue;
					$obraLocalidad->save();
				}

				if($this->ddlLocalidad17->SelectedValue!="" and $this->ddlLocalidad17->SelectedValue!="0"){
					$obraLocalidad = new ObraLocalidadRecord();
					$obraLocalidad->IdObra = $obra->IdObra;
					$obraLocalidad->IdLocalidad = $this->ddlLocalidad17->SelectedValue;
					$obraLocalidad->save();
				}

				if($this->ddlLocalidad18->SelectedValue!="" and $this->ddlLocalidad18->SelectedValue!="0"){
					$obraLocalidad = new ObraLocalidadRecord();
					$obraLocalidad->IdObra = $obra->IdObra;
					$obraLocalidad->IdLocalidad = $this->ddlLocalidad18->SelectedValue;
					$obraLocalidad->save();
				}

				if($this->ddlLocalidad19->SelectedValue!="" and $this->ddlLocalidad19->SelectedValue!="0"){
					$obraLocalidad = new ObraLocalidadRecord();
					$obraLocalidad->IdObra = $obra->IdObra;
					$obraLocalidad->IdLocalidad = $this->ddlLocalidad19->SelectedValue;
					$obraLocalidad->save();
				}

				if($this->ddlLocalidad20->SelectedValue!="" and $this->ddlLocalidad20->SelectedValue!="0"){
					$obraLocalidad = new ObraLocalidadRecord();
					$obraLocalidad->IdObra = $obra->IdObra;
					$obraLocalidad->IdLocalidad = $this->ddlLocalidad20->SelectedValue;
					$obraLocalidad->save();
				}

				$criteria = new TActiveRecordCriteria;
				$criteria->Condition = 'IdObra = :idobra ';
				$criteria->Parameters[':idobra'] = $obra->IdObra;
				$criteria->OrdersBy['Fecha'] = 'desc';
				$finder = ObraEstadoRecord::finder();
				$estado = $finder->find($criteria);
				//si tiene algun cambio de estado registrado veo si hizo algun cambio
				if(is_object($estado)){
					//si el estado es distinto al estado actual, registro el nuevo estado
					if($estado->IdEstadoObra != $obra->IdEstadoObra){
						$nuevoEstado = new ObraEstadoRecord();
						$nuevoEstado->IdObra = $obra->IdObra;
						$nuevoEstado->IdEstadoObra = $obra->IdEstadoObra;
						$nuevoEstado->Fecha = date('Y-m-d');
						$nuevoEstado->DetalleEstado = mb_strtoupper($this->txtDetalleEstado->Text, 'utf-8');
						$nuevoEstado->save();
					}
					else{
						//si el estado actual es el mismo, pero cambio el detalle, le actualizo el detalle
						if($estado->DetalleEstado != mb_strtoupper($this->txtDetalleEstado->Text, 'utf-8')){
							$estado->DetalleEstado = mb_strtoupper($this->txtDetalleEstado->Text, 'utf-8');
							$estado->save();
						}

					}

				}
				else{
					//registro el primer obraestado
					$nuevoEstado = new ObraEstadoRecord();
					$nuevoEstado->IdObra = $obra->IdObra;
					$nuevoEstado->IdEstadoObra = $obra->IdEstadoObra;
					$nuevoEstado->Fecha = date('Y-m-d');
					$nuevoEstado->DetalleEstado = mb_strtoupper($this->txtDetalleEstado->Text, 'utf-8');
					$nuevoEstado->save();
				}

				$this->Response->Redirect("?page=Obra.Home");
			}
			catch(exception $e){
				$this->Log($e->getMessage(),true);
			}

		}

	}

	public function btnMasLocalidades_OnClick($sender, $param)
	{
		
		if($this->pnlMasLocalidades->Display=="None"){
			$this->pnlMasLocalidades->Display = "Dynamic";
		}
		else{
			$this->pnlMasLocalidades->Display = "None";
		}

	}

	public function cvMemoriaDescriptiva_OnServerValidate($sender, $param)
	{
		$texto = $this->txtMemoriaDescriptiva->Text;

		if (strlen($texto)>516) {
			$param->IsValid = false;
		}
		else {
			$param->IsValid = true;
		}

	}

}

?>