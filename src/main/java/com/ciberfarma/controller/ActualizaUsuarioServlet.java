package com.ciberfarma.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ciberfarma.mantenimientos.GestionProducto;
import com.ciberfarma.mantenimientos.GestionUsuario;
import com.ciberfarma.model.Producto;
import com.ciberfarma.model.Usuario;

/**
 * Servlet implementation class ActualizaUsuarioServlet
 */
@WebServlet(name = "actuser", urlPatterns = { "/actuser" })
public class ActualizaUsuarioServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Ingresó al get del Servlet Actualizar");
		// 1. capture el atributo de usuario (u) enviado desde el Servlet
		// Usuario u = (Usuario) request.getSession().getAttribute("u");
		// 2. enviar a la página actualiza
		// request.getSession().setAttribute("u", u);
		// 3. cargar la página
		request.getRequestDispatcher("actualiza.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// leer los datos del form de actualizar
		// llamar al método actualizar de la Gestion
		// enviar mensajes en caso de éxito o error
		// regresar a la página
		try {
			// Usuario u = new Usuario();
			// u.setCodigo(Integer.parseInt(request.getParameter("codigo"))); // bloq disabl
			
			Usuario u = (Usuario) request.getSession().getAttribute("u");			
			u.setNombre(request.getParameter("nombre"));
			u.setApellido(request.getParameter("apellido"));
			u.setClave(request.getParameter("clave"));
			System.out.println(u);
			
			int error = new GestionUsuario().actualizar(u);
			System.out.println(error);
			if (error != 0) {
				request.setAttribute("mensaje",
						"<script>Swal.fire({title:'Aviso!',text: 'Usuario actualizado!',icon: 'success'});</script>");
			} else {
				request.setAttribute("mensaje", 
						"<script>Swal.fire({title:'Error!',text: 'Error al actualizar: verificar datos',icon: 'error'});</script>");
			}
		} catch (Exception e) {
			request.setAttribute("mensaje", 
					"<script>Swal.fire({title:'Error!',text: '" + e.getMessage() + "!',icon: 'error'});</script>");
		}		
		request.getRequestDispatcher("actualiza.jsp").forward(request, response);
	}

}
