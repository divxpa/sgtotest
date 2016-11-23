<?php

class Home extends PageBaseSP{

	public function onLoad($param){
		parent::onLoad($param);

		if(!$this->IsPostBack){
			$aniversarios = $this->CreateDataSource("LocalidadPeer","Aniversarios");

			foreach ($aniversarios as $a) {
				$fecha = explode("-", $a["Aniversario"]);
				$titulo = $a["Nombre"];
				$nombre = "<a href=\"javascript:OpenWindow('?page=Prensa.Aniversario&id=".$a["IdLocalidad"]."', 900, 600);\">".$a["Nombre"]."</a>";
				$this->Calendario->addEvent($titulo, $nombre, intval($fecha[1]), intval($fecha[2]));
			}

			$this->Calendario->RefreshCalendar();
		}

	}

}

?>