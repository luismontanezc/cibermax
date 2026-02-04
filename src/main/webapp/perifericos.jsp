<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perifericos PC</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        h2 {
            font-weight: bold;
        }
        .espaciado-superior {
            margin-top: 30px;
        }
        .filtro-container {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }
        .producto-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
        }
        .producto {
            border: 1px solid #ddd;
            padding: 15px;
            width: 220px;
            text-align: center;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            background-color: white;
            display: flex;
            flex-direction: column;
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
            height: 185px;
            object-fit: contain;
            margin-bottom: 10px;
        }
        .producto h3 {
            font-size: 16px;
            color: #333;
            margin-bottom: 10px;
        }
        .producto .precio {
            color: blue;
            font-size: 20px;
            font-weight: bold;
            margin: 3px 0;
        }
        .producto .stock {
            font-size: 14px;
            color: gray;
            margin: 3px 0;
        }
        .producto form button {
            margin-top: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            padding: 8px 12px;
            cursor: pointer;
            text-decoration: none;
            border-radius: 4px;
        }
        .producto form button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div id="contenedor">
        <jsp:include page="cabecera.jsp"></jsp:include>
        <jsp:include page="menu_nav.jsp"></jsp:include>

        <div class="espaciado-superior"></div>
        <c:if test="${not empty sessionScope.mensaje}">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        Swal.fire({
            icon: '${sessionScope.tipo == "success" ? "success" : "error"}',
            title: 'Aviso',
            text: '${sessionScope.mensaje}'
        });
    </script>
    <c:remove var="mensaje" scope="session" />
    <c:remove var="tipo" scope="session" />
</c:if>
        

        <!-- Filtro alineado al centro -->
        <div class="filtro-container">
            <form action="perifericos" method="post" class="d-flex align-items-center gap-2">
                <label for="tipoOrden" class="me-2">Ordenar por:</label>
                <select name="tipoOrden" id="tipoOrden" class="form-select w-auto">
                    <option value="precioAsc" ${tipoOrden == 'precioAsc' ? 'selected' : ''}>Precio: Menor a Mayor</option>
                    <option value="precioDesc" ${tipoOrden == 'precioDesc' ? 'selected' : ''}>Precio: Mayor a Menor</option>
                </select>
                <button type="submit" class="btn btn-primary">Ordenar</button>
            </form>
        </div>

        <!-- Título del catálogo -->
        <h2 class="text-center mb-4">Perifericos de PC</h2>

        <!-- Contenedor de Productos -->
        <div class="container">
            <div class="producto-container">
                <c:forEach var="producto" items="${lstProductos}">
                    <div class="producto">
                        <a href="muestra?codigo=${producto.getIdprod()}">
                            <img src="img/productos/${producto.getIdprod()}.jpg" alt="${producto.descripcion}">
                        </a>
                        <h3>${producto.descripcion}</h3>
                        <p class="precio">S/. <fmt:formatNumber value="${producto.getPrecio()}" pattern="0.00" /></p>
                        <p class="stock">Stock: ${producto.stock}</p>
                        <!-- Botón para agregar al carrito -->
                        <form action="addCompra" method="post">
                            <input type="hidden" name="idProducto" value="${producto.getIdprod()}">
                            <input type="hidden" name="descripcion" value="${producto.descripcion}">
                            <input type="hidden" name="precio" value="${producto.getPrecio()}">
                            <button type="submit" class="btn btn-info btn-sm"
                            onclick="window.location.href='muestra?codigo=${producto.getIdprod()}'; return false;">
                            Añadir al Carrito</button>
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
                        <form method="post" action="${pageContext.request.requestURI}">
                            <input type="hidden" name="tipoOrden" value="${tipoOrden}">
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>