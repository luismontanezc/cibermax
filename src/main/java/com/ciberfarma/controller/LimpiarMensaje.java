package com.ciberfarma.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/LimpiarMensaje")
public class LimpiarMensaje extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Eliminar variables de sesión relacionadas con el mensaje
        request.getSession().removeAttribute("mensaje");
        request.getSession().removeAttribute("tipo");

        // Responder con estado 200 OK
        response.setStatus(HttpServletResponse.SC_OK);
    }
}
