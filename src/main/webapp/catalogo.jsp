<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Productos</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
/* Espaciado entre el navbar y el título */
h2 {
	font-weight: bold;
}

.espaciado-superior {
	margin-top: 30px;
}

/* Contenedor del formulario alineado al centro */
.filtro-container {
	display: flex;
	justify-content: center;
	margin-bottom: 20px;
}

/* Contenedor general de productos */
.producto-container {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	gap: 20px; /* Espaciado entre productos */
}

/* Estilo individual de producto */
.producto {
	border: 1px solid #ddd;
	padding: 15px;
	width: 220px;
	text-align: center;
	box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
	background-color: white;
	display: flex;
	flex-direction: column;
	justify-content: space-between; 
	transition: transform 0.3s ease, box-shadow 0.3s ease;
    transform: scale(0.9);
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}
.producto:hover {
        transform: scale(1); 
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
}

.producto img {
	width: 100%;
	height: 185px; /* Altura fija para imágenes */
	object-fit: contain; /* Evita distorsión */
	margin-bottom: 10px;
	border-radius: 25px;
}

.producto h3 {
	font-size: 16px;
	color: #333;
	margin-bottom: 10px;
}

.producto .precio {
	color: blue; /* Precio en azul */
	font-size: 20px;
	font-weight: bold;
	margin: 3px 0;
}

.producto .stock, .producto .categoria {
	font-size: 14px;
	color: gray;
	margin: 3px 0;
}

.btn {
	margin-top: 10px;
	background-color: #007bff;
	color: white;
	text-decoration: none;
}
</style>
</head>
<body>
	<div id="contenedor">
		<jsp:include page="cabecera.jsp"></jsp:include>
		<jsp:include page="menu_nav.jsp"></jsp:include>

		<!-- Espaciado superior -->
		<div class="espaciado-superior"></div>

		<!-- Filtro alineado al centro -->
		<div class="filtro-container">
			<form action="catalogo" method="post"
				class="d-flex align-items-center gap-2">
				<input type="hidden" name="buscar" value="${busqueda}">
				<!-- Mantener búsqueda actual -->
				<label for="tipoOrden" class="me-2">Ordenar por:</label> <select
					name="tipoOrden" id="tipoOrden" class="form-select w-auto">
					<option value="categoria"
						${tipoOrden == 'categoria' ? 'selected' : ''}>Categoría:
						Por Categoría</option>
					<option value="precioAsc"
						${tipoOrden == 'precioAsc' ? 'selected' : ''}>Precio:
						Menor a Mayor</option>
					<option value="precioDesc"
						${tipoOrden == 'precioDesc' ? 'selected' : ''}>Precio:
						Mayor a Menor</option>
				</select>
				<button type="submit" class="btn btn-primary">Ordenar</button>
			</form>
		</div>




		<!-- Título del catálogo con búsqueda -->
		<h2 class="text-center mb-4 gordito">
			<c:choose>
				<c:when test="${not empty busqueda}">
            ${busqueda} (${nroResultados})
        </c:when>
				<c:otherwise>
            Catálogo de Productos
        </c:otherwise>
			</c:choose>
		</h2>

		<!-- Contenedor de Productos -->
		<div class="container">
			<div class="producto-container">
				<c:forEach var="producto" items="${lstProductos}">
					<div class="producto">
						<a href="muestra?codigo=${producto.getIdprod()}"> <img
							src="img/productos/${producto.getIdprod()}.jpg?${System.currentTimeMillis()}"
							alt="${producto.descripcion}">
						</a>
						<h3>${producto.descripcion}</h3>
						<p class="precio">
							S/.
							<fmt:formatNumber value="${producto.getPrecio()}" pattern="0.00" />
						</p>
						<p class="stock">Stock: ${producto.stock}</p>
						<p class="categoria">Categoría: ${producto.nombrecategoria}</p>
						<form action="addCompra" method="post">
							<input type="hidden" name="idProducto"
								value="${producto.getIdprod()}"> <input type="hidden"
								name="descripcion" value="${producto.descripcion}"> <input
								type="hidden" name="precio" value="${producto.getPrecio()}">
							<button type="submit" class="btn btn-info btn-sm"
						      	onclick="window.location.href='muestra?codigo=${producto.getIdprod()}'; return false;">
						      	Agregar al carrito</button>
						</form>
					</div>
				</c:forEach>
			</div>
		</div>

		<!-- Paginación -->
		<div class="text-center mt-4">
			<c:if test="${totalPaginas > 1}">
				<nav aria-label="Page navigation">
					<ul class="pagination justify-content-center">
						<c:forEach var="i" begin="1" end="${totalPaginas}">
							<li class="page-item ${paginaActual == i ? 'active' : ''}">
								<form method="post" action="catalogo">
									<input type="hidden" name="tipoOrden" value="${tipoOrden}">
									<input type="hidden" name="buscar" value="${busqueda}">
									<input type="hidden" name="pagina" value="${i}">
									<button type="submit" class="page-link">${i}</button>
								</form>
							</li>
						</c:forEach>
					</ul>
				</nav>
			</c:if>
		</div>


		<jsp:include page="footer.jsp"></jsp:include>

	</div>
	<!-- SweetAlert2 CDN -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

	<%-- Mostrar mensaje dinámico y limpiar sesión --%>
	<c:if test="${not empty sessionScope.mensaje}">
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
		<script>
			Swal.fire({
				icon : '${sessionScope.tipo}',
				title : 'Aviso',
				text : '${sessionScope.mensaje}'
			});
		</script>
		<%
		// Eliminar variables de sesión después de mostrar el mensaje
		session.removeAttribute("mensaje");
		session.removeAttribute("tipo");
		%>
	</c:if>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
