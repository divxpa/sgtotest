<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <com:THead>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<link rel="favicon icon" href="themes/serviciospublicos/images/favicon.ico">
	</com:THead>
	<body>
		<com:TForm ID="formPrincipal">
			<div id="container">
				<com:TActivePanel ID="pnlAlarmas" CssClass="alarmas-content" Display="None">
					<com:TActiveLinkButton
						ID="btnMinimizarAlarma"
						CssClass="alarmas-min"
						ToolTip="Maximizar/Minimizar"
						OnClick="btnMinimizarAlarma_OnClick" />
					<com:TLabel ID="lblTituloAlarma" CssClass="alarmas-content-label" />
					<com:TActivePanel Display="None" ID="pnlAlarmasDetalle">
						<com:TActiveDataGrid
						    ID="dgAlarmas"
							CssClass="TableForm"
						    AlternatingItemStyle.BackColor="#EEEEEE"
						    AutoGenerateColumns="false"
				            AllowPaging="false"
							AllowCustomPaging="false"
					        AllowSorting="false">
							<com:TBoundColumn DataField="Alarma" HeaderText="Alarma" />
							<com:THyperLinkColumn DataTextField="Cantidad" HeaderText="Cantidad" ItemStyle.HorizontalAlign="Center" ItemStyle.Width="75px" DataNavigateUrlFormatString="javascript:OpenWindow('?page=DetalleAlarma&id=%s',800,600);" DataNavigateUrlField="IdAlarma" />
					  	</com:TActiveDataGrid>
					</com:TActivePanel>
				</com:TActivePanel>
				<div id="header">
					<com:TClientScript PradoScripts="effects" />
		  			<div id="callback_status" style="display:none;">
		  				<center>
		  					<img src="themes/serviciospublicos/images/ajax-loader2.gif" />
		  				</center>
		  			</div>
		  			<div style="float:right; margin-right: 10px;">
				         <img src="themes/serviciospublicos/images/logo_neuquen.png" height="74px" border="0" />
				    </div>
				    <com:TPanel ID="ploginin" Visible="true" CssClass="login-in">
						<div class="line1">
								<br />
								<com:TLabel
									ID="lblUser"
								    Text="Bienvenido nombre de usuario"
								    CssClass="labelloginheader" />
								|
				 				<com:THyperLink
									ID="hlUserLogout"
									Text="Salir"
									NavigateUrl="?page=Logout"
								    CssClass="labelloginheader" />
								<br />
								<com:TLabel
									ID="lblOrganismo"
								    Text=""
								    CssClass="labelloginheader" />
						</div>
					</com:TPanel>
				  	<div id="logo" style="float:left;">
				         <img src="themes/serviciospublicos/images/logosgo.png" border="0" />
				    </div>
				</div>
				<div id="navigation">
			        <com:TPanel ID="pMenuSideBar" Visible="true" CssClass="menu">
						<com:PGMenu ID="menu" />
			        </com:TPanel>
				</div>
				<div id="content-container">
					<div id="content">
						<div class="post">
							<com:TContentPlaceHolder ID="MainContent" />
						</div>
					</div>
				</div>
			</div>
			<div id="framecontent">
				<div id="footer">
					<span><a href="http://www.puntogap.com.ar" target="_blank" style="color:#fff;text-decoration:none;">Sistema desarrollado por PuntoGAP</a></span>
				</div>
			</div>
		</com:TForm>
	</body>
</html>