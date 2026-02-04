<div id="banner">
    <img class="carrusel-imagen" src="img/banner.jpg" alt="Imagen 1">
    <img class="carrusel-imagen" src="img/banner5.png" alt="Imagen 2">
    <img class="carrusel-imagen" src="img/banner7.jpg" alt="Imagen 7">
    <img class="carrusel-imagen" src="img/banner4.jpg" alt="Imagen 8">
    <img class="carrusel-imagen" src="img/banner10.jpg" alt="Imagen 8">
    <!-- Botones para navegar -->
    <button id="prev" class="banner-btn">&lt;</button>
    <button id="next" class="banner-btn">&gt;</button>
</div>


<script>
    // Seleccionar todas las imágenes y botones
    const imagenes = document.querySelectorAll('.carrusel-imagen');
    const btnPrev = document.getElementById('prev');
    const btnNext = document.getElementById('next');
    let indiceActual = 0;
    let autoPlayInterval;

    // Mostrar la primera imagen al cargar la página
    imagenes[indiceActual].classList.add('active');

    // Función para mostrar una imagen específica
    function mostrarImagen(indice) {
        imagenes.forEach((img, i) => {
            img.classList.remove('active');
            if (i === indice) img.classList.add('active');
        });
    }

    // Función para mostrar la siguiente imagen
    function mostrarSiguienteImagen() {
        indiceActual = (indiceActual + 1) % imagenes.length;
        mostrarImagen(indiceActual);
    }

    // Función para mostrar la imagen anterior
    function mostrarImagenAnterior() {
        indiceActual = (indiceActual - 1 + imagenes.length) % imagenes.length;
        mostrarImagen(indiceActual);
    }

    // Reiniciar el temporizador automático
    function reiniciarAutoPlay() {
        clearInterval(autoPlayInterval); // Detener el temporizador actual
        autoPlayInterval = setInterval(mostrarSiguienteImagen, 3000); // Reiniciar el temporizador
    }

    // Event listeners para los botones
    btnNext.addEventListener('click', () => {
        mostrarSiguienteImagen();
        reiniciarAutoPlay(); // Reiniciar el temporizador al presionar "siguiente"
    });

    btnPrev.addEventListener('click', () => {
        mostrarImagenAnterior();
        reiniciarAutoPlay(); // Reiniciar el temporizador al presionar "anterior"
    });

    // Inicializar el temporizador automático
    autoPlayInterval = setInterval(mostrarSiguienteImagen, 3000);
</script>

<style>
/* Reset global */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

#contenedor {
    width: 100%;
    height: 100%;
    margin: 0 auto;
}

#banner {
    width: 100%;
    height: 390px;
    position: relative;
    overflow: hidden;
}

.carrusel-imagen {
    width: 100%;
    height: 100%;
    position: absolute;
    top: 0;
    left: 0;
    opacity: 0;
    transition: opacity 1s ease-in-out;
}

.carrusel-imagen.active {
    opacity: 1;
}

/* Botones de navegación */
.banner-btn {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    width: 50px;
    height: 50px;
    background-color: rgba(0, 0, 255, 0.7); /* Azul con transparencia */
    border: 2px solid #fff; /* Borde blanco para contraste */
    color: white;
    font-size: 24px;
    font-weight: bold;
    cursor: pointer;
    z-index: 10;
    border-radius: 50%; /* Forma circular */
    display: flex;
    align-items: center;
    justify-content: center;
    transition: background-color 0.3s ease, transform 0.3s ease;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Sombra */
}

#prev {
    left: 20px; /* Botón izquierdo */
}

#next {
    right: 20px; /* Botón derecho */
}

/* Efecto hover en los botones */
.banner-btn:hover {
    background-color: rgba(0, 0, 255, 0.9); /* Más oscuro al pasar el cursor */
    transform: scale(1.1); /* Agrandar ligeramente */
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3); /* Incrementar sombra */
}
</style>


