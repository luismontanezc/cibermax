package com.ciberfarma.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ciberfarma.mantenimientos.GestionVenta;
import com.ciberfarma.model.Boleta;
import com.ciberfarma.model.DetalleBoleta;
import com.ciberfarma.model.Usuario;

/**
 * Servlet implementation class FinalizarCompraServlet
 */
@WebServlet(name = "pagar", urlPatterns = { "/pagar" })
public class FinalizarCompraServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    		
    	System.out.println("Ingresó al post de Finalizar....");

        // Validar que el usuario esté logueado
        Usuario u = (Usuario) request.getSession().getAttribute("usuarioActivo");
        if (u == null) {
            request.setAttribute("mensaje", 
                "<script>Swal.fire({icon: 'error', title: 'No Autorizado', text: 'Debe iniciar sesión para realizar una compra.'});</script>");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return; // Detener la ejecución si no hay usuario
        }

        // Crear boleta
        Boleta b = new Boleta();
        b.setCod_cliente(u.getCodigo());

        // Obtener detalles de la compra desde la sesión
        List<DetalleBoleta> carro = (List<DetalleBoleta>) request.getSession().getAttribute("carro");
        Double subTotalVenta = (Double) request.getSession().getAttribute("subTotalVenta");
        Integer cantArticulos = (Integer) request.getSession().getAttribute("cantArticulos");

        // Validar que el carro y los valores no sean nulos
        if (carro == null || subTotalVenta == null || cantArticulos == null || carro.isEmpty()) {
            request.setAttribute("mensaje", 
                "<script>Swal.fire({icon: 'warning', title: 'Carro vacío', text: 'No tiene productos en su carro.'});</script>");
            request.getRequestDispatcher("canasta.jsp").forward(request, response);
            return; // Detener la ejecución
        }

        // Realizar venta
        int ok = new GestionVenta().realizarVenta(b, carro);

        if (ok != 0) {
        	for (DetalleBoleta detalle : carro) {
                String idProducto = detalle.getIdprod();
                int cantidadVendida = detalle.getCantidad();
                // Obtener el stock actual y actualizarlo
                int stockProducto = ProductoServlet.obtenerStockProducto(idProducto); 
                ProductoServlet.actualizarStockProducto(idProducto, stockProducto); 
            }
            // Limpiar el carro de la sesión
            carro.clear();
            subTotalVenta = 0.0;
            cantArticulos = 0;
            request.getSession().setAttribute("carro", carro);
            request.getSession().setAttribute("subTotalVenta", subTotalVenta);
            request.getSession().setAttribute("cantArticulos", cantArticulos);

            // Mensaje de éxito
            request.setAttribute("mensaje", 
                "<script>Swal.fire({icon: 'success', title: '¡Compra realizada!', text: 'Su compra se ha procesado con éxito.'});</script>");
        } else {
            // Mensaje de error
            request.setAttribute("mensaje", 
                "<script>Swal.fire({icon: 'error', title: 'Error', text: 'Hubo un problema al procesar la compra. Por favor, intente de nuevo.'});</script>");
        }
        request.getRequestDispatcher("canasta.jsp").forward(request, response);
    }
}









