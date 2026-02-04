package com.ciberfarma.controller;

import java.io.IOException;
import java.util.Comparator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ciberfarma.mantenimientos.GestionProducto;
import com.ciberfarma.model.Producto;

@WebServlet(name = "tarjetas", urlPatterns = { "/tarjetas" })
public class TarjetasServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tipoOrden = request.getParameter("tipoOrden");
        String paginaStr = request.getParameter("pagina");

        int pagina = (paginaStr != null) ? Integer.parseInt(paginaStr) : 1;
        int productosPorPagina = 12;

        GestionProducto gp = new GestionProducto();
        List<Producto> todosLosProductos = gp.filtrarPorCategoria(2); // Filtrar productos de categoría 2 (Tarjetas de Video)

        // Aplicar ordenamiento
        if ("precioAsc".equals(tipoOrden)) {
            todosLosProductos.sort(Comparator.comparing(Producto::getPrecio));
        } else if ("precioDesc".equals(tipoOrden)) {
            todosLosProductos.sort(Comparator.comparing(Producto::getPrecio).reversed());
        }

        // Paginación
        int totalProductos = todosLosProductos.size();
        int totalPaginas = (int) Math.ceil((double) totalProductos / productosPorPagina);

        int inicio = (pagina - 1) * productosPorPagina;
        int fin = Math.min(inicio + productosPorPagina, totalProductos);

        List<Producto> productosPagina = todosLosProductos.subList(inicio, fin);

        // Enviar atributos al JSP
        request.setAttribute("lstProductos", productosPagina);
        request.setAttribute("paginaActual", pagina);
        request.setAttribute("totalPaginas", totalPaginas);
        request.setAttribute("tipoOrden", tipoOrden);

        request.getRequestDispatcher("tarjetas.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
