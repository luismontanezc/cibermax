<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Footer</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
        }
        .footer {
            background-color: #002366; /* Color azul */
            color: white;
            padding: 20px;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }
        .footer-column {
            margin-bottom: 20px;
            flex: 1;
        }
        .footer h4 {
            margin-bottom: 10px;
            font-size: 16px;
            font-weight: bold;
        }
        .footer p {
            margin: 3px 0;
            font-size: 14px;
        }
        .footer a {
            color: white;
            text-decoration: none;
        }
        .boletin {
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .boletin input {
            padding: 8px;
            border: none;
            border-radius: 4px 0 0 4px;
            outline: none;
            width: 200px;
            font-size: 13px;
            
        }
        .boletin button {
            padding: 6px 10px;
            border: none;
            background-color: blue;
            color: white;
            border-radius: 0 4px 4px 0;
            cursor: pointer;
        }
        .boletin button:hover {
            background-color: #2832C2;
        }
        .social-icons img {
            width: 24px;
            margin-right: 8px;
        }
        iframe {
            border: 0;
            width: 100%;
            height: 180px; /* Altura para el mapa */
            border-radius: 10px;
        }
    </style>
    <!-- SweetAlert2 CDN -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        // Validar el correo electrónico y mostrar el mensaje SweetAlert2
        function validarSuscripcion() {
            const emailInput = document.getElementById('email');
            const email = emailInput.value.trim();

            if (email === "") {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Por favor, ingrese su dirección de correo electrónico.'
                });
                emailInput.focus();
                return false;
            } else {
                Swal.fire({
                    icon: 'success',
                    title: '¡Aviso!',
                    text: 'Subscrito con éxito.'
                });
                emailInput.value = ""; // Limpia el campo
                return false; // Evita que el formulario se envíe
            }
        }
    </script>
</head>
<body>
    <div class="footer">
        <!-- Columna 1: Logo y Contacto -->
        <div class="footer-column">
             <a href="#"><img src="img/evilevil.jpg" alt="Logo" height="100px"></a>
            <p><strong>Ventas:</strong> 922118232 - 905467164 - 946561832</p>
            <p><strong>Email:</strong> <a href="mailto:ventas@compomax.com">ventas@compomax.com</a></p>
            <p><strong>Dirección:</strong> Av. Garcilaso de la Vega 1248–1250<br>Galería Compupalace (Tienda 201)</p>
            <p><strong>WhatsApp Garantía:</strong> 959283589</p>
            <p><strong>Soporte:</strong> Tienda 107</p>
        </div>

        <!-- Columna 2: Boletín + Redes Sociales -->
        <div class="footer-column">
            <h4>BOLETÍN DE ANUNCIOS</h4>
            <form onsubmit="return validarSuscripcion();">
                <div class="boletin">
                    <input type="email" id="email" placeholder="Correo electrónico">
                    <button type="submit">Suscribirse</button>
                </div>
            </form>
           <p style="font-size: 10px;">Puede darse de baja en cualquier momento.</p>
            <!-- Redes Sociales -->
            <br>
            <h4>SÍGUENOS</h4>
            <div class="social-icons">
                <a href="facebook.com"><img src="img/facebook.png" alt="Facebook" height="25px"></a>
                <a href="instagram.com"><img src="img/instagram.png" alt="Instagram" height="25px"></a>
            </div>
        </div>

        <!-- Columna 3: Google Maps -->
        <div class="footer-column">
            <h4>UBICACIÓN</h4>
            <!-- Google Maps: Ubicación de ejemplo -->
            <iframe 
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3900.6904766368123!2d-77.03868422435079!3d-12.058622288228413!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x9105c8b1ebbb3c3b%3A0xf01c93881a6b43e4!2sGaler%C3%ADa%20Compupalace!5e0!3m2!1ses-419!2spe!4v1712620000000!5m2!1ses-419!2spe"
                allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade">
            </iframe>
        </div>
    </div>
</body>
</html>
