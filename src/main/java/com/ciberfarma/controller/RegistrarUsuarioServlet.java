package com.ciberfarma.controller;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ciberfarma.model.Usuario;
import com.ciberfarma.mantenimientos.GestionUsuario;

/**
 * Servlet implementation class RegistrarUsuarioServlet
 */
@WebServlet(name = "Registrar", urlPatterns = { "/Registrar" })
public class RegistrarUsuarioServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		try {
		String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String correo = request.getParameter("usuario");
        String fechaNacimiento = request.getParameter("nacimiento");
        String clave = request.getParameter("clave");


        Usuario usuario = new Usuario();
        usuario.setNombre(nombre);
        usuario.setApellido(apellido);
        usuario.setUsuario(correo);
        usuario.setFnacim(fechaNacimiento);
        usuario.setClave(clave);
        
        
        int error = new GestionUsuario().registrar(usuario);
		System.out.println(usuario);
		if(error != 0) {
			request.setAttribute("mensaje",
					"<script>Swal.fire({title:'Usted se ha registrado',text: '',icon: 'success'});</script>");
			request.getRequestDispatcher("login.jsp").forward(request, response);
			
		}else {
			request.setAttribute("mensaje",
					"<script>Swal.fire({title:'Error al registrar',text: '',icon: 'error'});</script>");
			
			request.getRequestDispatcher("registro.jsp").forward(request, response);
		}
		
		
	} catch (Exception e) {
		request.setAttribute("mensaje",
				"<script>Swal.fire({title:'Aviso!',text: '" + e.getMessage() + "!',icon: 'success'});</script>");
	

	}
	}
}


