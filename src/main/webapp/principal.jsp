<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Compomax</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link href="css/estilos.css" rel="stylesheet">
</head>

<body>
	<div id="contenedor">
		<jsp:include page="cabecera.jsp"></jsp:include>
		<jsp:include page="menu_nav.jsp"></jsp:include>
		<jsp:include page="header.jsp"></jsp:include>

		<section>
  <h1>LOS MAS VENDIDOS</h1>
  <div class="row">
    <div class="col-12 col-sm-4 mb-4">
    <a href="muestra?codigo=P0001" style="text-decoration: none;">
      <div class="card bg-primary text-white">
        <img class="card-img-top productos" src="img/productos/P0001.jpg" alt="Imagen 1" style="height: 450px; object-fit: cover;">
        <div class="card-body">
          <h5 class="card-title">MSI, GEFORCE RTX 3050 8 GB GDRR6 VENTUS 2X</h5>
        </div>
      </div>
    </a>
    </div>
    <div class="col-12 col-sm-4 mb-4">
    <a href="muestra?codigo=P0011" style="text-decoration: none;">
      <div class="card bg-success text-white">
        <img class="card-img-top productos" src="img/productos/P0011.jpg" alt="Imagen 2" style="height: 450px; object-fit: cover;">
        <div class="card-body">
          <h5 class="card-title">AMD, RYZEN 5 5600 6N/12H 3.9Ghz PCLE 4.0 BULK</h5>
        </div>
      </div>
    </a>
    </div>
    <div class="col-12 col-sm-4 mb-4">
    <a href="muestra?codigo=P0008" style="text-decoration: none;">
      <div class="card bg-secondary text-white">
        <img class="card-img-top productos" src="img/productos/P0008.jpg" alt="Imagen 3" style="height: 450px; object-fit: cover;">
        <div class="card-body">
          <h5 class="card-title">MSI, G244F 24P 170HZ 1MS FAST IPS FREESYNC 110%sRGB</h5>
        </div>
      </div>
    </a>
    </div>
  </div>
</section>

<aside></aside>
<section>
  <h1 class="text-center mb-5">PRODUCTOS DESTACADOS</h1>
  <div class="row">
    <div class="col-12 col-md-3 mb-4">
    <a href="muestra?codigo=P0009" style="text-decoration: none;">
      <div class="card shadow-sm">
        <img src="img/productos/P0009.jpg" class="card-img-top" alt="Imagen 1" style="height: 250px; object-fit: cover;">
        <div class="card-body bg-primary text-white text-center">
          <h5 class="card-title">Teclado</h5>
        </div>
      </div>
    </a>
    </div>
    <div class="col-12 col-md-3 mb-4">
    <a href="muestra?codigo=P0004" style="text-decoration: none;">
      <div class="card shadow-sm">
        <img src="img/productos/P0004.jpg" class="card-img-top" alt="Imagen 2" style="height: 250px; object-fit: cover;">
        <div class="card-body bg-success text-white text-center">
          <h5 class="card-title">Memoria Ram</h5>
        </div>
      </div>
    </a>
    </div>
    <div class="col-12 col-md-3 mb-4">
    <a href="muestra?codigo=P0014" style="text-decoration: none;">
      <div class="card shadow-sm">
        <img src="img/productos/P0014.jpg" class="card-img-top" alt="Imagen 3" style="height: 250px; object-fit: cover;">
        <div class="card-body bg-warning text-dark text-center">
          <h5 class="card-title">Monitores</h5>
        </div>
      </div>
    </a>
    </div>
    <div class="col-12 col-md-3 mb-4">
    <a href="muestra?codigo=P0012" style="text-decoration: none;">
      <div class="card shadow-sm">
        <img src="img/productos/P0012.jpg" class="card-img-top" alt="Imagen 4" style="height: 250px; object-fit: cover;">
        <div class="card-body bg-danger text-white text-center">
          <h5 class="card-title">Mouse</h5>
        </div>
      </div>
    </a>
    </div>
  </div>
</section>

<aside></aside>
<section>
  <h1 class="text-center mb-5">ULTIMOS INGRESOS</h1>
  <div class="row g-4">
    <div class="col-12 col-md-4">
    <a href="muestra?codigo=P0016" style="text-decoration: none;">
      <div class="card shadow-sm">
        <img src="img/productos/P0016.jpg" class="card-img-top" alt="procesador" style="height: 300px; object-fit: cover;">
        <div class="card-body">
          <h5 class="card-title">Procesador Intel Core i5 - ¡Nuevo!</h5>
          <p class="card-text">12400F de 2,50 GHz/4,40 GHz, 18 MB, LGA1700</p>
        </div>
      </div>
    </a>
    </div>
    <div class="col-12 col-md-4">
    <a href="muestra?codigo=P0007" style="text-decoration: none;">
      <div class="card shadow-sm">
        <img src="img/productos/P0007.jpg" class="card-img-top" alt="deepcool" style="height: 300px; object-fit: cover;">
        <div class="card-body">
          <h5 class="card-title">DEEPCOOL, CC360 ARGB BLANCO/ TORRE MEDIA SIN FUENTE</h5>
        </div>
      </div>
    </a>
    </div>
    <div class="col-12 col-md-4">
    <a href="muestra?codigo=P0013" style="text-decoration: none;">
      <div class="card shadow-sm">
        <img src="img/productos/P0013.jpg" class="card-img-top" alt="msi" style="height: 300px; object-fit: cover;">
        <div class="card-body">
          <h5 class="card-title">MSI MAG A650BN 650W 80 PLUS BRONCE</h5>
        </div>
      </div>
    </a>
    </div>
  </div>
</section>

		<aside></aside>

					<jsp:include page="footer.jsp"></jsp:include>

	</div>
	
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>
