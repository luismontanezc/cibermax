<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
	referrerpolicy="no-referrer" />
<style>
/* Aislar los estilos del navbar */
.navbar-container {
	position: relative;
	z-index: 10; /* Asegurarse de que el navbar esté al frente */
}

/* Estilos generales de la barra de navegación */
.navbar {
	background-color: blue;
	display: flex;
	justify-content: space-around;
	padding: 10px 0;
	list-style: none;
	margin: 0;
	font-family: Arial, sans-serif;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	/* Agregar sombra para resaltar */
}

/* Estilos para los enlaces de navegación */
.navbar a {
	color: white;
	text-decoration: none;
	font-size: 17px;
	padding: 10px 20px;
	font-weight: bold;
	transition: transform 0.3s, background-color 0.3s;
}

/* Animación al pasar el mouse por encima */
.navbar a:hover {
	transform: scale(1.1);
	background-color: #1E90FF;
	border-radius: 5px;
}

/* Resetear estilos globales del cuerpo */
body {
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
}
</style>
</head>
<body>
	<!-- Envolver navbar en un contenedor aislado -->
	<div class="navbar-container">
		<ul class="navbar">
			<li><a href="monitores">Monitores</a></li>
			<li><a href="perifericos">Perifericos PC</a></li>
			<li><a href="tarjetas">Tarjetas Gráficas</a></li>
			<li><a href="procesadores">Procesadores</a></li>
			<li><a href="catalogo">Productos</a></li>
			<!-- opciones solo para el administrador -->
			<c:if test="${sessionScope.tipoUsuario == 1}">
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" role="button"
					data-bs-toggle="dropdown" aria-expanded="false"> Mantenimientos
				</a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="crudprod">Productos</a></li>
					</ul></li>
			</c:if>


		</ul>
	</div>