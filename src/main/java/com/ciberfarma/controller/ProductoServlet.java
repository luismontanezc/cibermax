package com.ciberfarma.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.ciberfarma.conexion.MySQLConexion;
import com.ciberfarma.mantenimientos.GestionCategoria;
import com.ciberfarma.mantenimientos.GestionProducto;
import com.ciberfarma.model.Categoria;
import com.ciberfarma.model.Producto;

@WebServlet(name = "crudprod", urlPatterns = { "/crudprod" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
		maxFileSize = 1024 * 1024 * 10, // 10MB
		maxRequestSize = 1024 * 1024 * 50) // 50MB
public class ProductoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final String UPLOAD_DIR = "img/productos"; // Ruta para guardar las imágenes

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String buscar = request.getParameter("buscar"); // Capturar el término de búsqueda
		String opcion = request.getParameter("btnOpcion"); // Determinar la acción

		if ("eli".equals(opcion)) {
			eliminarProducto(request.getParameter("codigo"), request, response);
			return; // Detener más procesamiento
		}

		if ("edit".equals(opcion)) {
			String codigo = request.getParameter("codigo");
			Producto p = new GestionProducto().buscarPorCodigo(codigo);
			if (p != null) {
				request.setAttribute("p", p); // Enviar el producto al formulario
			} else {
				request.setAttribute("mensaje",
						"<script>Swal.fire({icon: 'error', title: 'Error', text: 'No se encontró el producto para editar.'});</script>");
			}
		}

		List<Producto> lstProductos;
		if (buscar != null && !buscar.trim().isEmpty()) {
			lstProductos = new GestionProducto().buscarProductos(buscar); // Búsqueda
		} else {
			lstProductos = new GestionProducto().listado(); // Listar todos los productos
		}

		List<Categoria> lstCategorias = new GestionCategoria().listado();
		request.setAttribute("lstProductos", lstProductos);
		request.setAttribute("lstCategorias", lstCategorias);
		request.setAttribute("buscar", buscar); // Mantener el término de búsqueda
		request.getRequestDispatcher("crudproductos.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String opcion = request.getParameter("btnOpcion"); // Captura la acción
		if (opcion == null) {
			response.sendRedirect("crudproductos.jsp");
			return;
		}

		switch (opcion) {
		case "reg":
			registrar(request, response);
			break;
		case "act":
			actualizar(request, response);
			break;
		case "eli":
			eliminarProducto(request.getParameter("codigo"), request, response);
			break;
		default:
			response.sendRedirect("crudproductos.jsp");
			break;
		}
	}

	private void registrar(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String codigo = request.getParameter("codigo");
			String descripcion = request.getParameter("descripcion");
			int stock = Integer.parseInt(request.getParameter("stock"));
			double precio = Double.parseDouble(request.getParameter("precio"));
			int categoria = Integer.parseInt(request.getParameter("categoria"));

			Producto existente = new GestionProducto().buscarPorCodigo(codigo);
			if (existente != null) {
				request.setAttribute("mensaje",
						"<script>Swal.fire({icon: 'error', title: 'Error', text: 'Código en uso. Por favor, elige otro código.'});</script>");
				doGet(request, response);
				return;
			}

			Producto p = new Producto();
			p.setIdprod(codigo);
			p.setDescripcion(descripcion);
			p.setStock(stock);
			p.setPrecio(precio);
			p.setIdcategoria(categoria);

			Part filePart = request.getPart("archivo");
			if (filePart != null && filePart.getSize() > 0) {
				String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
				String fileName = codigo + ".jpg";
				filePart.write(uploadPath + File.separator + fileName);
			}

			int result = new GestionProducto().registrar(p);
			request.setAttribute("mensaje", result > 0
					? "<script>Swal.fire({icon: 'success', title: 'Éxito', text: 'Producto registrado correctamente.'});</script>"
					: "<script>Swal.fire({icon: 'error', title: 'Error', text: 'No se pudo registrar el producto.'});</script>");
		} catch (Exception e) {
			request.setAttribute("mensaje", "<script>Swal.fire({icon: 'error', title: 'Error', text: 'Error: "
					+ e.getMessage() + "'});</script>");
		}

		// Limpiar atributos y redirigir
		request.getSession().removeAttribute("p");
		doGet(request, response);
	}

	private void actualizar(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    try {
	        // Obtener parámetros
	        String codigo = request.getParameter("codigo");
	        String descripcion = request.getParameter("descripcion");
	        String stockParam = request.getParameter("stock");
	        String precioParam = request.getParameter("precio");
	        String categoriaParam = request.getParameter("categoria");

	        // Validar que los campos no estén vacíos
	        if (codigo == null || descripcion == null || stockParam == null || precioParam == null
	                || categoriaParam == null || codigo.isEmpty() || descripcion.isEmpty() || stockParam.isEmpty()
	                || precioParam.isEmpty() || categoriaParam.isEmpty()) {
	            request.setAttribute("mensaje",
	                    "<script>Swal.fire('Error', 'Todos los campos son obligatorios.', 'error');</script>");
	            doGet(request, response);
	            return;
	        }

	        // Convertir parámetros
	        int stock = Integer.parseInt(stockParam);
	        double precio = Double.parseDouble(precioParam);
	        int categoria = Integer.parseInt(categoriaParam);

	        // Crear objeto Producto
	        Producto p = new Producto();
	        p.setIdprod(codigo);
	        p.setDescripcion(descripcion);
	        p.setStock(stock);
	        p.setPrecio(precio);
	        p.setIdcategoria(categoria);

	        // Ruta completa al directorio de imágenes
	        String uploadPath = getServletContext().getRealPath("") + File.separator + "img" + File.separator + "productos";
	        File fileDir = new File(uploadPath);
	        if (!fileDir.exists()) {
	            fileDir.mkdirs(); // Crear el directorio si no existe
	        }

	        // Manejar la imagen
	        Part filePart = request.getPart("archivo");
	        if (filePart != null && filePart.getSize() > 0) {
	            // Eliminar la imagen anterior si existe
	            File oldFile = new File(uploadPath + File.separator + codigo + ".jpg");
	            if (oldFile.exists()) {
	                boolean deleted = oldFile.delete();
	                System.out.println("Imagen anterior eliminada: " + deleted);
	            }

	            // Guardar la nueva imagen
	            String fileName = codigo + ".jpg";
	            filePart.write(uploadPath + File.separator + fileName);
	            System.out.println("Nueva imagen agregada: " + uploadPath + File.separator + fileName);
	        } else {
	            System.out.println("No se adjuntó nueva imagen. Se mantiene la existente.");
	        }

	        // Actualizar producto en la base de datos
	        int result = new GestionProducto().actualizar(p);
	        if (result > 0) {
	            request.setAttribute("mensaje",
	                    "<script>Swal.fire('Éxito', 'Producto actualizado correctamente.', 'success');</script>");
	        } else {
	            request.setAttribute("mensaje",
	                    "<script>Swal.fire('Error', 'No se pudo actualizar el producto.', 'error');</script>");
	        }
	    } catch (NumberFormatException e) {
	        request.setAttribute("mensaje",
	                "<script>Swal.fire('Error', 'Formato numérico incorrecto.', 'error');</script>");
	    } catch (Exception e) {
	        request.setAttribute("mensaje",
	                "<script>Swal.fire('Error', 'Error: " + e.getMessage() + "', 'error');</script>");
	        e.printStackTrace();
	    }

	    request.getSession().removeAttribute("p");
	    doGet(request, response);
	}

	private void eliminarProducto(String codigo, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			if (codigo == null || codigo.isEmpty()) {
				request.setAttribute("mensaje",
						"<script>Swal.fire({icon: 'error', title: 'Error', text: 'Código inválido para eliminar.'});</script>");
				request.getRequestDispatcher("crudproductos.jsp").forward(request, response);
				return;
			}

			Producto p = new Producto();
			p.setIdprod(codigo);

			int result = new GestionProducto().eliminar(p);

			if (result > 0) {
				// Eliminar la imagen asociada al producto
				String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
				File file = new File(uploadPath + File.separator + codigo + ".jpg");
				if (file.exists())
					file.delete();

				request.setAttribute("mensaje",
						"<script>Swal.fire({icon: 'success', title: 'Producto Eliminado', text: 'El producto ha sido eliminado correctamente.'});</script>");
			} else {
				request.setAttribute("mensaje",
						"<script>Swal.fire({icon: 'error', title: 'Error', text: 'No se pudo eliminar el producto.'});</script>");
			}

			// Redirige directamente al JSP en lugar de volver a llamar a doGet
			List<Producto> lstProductos = new GestionProducto().listado();
			List<Categoria> lstCategorias = new GestionCategoria().listado();
			request.setAttribute("lstProductos", lstProductos);
			request.setAttribute("lstCategorias", lstCategorias);
			request.getRequestDispatcher("crudproductos.jsp").forward(request, response);
		} catch (Exception e) {
			request.setAttribute("mensaje", "<script>Swal.fire({icon: 'error', title: 'Error', text: 'Error: "
					+ e.getMessage() + "'});</script>");
			request.getRequestDispatcher("crudproductos.jsp").forward(request, response);
		}
		request.getSession().removeAttribute("p");
	}
	
	
	 public static int obtenerStockProducto(String idProducto) {
	        int stock = 0;
	        try (Connection conn = MySQLConexion.getConexion()) {
	            String query = "SELECT stock FROM tb_productos WHERE idprod = ?";
	            try (PreparedStatement stmt = conn.prepareStatement(query)) {
	                stmt.setString(1, idProducto);
	                ResultSet rs = stmt.executeQuery();
	                if (rs.next()) {
	                    stock = rs.getInt("stock");
	                }
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return stock;
	    }

	    public static void actualizarStockProducto(String idProducto, int nuevoStock) {
	        try (Connection conn = MySQLConexion.getConexion()) {
	            String query = "UPDATE tb_productos SET stock = ? WHERE idprod = ?";
	            try (PreparedStatement stmt = conn.prepareStatement(query)) {
	                stmt.setInt(1, nuevoStock);
	                stmt.setString(2, idProducto);
	                stmt.executeUpdate();
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	
	
}



