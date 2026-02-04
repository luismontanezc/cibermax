package com.ciberfarma.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ciberfarma.model.DetalleBoleta;

/**
 * Servlet implementation class EliminarCompraServlet
 */
@WebServlet(name = "eliminar", urlPatterns = { "/eliminar" })
public class EliminarCompraServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EliminarCompraServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// leer el código del producto a elimimar del carro (param)
		String codigo = request.getParameter("cod");
		
		// buscar el producto en el carro y removerlo, descontando las var. globales
		List<DetalleBoleta> carro = (List<DetalleBoleta>) request.getSession().getAttribute("carro");
        double subTotalVenta = (double) request.getSession().getAttribute("subTotalVenta");
        int cantArticulos = (int) request.getSession().getAttribute("cantArticulos");
		
        for (DetalleBoleta detalleBoleta : carro) {
			if (detalleBoleta.getIdprod().equals(codigo)) {
				subTotalVenta -= detalleBoleta.getImporte();
				cantArticulos -= detalleBoleta.getCantidad();
			
                int stockActual = ProductoServlet.obtenerStockProducto(codigo);  // Obtener el stock actual
                ProductoServlet.actualizarStockProducto(codigo, stockActual + detalleBoleta.getCantidad());  // Sumar la cantidad eliminada al stock               
				
				carro.remove(detalleBoleta);
				break;
			}
		}
        
		// actualizar el carro y variables
        request.getSession().setAttribute("carro", carro);
        request.getSession().setAttribute("subTotalVenta", subTotalVenta);
        request.getSession().setAttribute("cantArticulos", cantArticulos);
		
        response.sendRedirect("canasta.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
	}

}
