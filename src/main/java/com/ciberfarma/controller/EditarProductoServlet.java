package com.ciberfarma.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ciberfarma.mantenimientos.GestionProducto;
import com.ciberfarma.model.Producto;

/**
 * Servlet implementation class EditarProductoServlet
 */
@WebServlet(name = "editar", urlPatterns = { "/editar" })
public class EditarProductoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// leer el producto seleccionado (codigo) de la lista
		String codigo = request.getParameter("codigo");
		// buscar la información del producto (BD)
		Producto p = new GestionProducto().obtener(codigo);
		// obtener el lista de Productos (tabla), categorias (combo)
		List<Producto> lstProductos = new GestionProducto().listado();
		// enviar el producto obtenido como atributo (a nivel de sesión) a la página
		request.setAttribute("p", p);
		request.setAttribute("lstProductos", lstProductos);
		// redirecciona la página
		request.getRequestDispatcher("crudproductos.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
