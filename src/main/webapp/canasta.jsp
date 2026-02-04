<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="esS">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>Compomax</title>
<!-- CSS Bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- CSS Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
	referrerpolicy="no-referrer" />
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f9f9f9;
}

.container {
	margin-top: 20px;
	margin-bottom: 20px;
}

.product-image {
	height: 80px;
	border-radius: 8px;
	box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
	margin-bottom: 15px;
	display: block;
	margin: 0 auto;
}

.product-details h1 {
	font-size: 22px;
	font-weight: bold;
	color: #333;
	margin-bottom: 15px;
	text-align: center;
}

.mini-codigo {
	font-size: 14px;
	text-align: center;
	margin-bottom: 8px;
}

.stock-info {
	font-size: 14px;
	font-weight: bold;
	color: #d9534f;
	text-align: center;
}

.price {
	font-size: 26px;
	font-weight: bold;
	color: #28a745;
	text-align: center;
	margin: 15px 0;
}

.btn-ver-mas {
	display: block;
	text-align: center;
	margin: 0 auto 15px;
	color: #007bff;
	text-decoration: none;
	font-weight: bold;
}

.btn-ver-mas:hover {
	text-decoration: underline;
	color: #0056b3;
}

.btn-add {
	background-color: #dc3545;
	color: #fff;
	font-weight: bold;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	text-transform: uppercase;
	display: block;
	width: 100%;
	text-align: center;
	transition: background-color 0.3s ease;
	font-size: 14px;
}

.btn-add:hover {
	background-color: #b02a37;
}

.form-control {
	border-radius: 4px;
	border: 1px solid #ced4da;
	padding: 8px;
	font-size: 14px;
}
</style>
</head>
<body>
	<header>
		<jsp:include page="cabecera.jsp"></jsp:include>
	</header>
	<div class="container carrito-container">


		<main>
			<!-- Si no hay productos -->
			<c:if test="${cantArticulos == 0}">
				<div style="text-align: center;">
					<h1>Carrito de Compras</h1>
					<img src="img/productos/carrovacio.png" alt="Carrito vacío"
						width="100px">
						<br>
					<p>
						Su carrito está vacío. <a href="catalogo">Empiece a comprar</a>
					</p>
				</div>
			</c:if>

			<!-- Si hay productos -->
			<c:if test="${cantArticulos > 0}">
				<div class="row">
					<!-- Detalle de productos -->
					<div class="col-md-8">
						<h1>Carrito de Compras</h1>
						<table class="table table-bordered">
							<thead class="table-light">
								<tr>
									<th>Producto</th>
									<th>Nombre</th>
									<th>Cantidad</th>
									<th>Precio</th>
									<th>Importe</th>
									<th>Acción</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${carro}" var="d">
									<tr>
										<td><img
											src="img/productos/${d.idprod}.jpg?${System.currentTimeMillis()}"
											class="product-image" alt="${d.nombprod}"
											onerror="this.src='img/productos/vacio.jpg'"></td>
										<td>${d.nombprod}</td>
										<td>${d.cantidad}</td>
										<td>S/ ${d.preciovta}</td>
										<td class="total-importe">S/ ${d.importe}</td>
										<td><a href="eliminar?cod=${d.idprod}"
											class="btn btn-outline-warning btn-sm">Eliminar <i
												class="fas fa-trash"></i></a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<a href="catalogo" class="btn btn-primary">Continuar Comprando</a>
					</div>

					<!-- Resumen de pedido -->
					<div class="col-md-4">
						<div class="resumen-container">
							<h3>Resumen del Pedido</h3>
							<p>
								Total artículos: <strong>${cantArticulos}</strong>
							</p>
							<p>
								Subtotal: <strong>S/ ${subTotalVenta}</strong>
							</p>
							<hr>
							<form action="pagar" method="post">
								<button type="submit" class="btn btn-primary w-100">
									Procesar Compra <i class="fas fa-credit-card"></i>
								</button>
							</form>
						</div>

					</div>
				</div>
			</c:if>
		</main>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>
