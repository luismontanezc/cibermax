<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login-compomax</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
        integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />

    <style>
    /* Aplicamos estilos solo a esta página usando body.login-page */
    body.login-page {
        background: linear-gradient(to right, #00c6ff, #0072ff);
        font-family: 'Poppins', sans-serif;
    }

    .login-container {
        width: 50%;
        max-width: 500px; /* Evita que se haga demasiado grande */
        padding: 40px; /* Más espacio interno */
        background: white;
        border-radius: 12px;
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
        text-align: center;
    }

    .login-container h1 {
        font-size: 2rem; /* Aumentamos un poco el tamaño */
        font-weight: bold;
        color: #333;
        margin-bottom: 20px;
    }

    .login-container .form-control {
        border-radius: 8px;
        border: 1px solid #ccc;
        transition: all 0.3s ease-in-out;
    }

    .login-container .form-control:focus {
        border-color: #0072ff;
        box-shadow: 0 0 5px rgba(0, 114, 255, 0.5);
    }

    .login-container .btn-outline-primary {
        width: 100%;
        padding: 12px;
        border-radius: 8px;
        font-size: 1rem;
        font-weight: bold;
        transition: 0.3s;
    }

    .login-container .btn-outline-primary:hover {
        background-color: #0072ff;
        color: white;
    }

    .login-container .alert-danger {
        display: ${mensaje == null ? 'none' : 'block'};
        font-size: 0.9rem;
        padding: 10px;
        border-radius: 8px;
    }

    .login-container p a {
        color: #0072ff;
        font-weight: bold;
        text-decoration: none;
        transition: 0.3s;
    }

    .login-container p a:hover {
        text-decoration: underline;
    }
</style>

</head>
<body class="login-page d-flex justify-content-center align-items-center min-vh-100">
    <div class="login-container">
        <h1>Acceso al Sistema</h1>
        <form action="login" method="post">
            <div class="mb-3">
                <label for="exampleInputEmail1" class="form-label">Usuario</label>
                <input type="email" class="form-control" name="usuario" id="exampleInputEmail1"
                    aria-describedby="emailHelp">
            </div>
            <div class="mb-3">
                <label for="exampleInputPassword1" class="form-label">Password</label>
                <input type="password" class="form-control" name="clave" id="exampleInputPassword1">
            </div>
            <div class="mb-3">
                <button type="submit" class="btn btn-outline-primary">
                    <i class="fa-solid fa-key"></i> Ingresar
                </button>
            </div>

            <div class="alert alert-danger" role="alert">${mensaje}</div>
            <div class="mb-3">
                <p>Para registrar cuenta, pulse <a href="registro.jsp">aquí</a></p>
            </div>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>

</html>