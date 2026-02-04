<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalle del Producto</title>
    <!-- CSS Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- CSS Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <!-- SweetAlert -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <!-- Estilos personalizados -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 40px;
            margin-bottom: 40px
            
        }
        .product-img {
            height: 390px;
            border-radius: 10px;
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
        }
        .product-details h1 {
            font-size: 26px;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }
        .info-label {
            font-size: 14px;
            font-weight: bold;
            color: #555;
        }
        .stock {
            color: red;
            font-weight: bold;
        }
        .price {
            font-size: 30px;
            font-weight: bold;
            color: #007bff;
            margin: 10px 0;
        }
        .btn-ver-mas {
            color: blue;
            text-decoration: none;
            font-weight: bold;
            font-size: 14px;
        }
        .btn-ver-mas:hover {
            text-decoration: underline;
        }
        .btn-add {
            background-color: #007bff;
            color: white;
            font-weight: bold;
            padding: 12px 24px;
            text-transform: uppercase;
            border-radius: 8px;
            transition: background-color 0.3s ease;
            font-size: 16px;
        }
        .btn-add:hover {
            background-color: #0056b3;
        }
        .mini-codigo, .stock-info {
            font-size: 14px;
            margin: 5px 0;
        }
    </style>
</head>
<body>
    <jsp:include page="cabecera.jsp"></jsp:include>
    <jsp:include page="menu_nav.jsp"></jsp:include>

    <div class="container">
        <!-- Mostrar el mensaje de la sesión si existe -->
        <c:if test="${not empty sessionScope.mensaje}">
            <script>
                Swal.fire({
                    icon: "${sessionScope.tipo}",
                    title: "Aviso",
                    text: "${sessionScope.mensaje}"
                });
            </script>
            <c:remove var="mensaje" scope="session"/>
            <c:remove var="tipo" scope="session"/>
        </c:if>

        <!-- Detalle del producto -->
        <div class="row">
            <!-- Imagen del producto -->
            <div class="col-md-5">
                <img src="img/productos/${p.getIdprod()}.jpg?${System.currentTimeMillis()}" alt="${p.descripcion}" class="product-img">
            </div>
            <!-- Detalles del producto -->
            <div class="col-md-7">
                <h1>${p.descripcion}</h1>
                <p class="mini-codigo"><strong>CODIGO:</strong> ${p.idprod}</p>
                <p class="stock-info"><strong>STOCK:</strong> <span class="stock">${p.stock} unidades</span></p>
                <p class="price">S/ <fmt:formatNumber value="${p.precio}" pattern="0.00" /></p>
                <a href="catalogo?categoria=${p.idcategoria}" class="btn-ver-mas">Ver mas productos</a>

                <!-- Formulario para agregar al carrito -->
                <form action="addCompra" method="post" class="mt-4">
                    <input type="hidden" name="idProducto" value="${p.idprod}">
                    <input type="hidden" name="descripcion" value="${p.descripcion}">
                    <input type="hidden" name="precio" value="${p.precio}">
                    <input type="hidden" name="stock" value="${p.stock}">
                    <div class="mb-3">
                        <label for="cantidad" class="info-label">Cantidad:</label>
                        <input type="number" id="cantidad" name="cantidad" class="form-control" min="1" max="${p.stock}" value="1" required>
                    </div>
                    <button type="submit" class="btn btn-add w-100">Agregar al Carrito <i class="fas fa-shopping-cart ms-2"></i></button>
                </form>
            </div>
        </div>
    </div>

    <jsp:include page="footer.jsp"></jsp:include>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>



