package com.ciberfarma.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ciberfarma.conexion.MySQLConexion;
import com.ciberfarma.model.DetalleBoleta;
import com.ciberfarma.model.Producto;

/**
 * Servlet implementation class AgregarCompraServlet
 */
@WebServlet(name = "addCompra", urlPatterns = { "/addCompra" })
public class AgregarCompraServlet extends HttpServlet {
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
	    // Obtener parámetros del formulario
	    String idProducto = request.getParameter("idProducto");
	    String descripcion = request.getParameter("descripcion");
	    double precio = Double.parseDouble(request.getParameter("precio"));
	    int cantidadSolicitada = Integer.parseInt(request.getParameter("cantidad")); // Obtener la cantidad seleccionada por el usuario

	    // Obtener variables de sesión
	    List<DetalleBoleta> carro = (List<DetalleBoleta>) request.getSession().getAttribute("carro");
	    double subTotalVenta = (double) request.getSession().getAttribute("subTotalVenta");
	    int cantArticulos = (int) request.getSession().getAttribute("cantArticulos");

	    // Definir stock inicial (esto podría estar en una base de datos en una aplicación real)
	    int stockProducto = ProductoServlet.obtenerStockProducto(idProducto);
	    int cantidadEnCarrito = 0;

	    // Calcular la cantidad actual del producto en el carrito
	    for (DetalleBoleta d : carro) {
	        if (d.getIdprod().equals(idProducto)) {
	            cantidadEnCarrito = d.getCantidad();
	            break;
	        }
	    }

	    // Verificar si la cantidad solicitada es menor o igual al stock disponible
	    if (cantidadSolicitada <= stockProducto) {

	        // Verificar si el producto ya está en el carrito
	        boolean existe = false;
	        for (DetalleBoleta d : carro) {
	            if (d.getIdprod().equals(idProducto)) {
	                d.setCantidad(d.getCantidad() + cantidadSolicitada);
	                d.setImporte(d.getImporte() + (precio * cantidadSolicitada));
	                existe = true;
	                break;
	            }
	        }

	        // Si el producto no está en el carrito, agregarlo como un nuevo detalle
	        if (!existe) {
	            DetalleBoleta nuevoDetalle = new DetalleBoleta();
	            nuevoDetalle.setIdprod(idProducto);
	            nuevoDetalle.setNombprod(descripcion);
	            nuevoDetalle.setPreciovta(precio);
	            nuevoDetalle.setCantidad(cantidadSolicitada);
	            nuevoDetalle.setImporte(precio * cantidadSolicitada);
	            carro.add(nuevoDetalle);
	        }
	        subTotalVenta += precio * cantidadSolicitada;
	        cantArticulos += cantidadSolicitada;

	     
	        request.getSession().setAttribute("carro", carro);
	        request.getSession().setAttribute("subTotalVenta", subTotalVenta);
	        request.getSession().setAttribute("cantArticulos", cantArticulos);
	        request.getSession().setAttribute("mensaje", "Añadido correctamente al carrito.");
	        request.getSession().setAttribute("tipo", "success");
	    } else { 
	        request.getSession().setAttribute("mensaje", "No hay suficiente stock.");
	        request.getSession().setAttribute("tipo", "error");
	    }
 
	    String referer = request.getHeader("referer"); 
	    if (referer != null && !referer.isEmpty()) {
	        response.sendRedirect(referer);
	    } else {
	        response.sendRedirect("canasta");
	    }
	}
}

