<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@page import="com.ciberfarma.model.Producto"%>
<%@page import="java.util.List"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Ciberfarma</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link href="css/estilos.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>

<body>
	<%-- validación : si no hay un usuario, redirecciona al Servlet de login  --%>
	<c:if test="${u == null }">
		<c:redirect url="login"></c:redirect>
	</c:if>
	<div id="contenedor">
		<jsp:include page="header.jsp"></jsp:include>
		<jsp:include page="menu_nav.jsp"></jsp:include>
		<main>
			<aside>
				<h3>Categorís</h3>
				<a href="#">Pastillas</a> <a href="#">Jarabes</a> <a href="#">Cuidado</a>
			</aside>
			<div class="container" style="background-color: white">
				<div class="row">
					<div class="col">
						<h2>Actualiza datos</h2>

						<form class="row g-3" action="actuser" method="post">
							<div class="col-6">
								<label for="inputAddress" class="form-label">Código</label> <input
									value="${u.codigo }" required name="codigo" type="text"
									disabled="disabled" class="form-control" id="inputAddress"
									placeholder="Código" maxlength="5">
							</div>
							<div class="col-6"></div>
							<div class="col-6">
								<label for="inputNombre" class="form-label">Nombre</label> <input
									value="${u.nombre }" type="text" class="form-control"
									id="inputNombre" name="nombre" placeholder="Nombre">
							</div>
							<div class="col-6">
								<label for="inputApellido" class="form-label">Apellido</label> <input
									value="${u.apellido }" type="text" class="form-control"
									id="inputApellido" name="apellido" placeholder="Apellido">
							</div>
							<div class="col-md-6">
								<label for="inputUsuario" class="form-label">Usuario</label> <input
									value="${u.usuario }" name="usuario" type="email"
									class="form-control" id="inputUsuario" placeholder="correo"
									disabled="disabled">
							</div>
							<div class="col-md-6">
								<label for="inputClave" class="form-label">Contraseña</label> <input
									value="${u.clave }" type="text" name="clave"
									class="form-control" id="inputClave" placeholder="Clave">
							</div>

							<div class="col-12">
								<button name="btnOpcion" value="act" type="submit"
									class="btn btn-primary">Actualizar</button>
							</div>
							<div class="col-12">${requestScope.mensaje}</div>
						</form>
					</div>
					<div class="col"></div>
				</div>
			</div>



		</main>
		<footer>
			<img src="img/iconos/facebook_icon.png">
			<p>Derechos Reservados. Lima, Perú - 2024</p>
		</footer>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>
