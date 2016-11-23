<?php
	function verificar_login($user, $password, &$result) { 
	    $sql = "SELECT * FROM usuariomosp WHERE Username = '$user' and Password = md5('$password')"; 
	    $rec = mysql_query($sql); 
	    $count = 0; 
	  
	    while($row = mysql_fetch_object($rec)) 
	    { 
	        $count++; 
	        $result = $row; 
	    } 
	  
	    if($count == 1) 
	    { 
	        return 1; 
	    } 
	  
	    else 
	    { 
	        return 0; 
	    } 
	} 

?>

<div style="text-align: left; margin-left: 50px;" class="span3">

	<form action="" method="post" id="main">	
		<label>Nombre de usuario:</label>
		<input type="text" name="user" placeholder="Nombre de Usuario">
		<label>Contraseña:</label>
		<input type="password" name="password" placeholder="Contraseña">
		<br />
		<input name="login" type="submit" value="Ingresar">
	</form>

	<?php
		if(isset($_POST['login'])){
			$user = $_POST['user'];
			$password = $_POST['password'];

			if(verificar_login($user, $password, $result) == 1) 
	        { 
	            $_SESSION['usr'] = $result->IdUsuario; 
	            $_SESSION['idpl'] = $result->IdPlanilla; 
	            $_SESSION['usrapenom'] = $result->ApellidoNombre; 
	            header("location:index.php"); 
	        } 
	        else 
	        { 
	            echo '<div class="error">Su usuario es incorrecto, intente nuevamente.</div>'; 
	        } 

		}
	?>

</div>

