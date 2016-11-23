<!--<div class="span1">&nbsp;</div>-->
<div class="span12" style='text-align: right; padding-right: 20px;'>
  Bienvenido <?php echo isset($_SESSION['usrapenom']) ? $_SESSION['usrapenom']: '';?>
   - <a href='index.php?logout=true'>Cerrar sesión</a>
</div>
<div class="span6">
<div class='row span11 ' style="margin-left: 70px">
    <div class="span6">
  <a href="http://www.mospneuquen.com.ar/sgo" target="_blank">
    <div class='img2'>
      <img src='images/cubo3.png'><br>
      <h3>S.G.O</h3>
    </div>
  </a>
</div>
<div class='span6  '>  
  <a href="https://docs.google.com/spreadsheet/ccc?key=<?php echo $_SESSION["idpl"]; ?>" target="_blank">
    <div class='img2'> 
      <img  src='images/cubo3_b2.png'><br>
      <h3>tablero</h3>
    </div>
  </a>
</div>
</div>
<div class=' row span11 ' style="margin-left: 70px">
<div class='span6 ' >
  <a href="https://docs.google.com/spreadsheet/ccc?key=0Agy16c4yMPjSdGEyOGpmUFBSSVk4Y3BXTDdQb1ExTkE" target="_blank">
    <div class='img2'>
      <img src='images/cubo3_b2.png'><br>
      <h3>tablero unificado</h3>
    </div> 
  </a>
</div>
<div class='span6 ' >
  <a href="http://www.mospneuquen.com.ar/sgo" target="_blank">
    <div class='img2'>
      <img src='images/cuboCalendarioChico.png'><br>
      <h3>calendario</h3>
    </div> 
  </a>
</div>
</div>
<div class=' row span11 ' style="margin-left: 70px">
  <div class='span6 ' >
  <a href="maps/" target="_blank">
    <div class='img2'>
      <img src='images/cuboPlanisferio.png'><br>
      <h3>geo</h3>
    </div> 
  </a>
</div>
</div>    
</div>
<!--<div style="float: left; position: absolute; top: 250px; left: 50px;">
  <a href="?logout">Salir</a>
</div>-->
