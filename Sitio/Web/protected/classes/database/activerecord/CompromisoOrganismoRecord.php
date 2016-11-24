<?php
class CompromisoOrganismoRecord extends TActiveRecord
{
	const TABLE='compromisoorganismo';

	public $IdCompromisoOrganismo;
	public $Nombre;
	public $Tag;
	public $Color;
	public $Activo;	

	public static function finder($className=__CLASS__)
	{
		return parent::finder($className);
	}	
}
?>