<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Header</title>
<style>
/* Estilo para el header */
body {
	margin: 0;
	font-family: Arial, sans-serif;
}

.header {
	display: flex;
	align-items: center;
	justify-content: space-between;
	background-color: #000;
	padding: 10px 20px;
	color: white;
}

.header .user-actions {
	display: flex;
	align-items: center;
	gap: 15px; /* Espaciado entre los elementos */
}

/* Estilo para el texto de bienvenida */
.header .user-actions .welcome-text {
	font-weight: bold;
	font-size: 16px; /* Tamaño de fuente más claro */
	margin-right: 10px; /* Espaciado derecho */
	color: white; /* Asegura el color blanco */
}

/* Botón de cerrar sesión */
.header .user-actions .logout-button {
	background-color: transparent;
	color: white;
	border: 1px solid white;
	padding: 6px 12px;
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.3s, color 0.3s;
}

.header .user-actions .logout-button:hover {
	background-color: red;
	color: white;
	border-color: red;
}
/* Estilo para el carrito */
.header .cart-container {
	display: flex;
	align-items: center;
	gap: 10px; /* Espaciado entre el botón y el carrito */
}

.header .cart-icon {
	font-size: 30px; /* Tamaño más grande del ícono */
	color: white; /* Ícono en color blanco */
	position: relative; /* Para posicionar el número de artículos */
	margin-right: 15px; /* Espaciado hacia la derecha */
}

/* Estilo para el número de artículos */
.header .cart-icon sup {
	position: absolute;
	top: -5px; /* Ajusta la posición vertical */
	right: -10px; /* Ajusta la posición horizontal */
	background-color: red; /* Fondo rojo */
	color: white; /* Número en color blanco */
	font-size: 12px; /* Tamaño del número */
	font-weight: bold; /* Texto en negrita */
	padding: 4px 6px; /* Espaciado interno */
	border-radius: 50%; /* Forma circular */
	border: 1px solid white; /* Borde blanco */
	line-height: 1; /* Asegura que el número esté centrado */
}

.logo {
	display: flex;
	align-items: center;
}

.logo img {
	height: 75px;
	margin-right: -5%;
	margin-left: 65px;
	object-fit: contain;
}

.search-bar {
	flex-grow: 1;
	max-width: 500px;
	margin: 0 20px;
	display: flex;
	align-items: center;
}

.search-bar input {
	width: 100%;
	padding: 8px;
	border: none;
	border-radius: 4px 0 0 4px;
	outline: none;
	font-family: Arial, sans-serif;
	font-size: 14px;
	color: gray;
}

.search-bar input::placeholder {
	font-size: 14px;
	color: gray;
}

.search-bar button {
	padding: 8px 12px;
	background-color: blue;
	color: white;
	border: none;
	border-radius: 0 4px 4px 0;
	cursor: pointer;
}

.login-button, .logout-button {
	background-color: transparent;
	color: white;
	border: 1px solid white;
	padding: 6px 12px;
	border-radius: 4px;
	cursor: pointer;
}

.login-button:hover, .logout-button:hover {
	background-color: red;
	border-color: red;
}

.welcome {
	font-weight: bold;
	margin-right: 10px;
}
</style>
</head>
<body>
	<div class="header">
		<!-- Logo -->
		<div class="logo">
			<a href="principal.jsp"> <img src="img/logotipo.jpg"
				alt="CompoMax">
			</a>
		</div>

		<!-- Barra de búsqueda -->
		<div class="search-bar">
			<form action="catalogo" method="post"
				style="display: flex; width: 100%;">
				<input type="text" name="buscar" placeholder="Búsqueda en catálogo"
					value="${busqueda}">
				<button type="submit">
					<svg xmlns="http://www.w3.org/2000/svg" fill="white" width="16"
						height="16" viewBox="0 0 24 24">
                    <path
							d="M10,2A8,8,0,0,1,18,10a7.91,7.91,0,0,1-1.72,4.88l6.31,6.31a1,1,0,0,1-1.41,1.41l-6.31-6.31A8,8,0,1,1,10,2Zm0,2A6,6,0,1,0,16,10,6,6,0,0,0,10,4Z" />
                </svg>
				</button>
			</form>
		</div>

		<!-- Acciones del usuario -->
		<div class="user-actions">
			<c:if test="${not empty usuarioActivo}">
				<span class="welcome-text">Bienvenid@ ${usuarioActivo.nombre}</span>
				<form action="logout" method="get" style="margin: 0;">
					<button type="submit" class="logout-button">Cerrar sesión</button>
				</form>
			</c:if>
			<c:if test="${empty usuarioActivo}">
				<a href="login.jsp"><button class="login-button">Iniciar
						sesión</button></a>
			</c:if>
			<div class="cart-container">
				<!-- Ícono del carrito con contador -->
				<a href="canasta.jsp" class="cart-icon"> <i
					class="fa-solid fa-cart-shopping"></i> <sup>${cantArticulos }</sup>
				</a>
			</div>


		</div>
	</div>

</body>
</html>

