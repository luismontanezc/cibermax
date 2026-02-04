package com.ciberfarma.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CerrarSesionServlet
 */
@WebServlet(name = "logout", urlPatterns = { "/logout" })
public class CerrarSesionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener la sesión actual y eliminar atributos
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute("nombreUsuario");
            session.removeAttribute("tipoUsuario");
            session.removeAttribute("usuarioActivo");
            session.invalidate(); // Invalida la sesión
        }
        response.sendRedirect("principal.jsp"); // Redirige al inicio
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response); // Llama al método doGet
    }
}

