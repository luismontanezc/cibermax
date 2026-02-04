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
<title>Compomax</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>

<body>
	<script>
function confirmarEliminacion(codigo) {
    Swal.fire({
        title: '¿Está seguro?',
        text: 'Se eliminará el producto con código ' + codigo,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Sí, eliminar',
        cancelButtonText: 'No, cancelar'
    }).then((result) => {
        if (result.isConfirmed) {
            // Redirigir con parámetros correctos
            window.location.href = 'crudprod?codigo=' + codigo + '&btnOpcion=eli';
        }
    });
}
</script>



	<div id="contenedor">
		<jsp:include page="cabecera.jsp"></jsp:include>
		<jsp:include page="menu_nav.jsp"></jsp:include>
		<main>
			<div class="container bg-white p-4 rounded">
				<h1 class="text-center mb-4">Mantenimiento de Productos</h1>

				<!-- Mostrar mensajes -->
				<c:if test="${not empty mensaje}">
					<div class="alert alert-success">${mensaje}</div>
				</c:if>



				<!-- Formulario de Productos -->
				<form class="row g-3" action="crudprod" method="post"
					enctype="multipart/form-data">
					<div class="col-12">
						<label for="inputCodigo" class="form-label">Código</label> <input
							required pattern="[Pp][0-9]{4}" name="codigo" type="text"
							class="form-control" id="inputCodigo" placeholder="P0000"
							maxlength="5" value="${empty p.idprod ? '' : p.idprod}" />

					</div>
					<input type="text" class="form-control" id="inputDescripcion"
						name="descripcion" placeholder="Descripción del producto"
						value="${empty p.descripcion ? '' : p.descripcion}" required />
					<div class="col-md-6">
						<label for="inputStock" class="form-label">Stock</label> <input
							name="stock" type="number" min="0" class="form-control"
							id="inputStock" value="${p.stock}" required />
					</div>
					<div class="col-md-6">
						<label for="inputPrecio" class="form-label">Precio</label> <input
							type="number" name="precio" min="0" step="0.01"
							class="form-control" id="inputPrecio" value="${p.precio}"
							required />
					</div>
					<div class="col-md-6">
						<label for="inputCategoria" class="form-label">Categoría</label> <select name="categoria" id="inputCategoria" class="form-select" required>
    <option value="" selected>Seleccionar</option>
    <c:forEach var="cat" items="${lstCategorias}">
        <option value="${cat.idcategoria}" ${p.idcategoria == cat.idcategoria ? 'selected' : ''}>
            ${cat.descripcion}
        </option>
    </c:forEach>
</select>

					</div>
					<div class="col-md-6">
						<label for="inputArchivo" class="form-label">Imagen</label> <input
							name="archivo" type="file" class="form-control" id="inputArchivo" />
						<p class="form-text">Si no seleccionas una nueva imagen, se
							mantendrá la actual.</p>
					</div>
					<div class="col-12">
						<button name="btnOpcion" value="reg" type="submit"
							class="btn btn-primary">Registrar</button>
						<button name="btnOpcion" value="act" type="submit"
							class="btn btn-success">Actualizar</button>





						<script>
function confirmarActualizacion(event) {
    event.preventDefault(); // Previene el envío automático del formulario

    Swal.fire({
        title: '¿Estás seguro?',
        text: '¿Deseas actualizar los datos de este producto?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Sí, actualizar',
        cancelButtonText: 'Cancelar'
    }).then((result) => {
        if (result.isConfirmed) {
            const form = document.forms[0]; // Selecciona el formulario
            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'btnOpcion';
            input.value = 'act'; // Asegura que el valor coincida con "act"
            form.appendChild(input);
            form.action = 'crudprod'; // Establece explícitamente el destino correcto
            form.submit(); // Envía el formulario
        } else {
            Swal.fire('Cancelado', 'La actualización fue cancelada', 'info');
        }
    });
}

</script>
					</div>
				</form>
				<br>

				<form action="crudprod" method="get" class="d-flex mb-4">
					<input type="text" name="buscar" class="form-control me-2"
						placeholder="Buscar productos..." value="${buscar}">
					<button type="submit" class="btn btn-primary">Buscar</button>
				</form>

				<!-- Tabla de Productos -->
				<div class="table-responsive mt-4">
					<table class="table table-hover">
						<thead class="table-dark">
							<tr>
								<th scope="col">Imagen</th>
								<th scope="col">Código</th>
								<th scope="col">Descripción</th>
								<th scope="col">Stock</th>
								<th scope="col">Precio</th>
								<th scope="col">Categoría</th>
								<th scope="col">Acciones</th>
							</tr>
						</thead>
						<tbody>
							<fmt:setLocale value="es-PE" />
							<c:forEach var="p" items="${lstProductos}">
								<tr>
									<td><img src="img/productos/${p.getIdprod()}.jpg?${System.currentTimeMillis()}"alt="imagen"
										onerror="this.src='img/productos/vacio.jpg'" width="80px">
									</td>
									<td>${p.idprod}</td>
									<td>${p.descripcion}</td>
									<td>${p.stock}</td>
									<td style="color: red; font-weight: bold;">S/ <fmt:formatNumber
											value="${p.precio}" type="number" maxFractionDigits="2" />
									</td>
									<td>${p.idcategoria}</td>
									<td><a href="crudprod?btnOpcion=edit&codigo=${p.idprod}"
										class="btn btn-info">Editar</a>
										<button onclick="confirmarEliminacion('${p.getIdprod()}')"
											class="btn btn-danger">Eliminar</button></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</main>
		<jsp:include page="footer.jsp"></jsp:include>

	</div>



	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
