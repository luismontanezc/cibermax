package com.ciberfarma.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ciberfarma.mantenimientos.GestionUsuario;
import com.ciberfarma.model.Usuario;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet(name = "login", urlPatterns = { "/login" })
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener los datos del formulario
        String usuario = request.getParameter("usuario");
        String clave = request.getParameter("clave");

        try {
            // Validar usuario
            GestionUsuario gestion = new GestionUsuario();
            Usuario user = gestion.validar(usuario, clave);

            if (user != null) {
                // Crear sesión y guardar datos del usuario
                HttpSession session = request.getSession();
                session.setAttribute("nombreUsuario", user.getNombre());
                session.setAttribute("tipoUsuario", user.getTipo());
                session.setAttribute("usuarioActivo", user); // Guarda el objeto completo si es necesario
                response.sendRedirect("principal.jsp"); // Redirige al inicio
            } else {
                // Usuario no encontrado, regresar al login con mensaje de error
                request.setAttribute("mensaje", "<script>Swal.fire({icon: 'error', title: 'Error', text: 'Usuario o clave incorrectos.'});</script>");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "<script>Swal.fire({icon: 'error', title: 'Error', text: 'Hubo un problema al validar el usuario.'});</script>");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}


