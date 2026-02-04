package com.ciberfarma.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ciberfarma.mantenimientos.GestionCategoria;
import com.ciberfarma.mantenimientos.GestionProducto;
import com.ciberfarma.model.Categoria;
import com.ciberfarma.model.Producto;

/**
 * Servlet implementation class CatalogoServlet
 */
@WebServlet(name = "catalogo", urlPatterns = { "/catalogo" })
public class CatalogoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    // Obtener el listado de productos con el nombre de la categoría
	    List<Producto> lstProductos = new GestionProducto().listadoConCategoria(); // Usar el método actualizado
	    List<Categoria> lstCategorias = new GestionCategoria().listado(); // Obtener listado de categorías

	    // Depuración: Mostrar cantidad de productos en consola
	    System.out.println("Productos obtenidos: " + lstProductos.size());

	    // Enviar los atributos a la página JSP
	    request.setAttribute("lstProductos", lstProductos);
	    request.setAttribute("lstCategorias", lstCategorias);

	    // Redireccionar a catalogo.jsp
	    request.getRequestDispatcher("catalogo.jsp").forward(request, response);
	}


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String tipoOrden = request.getParameter("tipoOrden");
	    String buscar = request.getParameter("buscar");
	    String paginaStr = request.getParameter("pagina");

	    int pagina = (paginaStr != null) ? Integer.parseInt(paginaStr) : 1;
	    int productosPorPagina = 12;

	    GestionProducto gp = new GestionProducto();
	    List<Producto> todosLosProductos;

	    if (buscar != null && !buscar.trim().isEmpty()) {
	        if ("categoria".equals(tipoOrden)) {
	            todosLosProductos = gp.buscarYOrdenarPorCategoria(buscar.trim());
	        } else if ("precioAsc".equals(tipoOrden)) {
	            todosLosProductos = gp.buscarYFiltrarPorPrecio(buscar.trim(), "asc");
	        } else if ("precioDesc".equals(tipoOrden)) {
	            todosLosProductos = gp.buscarYFiltrarPorPrecio(buscar.trim(), "desc");
	        } else {
	            todosLosProductos = gp.buscarProductos(buscar.trim());
	        }
	        request.setAttribute("busqueda", buscar);
	        request.setAttribute("nroResultados", todosLosProductos.size());
	    } else {
	        if ("categoria".equals(tipoOrden)) {
	            todosLosProductos = gp.ordenarPorCategoria();
	        } else if ("precioAsc".equals(tipoOrden)) {
	            todosLosProductos = gp.filtrarPorPrecio("asc");
	        } else if ("precioDesc".equals(tipoOrden)) {
	            todosLosProductos = gp.filtrarPorPrecio("desc");
	        } else {
	            todosLosProductos = gp.listadoConCategoria();
	        }
	    }

	    int totalProductos = todosLosProductos.size();
	    int totalPaginas = (int) Math.ceil((double) totalProductos / productosPorPagina);

	    int inicio = (pagina - 1) * productosPorPagina;
	    int fin = Math.min(inicio + productosPorPagina, totalProductos);

	    List<Producto> productosPagina = todosLosProductos.subList(inicio, fin);

	    request.setAttribute("lstProductos", productosPagina);
	    request.setAttribute("tipoOrden", tipoOrden);
	    request.setAttribute("paginaActual", pagina);
	    request.setAttribute("totalPaginas", totalPaginas);
	    request.setAttribute("nroResultados", totalProductos);

	    request.getRequestDispatcher("catalogo.jsp").forward(request, response);
	}



}
