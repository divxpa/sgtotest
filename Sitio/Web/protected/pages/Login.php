<?php

class Login extends PageBaseSP{

	public function onLoad($param){
		parent::onLoad($param);
	}

	public function cvUser_OnServerValidate($sender, $param){
		$finder = UsuarioRecord::finder();
		$usuario = $finder->findBy_Username_And_Password_And_Activo($this->txtUsername->Text,md5($this->txtPassword->Text),1);

		if(is_object($usuario)){
			$param->IsValid = true;
		}
		else{
			$param->IsValid = false;
		}

	}

	public function btnIngresar_OnClick($sender, $param)
	{

		if($this->IsValid){
			$finder = UsuarioRecord::finder();
			$usuario = $finder->findBy_Username_And_Password_And_Activo($this->txtUsername->Text,md5($this->txtPassword->Text),1);
			$this->Session["SPIdUsuario"] = $usuario->IdUsuario;
			$this->Session["SPNombreUsuario"] = $usuario->ApellidoNombre;
			$this->Session["SPUsername"] = $usuario->Username;
			$this->Session["SPOrganismo"] = $usuario->IdOrganismo;
			$this->Session["SPIdRol"] = $usuario->IdRol;
			$this->Session["SPIdLocalidad"] = $usuario ->IdLocalidad;

			if(!is_null($usuario->IdOrganismo)){
				$finder = OrganismoRecord::finder();
				$organismo = $finder->findByPk($usuario->IdOrganismo);
				$this->Session["SPNombreOrganismo"] = $organismo->Nombre;
			}
			else{
				$this->Session["SPNombreOrganismo"] = "";
			}

			$this->SaveIngreso($usuario->IdUsuario, true);
			$this->Response->Redirect("?page=Home");
		}

	}

}

?>