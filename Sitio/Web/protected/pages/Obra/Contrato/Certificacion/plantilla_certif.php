<!DOCTYPE html>
<html>
<head>
    <meta charset='UTF-8'>
    <title></title>

    <!--style type='text/css'>
        td {
            border: 1px solid #DDE;
        }

        table .gris {
            background-color: #CFCACC;
        }

        table .celeste {
            background-color: #8BC5F8;
        }

        table .azul {
            background-color: #037BC6;
            color: #FFF;
        }
    </style-->
    
</head>
<body>
    <table cellpadding='0' cellspacing='0' width='100%'>
        <thead style='height: 0;'>
            <tr style='margin-bottom: 51px;'>
                <th width='3.87%'></th>
                <th width='4.66%'></th>
                <th width='13.90%'></th>
                <th width='8.02%'></th>
                <th width='6.72%'></th>
                <th width='8.86%'></th>
                <th width='7.70%'></th>
                <th width='7.42%'></th>
                <th width='7.84%'></th>
                <th width='7.88%'></th>
                <th width='8.82%'></th>
                <th width='7.14%'></th>
                <th width='7.18%'></th>
            </tr>
        </thead>
        <tbody>
            <tr style=''>
                <td>OBRA:</td>
                <td colspan='7' class='celeste'>{{ $tituloObra }}</td>
                <td colspan='2'>FUENTE DE FINANCIAMIENTO</td>
                <td colspan='2' class='celeste'></td>
                <td rowspan='46' class='gris'></td>
            </tr>
            <tr style=''><td colspan='12' class='gris'></td></tr>
            <tr style=''>
                <td colspan='2'>CERTIFICADO No:</td>
                <td class='celeste'>{{ $_GET['idc'] }}</td>
                <td colspan='2'>PERÍODO CERT.</td>
                <td class='celeste'>{{ $periodo }}</td>
                <td colspan='2'>FECHA MEDICION:</td>
                <td class='celeste'>{{ $fechaMedicion }}</td>
                <td colspan='2'>% AVANCE REAL OBRA</td>
                <td class='celeste'>{{ $certificacion["PorcentajeAvanceReal"] }}</td>
            </tr>
            <tr style=''><td colspan='12' class='gris'></td></tr>
            <tr style=''>
                <td colspan='3'>MUNICIPALIDAD/COMISION DE FOMENTO DE</td>
                <td colspan='8' class='celeste'>{{ $municip_comisionFomento }} </td>
                <td></td>
                
            </tr>
            <tr style=''>
                <td colspan='12'></td>
            </tr>
            <tr style=''>
                <td colspan='4'>MONTO DE OBRA FINANCIADO POR PROVINCIA:</td>
                <td colspan='2' class='celeste'>{{ $contrato->MontoProvincia }}</td>
                <td colspan='3'></td>
                <td>DECRETO No</td>
                <td colspan='2' class='celeste'>{{ $contrato->Decreto ? $contrato->Decreto : '0000/0000' }}</td>
                
            </tr>
            <tr style=''>
                <td colspan='12'></td>
            </tr>
            <tr style=''>
                <td colspan='3'>CONTRATISTA</td>
                <td colspan='5' class='celeste'>{{ $proveedor->RazonSocial }}</td>
                <td colspan='2'>MONTO DE CONTRATO:</td>
                <td colspan='2' class='celeste'>{{ $contrato->Monto }}</td>
                
            </tr>
            <tr style=''>
                <td colspan='12'></td>
            </tr>
            <tr style=''>
                <td colspan='3'>FECHA INICIO DE OBRA:</td>
                <td colspan='3' class='celeste'>{{ $fechaInicio }}</td>
                <td colspan='4'>PLAZO DE EJECUCIÓN:</td>
                <td class='celeste'>{{ $contrato->PlazoEjecucion }}</td>
                <td>DIAS</td>
            </tr>
            <tr style=''><td colspan='12' class='gris'></td></tr>
            <tr style=''>
                <td colspan='3'>ANTICIPO FINANCIERO</td>
                <td class='celeste'>{{ $certificacion["AnticipoFinanciero"] }}</td>
                <td></td>
                <td class='celeste'>{{ $anticipoFinancieroPorcentaje }}</td>
                <td class='gris'></td>
                <td colspan='4'>FECHA DE PAGO DEL ANTICIPO FINANCIERO</td>
                <td class='celeste'>{{ $fechaPagoAnticipo }}</td>
            </tr>
            <tr style=''><td colspan='12' class='gris'>333</td></tr>
            <tr style=''>
                <td colspan='3'>IMPORTE CERTIFICADO ANTERIORMENTE</td>
                <td class='celeste'>{{ $certificacionAnterior["ImporteCertifAnterior"] }}</td>
                <td></td>
                <td class='celeste'>{{ porcent($porcentajeCertifAnterior) }}</td>
                <td class='gris'></td>
                <td colspan='4'>FECHA DE PAGO DEL CERTIFICADO ANTERIOR</td>
                <td class='celeste'>{{ $fechaUltimoPago }}</td>
            </tr>
            <tr style=''><td colspan='12' class='gris'></td></tr>
            <tr style='' class='azul'>
                <td>ORDEN</td>
                <td colspan='2'>ITEM</td>
                <td>MONTO TOTAL</td>
                <td>INCIDENCIA</td>
                <td>INCIDENCIA %</td>
                <td>CERTIFICADO ACUMULARO ANTERIOR %</td>
                <td>CERTIFICADO ACUMULARO ANTERIOR $</td>
                <td>CERTIFICADO ACTUAL %</td>
                <td>CERTIFICADO ACTUAL $</td>
                <td>CERTIFICADO ACUMULARO TOTAL EN %</td>
                <td>CERTIFICADO ACUMULARO TOTAL EN $</td>
            </tr>
            <?php for ($i = 0; $i < 15; $i++) { 
                ?>
                <tr style=''>
                    <td>{{ isset($contratoItems[$i]) ? $contratoItems[$i]['Orden'] : '-'; }}</td>
                    <td colspan='2'>{{ isset($contratoItems[$i]) ? $contratoItems[$i]['Item'] : '-'; }}</td>
                    <td align="right">{{ isset($contratoItems[$i]) ? moneda($contratoItems[$i]['PrecioTotal'],'$') : '-'; }}</td>
                    <td align="right">{{ isset($contratoItems[$i]) ? porcent($contratoItems[$i]['Incidencia'],false) : '-'; }}</td>
                    <td align="right">{{ isset($contratoItems[$i]) ? porcent($contratoItems[$i]['IncidenciaPorcentaje'],true) : '-'; }}</td>
                    <td align="right">{{ isset($contratoItems[$i]) ? porcent($contratoItems[$i]['PorcentajeAnterior'],true) : '-'; }}</td>
                    <td align="right">{{ isset($contratoItems[$i]) ? moneda($contratoItems[$i]['ImporteAnterior'],'$') : '-'; }}</td>
                    <td align="right">{{ isset($contratoItems[$i]) ? porcent($contratoItems[$i]['PorcentajeActual'],true) : '-'; }}</td>
                    <td align="right">{{ isset($contratoItems[$i]) ? moneda($contratoItems[$i]['ImporteActual'],'$') : '-'; }}</td>
                    <td align="right">{{ isset($contratoItems[$i]) ? porcent($contratoItems[$i]['PorcentajeAcum'],true) : '-'; }}</td>
                    <td align="right">{{ isset($contratoItems[$i]) ? moneda($contratoItems[$i]['ImporteAcum'],'$') : '-'; }}</td>

                </tr>
            <?php } ?>
            <tr style='' class='azul'>
                <td colspan='3'>TOTALES</td>
                <td align="right">{{ moneda($sumaPrecioTotal, '$') }}</td>
                <td align="right">{{ porcent($sumaIncidencia, false) }}</td>
                <td align="right">{{ porcent($porcentajeTotal, true) }}</td>
                <td align="right">{{ porcent($porcentajeAnterior, true) }}</td>
                <td align="right">{{ moneda($sumaImporteAnterior, '$') }}</td>
                <td align="right">{{ porcent($sumaPorcentajeActual, true) }}</td>
                <td align="right">{{ moneda($sumaImporteActual, '$') }}</td>
                <td align="right">{{ porcent($sumaPorcentajeAcum, true) }}</td>
                <td align="right">{{ moneda($sumaImporteAcum, '$') }}</td>
            </tr>

            <tr style=''>
                <td colspan='12'></td>
            </tr>
            <tr style=''>
                <td colspan='4'>ANTICIPO FINANCIERO OTORGADO POR EL GOB PCIAL</td>
                <td></td>
                <td>{{ number_format($certificacion["AnticipoFinanciero"],2,'.','') }}</td>
                <td colspan='6'></td>
            </tr>
            <tr style=''>
                <td colspan='4'>Anticipo Financiero Acumulado Anterior</td>
                <td></td>
                <td>{{ number_format($anticipoAcumulado,2,'.','') }}</td>
                <td colspan='6'></td>
            </tr>
            <tr style=''>
                <td colspan='4'>Descuento Anticipo - Certificado Actual</td>
                <td></td>
                <td>{{ number_format($descuentoAnticipoActual,4,'.','') }}</td>
                <td colspan='6'></td>
            </tr>
            <tr style=''>
                <td colspan='12'></td>
            </tr>
            <tr style=''>
                <td colspan='4'>Descuento Anticipo Financiero Acumulado</td>
                <td></td>
                <td>{{ number_format($descuentoAnticipoAcumulado,2,'.','') }}</td>
                <td colspan='6'></td>
            </tr>
            <tr style=''>
                <td colspan='12'></td>
            </tr>
            <tr style=''>
                <td colspan='4'>Fondo de Reparo 5% -Del Certificado Bruto-</td>
                <td></td>
                <td class='celeste'>{{ number_format($fondoReparo,4,'.','') }}</td>
                <td colspan='6'></td>
            </tr>
            <tr style=''>
                <td colspan='12'></td>
            </tr>
            <tr style=''>
                <td colspan='4'>TOTAL A PAGAR POR EL MUNICIPIO CORRESP. AL ACTUAL<br>(Para Fondo de Reparo)</td>
                <td>{{ number_format($totalPagoMunicipio,2,'.','') }}</td>
                <td colspan='7'></td>
            </tr>
            <tr style=''>
                <td colspan='7'></td>
                <td colspan='2'></td>
                <td></td>
                <td colspan='2'></td>
            </tr>
            <tr style=''>
                <td colspan='4' class='azul'>TOTAL A PAGAR POR EL GOBIERNO PROVINCIAL CORRESP. AL ACTUAL<br>(Para Fondo de Reparo)</td>
                <td>{{ number_format($totalPagoProvincia,2,'.','') }}</td>
                <td colspan='2'></td>
                <td colspan='2'>Firma Técnico/Contratista</td>
                <td></td>
                <td colspan='2'>Firma Intendente</td>
                
            </tr>
            <tr style=''><td colspan='12' class='gris'>&nbsp;</td></tr>
        </tbody>
    </table>    
</body>
</html>