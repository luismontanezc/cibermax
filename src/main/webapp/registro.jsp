<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registrar Usuario</title>

   <style>
    /* Aplicamos estilos solo a esta página usando body.login-page */
    body {
        background: linear-gradient(to right, #00c6ff, #0072ff);
        font-family: 'Poppins', sans-serif;
        display: flex;
		justify-content: center;  
		align-items: center; 

    }

    .register-container {
        width: 50%;
        height: 500px;
        max-width: 500px; /* Evita que se haga demasiado grande */
        padding: 40px; /* Más espacio interno */
        background: white;
        border-radius: 12px;
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);    
        
    }
    
    
    h1 {
    	font-family:sans-serif;
    	font-size: 2.5rem;
    	text-align: center;
    }

    .form-label {
        font-size: 1.2rem; /* Aumentamos un poco el tamaño */
        font-weight: bold;
        color: #333;
        margin-bottom: 20px;
        font-family: monospace; 

 
    }

	.form-entry {
	    margin-bottom: 15px;
	    display: block;
	    
	}
	
	.form-input {
		border-radius: 25px;
		border: black 1px solid;
		font-size: 1.2rem; 
		 display: block;
		 margin: 0;
		 text-align: center;
		 width: 100%;
		 height: 30px;
		
	}
    .register-container  {
        border-radius: 8px;
        border: 1px solid #ccc;
        height: auto
    }

    .register-container .form-control:focus {
        border-color: #0072ff;
        box-shadow: 0 0 5px rgba(0, 114, 255, 0.5);
    }

     .button {
        width: 100%;
        padding: 12px;
        border-radius: 8px;
        font-size: 1rem;
        font-weight: bold;
        transition: 0.3s;
        color: black;
    }

    .button:hover {
        background-color: #0072ff;
        color: white;
    }


    .form-container {
    	justify-content: center;
    }
    
    .form-registro {
    display: block;
    	justify-content: center;
    	align-content: center;
    	align-items: center;

    
    }
</style>


</head>
<body>
	
	<div class="register-container">
		<div class="form-container">
			<h1>Crear Cuenta</h1>
			<form action="Registrar" method="post" class="form-registro-principal">
				<div class="form-registro">
			
					<div class= "form-entry">
						<label for="nombre" class="form-label">Nombres: *</label>
						<input type="text" name="nombre" id="nombre" class="form-input" placeholder="Nombres" required>
					</div>

					<div class= "form-entry">
						<label for="apellido" class="form-label">Apellidos: *</label>
						<input type="text" name="apellido" id="apellido" class="form-input" placeholder="Apellidos" required>
					</div>

					<div class= "form-entry">
						<label for="usuario" class="form-label">Correo: *</label>
						<input type="email" name="usuario" id="usuario" class="form-input" placeholder="Correo" required>
					</div>

					<div class= "form-entry">
						<label for="nacimiento" class="form-label">Fecha de Nacimiento: *</label>
						<input type="date" name="nacimiento" id="nacimiento" class="form-input" required>
					</div>

					<div class= "form-entry">
						<label for="clave" class="form-label">Contraseña: *</label>
						<input type="password" name="clave" id="clave" class="form-input" placeholder="Contraseña" required>
					</div>

					<div class= "form-entry">
						<label for="confirmarClave" class="form-label">Confirmar Contraseña: *</label>
						<input type="password" name="confirmarClave" id="confirmarClave" class="form-input" placeholder="Confirmar Contraseña" required>
						<small id="mensajeClave" class="text-danger" style="display: none;">Las contraseñas no coinciden.</small>
					</div>

				</div>
				<div class="form-registro">

					<div>
						<label class="form-check-label" for="gridCheck">
							<input class="form-check-input" type="checkbox" id="gridCheck" required>
							Acepto los términos y condiciones del servicio.
						</label>
					</div>
					<div class="div-button">
						<button type="submit" class="button">Registrar</button>
					</div>
				</div>
			</form>
				<div>${mensaje}</div>
		</div>
	
	</div>

	<!-- Scripts -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
	<script src="./js/registrar.js"></script>
	<script>
		const clave = document.getElementById("clave");
		const confirmarClave = document.getElementById("confirmarClave");
		const mensajeClave = document.getElementById("mensajeClave");

		// Validación en tiempo real
		confirmarClave.addEventListener("input", () => {
			if (confirmarClave.value !== clave.value) {
				mensajeClave.style.display = "block"; // Mostrar mensaje
			} else {
				mensajeClave.style.display = "none"; // Ocultar mensaje
			}
		});
	</script>
</body>
</html>