<h1 style="text-align: left; width: 700px;">Aniversario de <?php echo $data["Localidad"]; ?></h1>
<span>Localidad: <?php echo $data["Localidad"]; ?></span><br />
<span>Aniversario: <?php echo $data["Aniversario"]; ?></span><br />
<span>Categor&iacute;a: <?php echo $data["Categoria"]; ?></span><br />
<span>Autoridades: <?php echo $data["Autoridades"]; ?></span><br />
<span>Habitantes: <?php echo $data["Habitantes"]; ?></span><br /><br />
<table align="center">
	<tr>
		<td align="center" width="250px">
			<img height="200px" src="<?php echo $data["FotoEscudo"]; ?>" />
		</td>
		<td align="center" width="250px">
			<img height="200px" src="<?php echo $data["FotoLocalidad"]; ?>" />
		</td>
		<td align="center" width="250px">
			<img height="200px" src="<?php echo $data["FotoAutoridad"]; ?>" />
		</td>
	</tr>
	<tr>
		<td align="center">
			<span style="font-size: 12px;">Escudo de la localidad</span>
		</td>
		<td align="center">
			<span style="font-size: 12px;">Fotograf&iacute;a de la localidad</span>
		</td>
		<td align="center">
			<span style="font-size: 12px;"><?php echo $data["Autoridades"]; ?></span>
		</td>
	</tr>
</table>
<br /><br />
<span>Cantidad de Obras2: <?php echo $data["CantidadObras"]; ?></span><br />
<span>Monto Total: <?php echo $data["MontoTotal"]; ?></span><br />
<!--<span>Total de Beneficiarios: <?php echo $data["TotalBeneficiarios"]; ?></span><br />
<span>Total de Mano de Obra: <?php echo $data["TotalManoObra"]; ?></span>
<br />--><br />
<table>
	<thead>
		<tr>
			<th align="center" valign="top" width="7%">Obra</th>
			<th align="center" valign="top" width="8%">Fuente Financiamiento</th>
			<th align="center" valign="top" width="7%">Monto</th>
			<th align="center" valign="top" width="7%">F. Inicio</th>
			<th align="center" valign="top" width="7%">F. Fin</th>
			<th align="center" valign="top" width="4%">% Certif.</th>
			<th align="center" valign="top" width="5%">Cant. Benef.</th>
			<th align="center" valign="top" width="5%">Mano Obra</th>
			<th align="center" valign="top" width="7%">Estado</th>
			<th align="center" valign="top" width="15%">Detalle Estado</th>
			<th align="center" valign="top" width="20%">Memoria Descriptiva</th>
			<th align="center" valign="top" width="4%">Organismo</th>
			<th align="center" valign="top" width="4%">Comitente</th>
		</tr>
	</thead>
	<tbody>
<?php
	foreach($data["Obras"] as $d){
?>
		<tr>
			<td align="left" valign="top"><?php echo $d["Obra"]; ?></td>
			<td align="left" valign="top"><?php echo $d["FuenteFinanciamiento"]; ?></td>
			<td align="right" valign="top"><?php echo ($d["Monto"]!='' ? number_format($d["Monto"], 2, ",", ".") : ''); ?></td>
			<td align="center" valign="top"><?php echo $d["FechaInicio"]; ?></td>
			<td align="center" valign="top"><?php echo $d["FechaFinalizacion"]; ?></td>
			<td align="right" valign="top"><?php echo ($d["PorcentajeAvance"]!='' ? number_format(floatval($d["PorcentajeAvance"]), 2, ",", ".") : ''); ?></td>
			<td align="right" valign="top"><?php echo ($d["CantidadBeneficiarios"]!='' ? number_format($d["CantidadBeneficiarios"], 0, ",", ".") : ''); ?></td>
			<td align="right" valign="top"><?php echo ($d["CantidadManoObra"]!='' ? number_format($d["CantidadManoObra"], 0, ",", ".") : ''); ?></td>
			<td align="left" valign="top"><?php echo $d["Estado"]; ?></td>
			<td align="left" valign="top"><?php echo $d["DetalleEstado"]; ?></td>
			<td align="left" valign="top"><?php echo $d["MemoriaDescriptiva"]; ?></td>
			<td align="left" valign="top"><?php echo $d["Organismo"]; ?></td>
			<td align="left" valign="top"><?php echo $d["Comitente"]; ?></td>
		</tr>
<?php
	}
?>
	</tbody>
</table>
