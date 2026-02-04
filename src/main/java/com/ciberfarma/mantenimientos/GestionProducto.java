package com.ciberfarma.mantenimientos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.ciberfarma.conexion.MySQLConexion;
import com.ciberfarma.model.Producto;

public class GestionProducto {

	// registrar
	public int registrar(Producto objProducto) {
		int ok = 0;                    // variable de control
		Connection con = null;         // validar la conexión con la BD
		PreparedStatement pst = null;  // preparar las sentencias
		try {
			con = MySQLConexion.getConexion();
			
			// sentencia sql
			// insert into tb_productos values ('codigo','nombre',stock,precio,categoria,1)
			String sql = "insert into tb_productos values (?,?,?,?,?,1)";
			
			// prepara la sentencia
			pst = con.prepareStatement(sql);
			
			pst.setString(1, objProducto.getIdprod());
			pst.setString(2, objProducto.getDescripcion());
			pst.setInt(3, objProducto.getStock());
			pst.setDouble(4, objProducto.getPrecio());
			pst.setInt(5, objProducto.getIdcategoria());

			ok = pst.executeUpdate(); 
		} catch (Exception e) {
			System.err.println("Error: " + e.getMessage());	
		} finally {
			MySQLConexion.closeConexion(con);
		}
		return ok;
	}
	
	// eliminar (borrado lógico)
	// eliminar (borrado lógico)
	public int eliminar(Producto objProducto) {
	    int ok = 0;
	    Connection con = null;
	    PreparedStatement pst = null;

	    try {
	        con = MySQLConexion.getConexion();
	        String sql = "DELETE FROM tb_productos WHERE idprod = ?";
	        pst = con.prepareStatement(sql);
	        pst.setString(1, objProducto.getIdprod());

	        ok = pst.executeUpdate(); // Ejecutar la eliminación
	        System.out.println("Producto eliminado: " + objProducto.getIdprod());
	    } catch (Exception e) {
	        System.err.println("Error en eliminar: " + e.getMessage());
	    } finally {
	        MySQLConexion.closeConexion(con);
	    }
	    return ok;
	}





	
	// actualizar
	public int actualizar(Producto objProducto) {
	    int ok = 0;
	    Connection con = null;
	    PreparedStatement pst = null;

	    try {
	        con = MySQLConexion.getConexion();

	        // Actualizar los datos excepto la imagen
	        String sql = "UPDATE tb_productos SET descripcion = ?, stock = ?, precio = ?, idcategoria = ? WHERE idprod = ?";
	        pst = con.prepareStatement(sql);
	        pst.setString(1, objProducto.getDescripcion());
	        pst.setInt(2, objProducto.getStock());
	        pst.setDouble(3, objProducto.getPrecio());
	        pst.setInt(4, objProducto.getIdcategoria());
	        pst.setString(5, objProducto.getIdprod());

	        ok = pst.executeUpdate();
	    } catch (Exception e) {
	        System.err.println("Error en actualizar: " + e.getMessage());
	    } finally {
	        MySQLConexion.closeConexion(con);
	    }
	    return ok;
	}

	
	// listado de TODOS los Productos
	public List<Producto> listado() {
	    List<Producto> lista = new ArrayList<>();  // Inicialización anticipada
	    Connection con = null;
	    PreparedStatement pst = null;
	    ResultSet rs = null;

	    try {
	        con = MySQLConexion.getConexion();
	        String sql = "SELECT * FROM tb_productos WHERE estado = 1 ORDER BY idcategoria"; // Filtro activo y ordenado
	        pst = con.prepareStatement(sql);
	        rs = pst.executeQuery();

	        while (rs.next()) {
	            Producto p = new Producto();
	            p.setIdprod(rs.getString("idprod"));
	            p.setDescripcion(rs.getString("descripcion"));
	            p.setStock(rs.getInt("stock"));
	            p.setPrecio(rs.getDouble("precio"));
	            p.setIdcategoria(rs.getInt("idcategoria"));
	            p.setEstado(rs.getInt("estado"));
	            
	            System.out.println("Producto: " + p.getDescripcion() + ", Precio: " + p.getPrecio());
	            lista.add(p);
	        }
	    } catch (Exception e) {
	        System.err.println("Error: " + e.getMessage());
	    } finally {
	        MySQLConexion.closeConexion(con);
	    }
	    return lista;
	}

	
	// listado x categoria
	public List<Producto> filtro(int idcategoria) {
	    List<Producto> lista = new ArrayList<>(); // Inicialización segura
	    Connection con = null;         
	    PreparedStatement pst = null;
	    ResultSet rs = null;

	    try {
	        con = MySQLConexion.getConexion();
	        String sql;
	        if (idcategoria == 0) {
	            sql = "SELECT * FROM tb_productos WHERE estado = 1 ORDER BY idcategoria";
	            pst = con.prepareStatement(sql);
	        } else {
	            sql = "SELECT * FROM tb_productos WHERE idcategoria = ? AND estado = 1 ORDER BY idcategoria";
	            pst = con.prepareStatement(sql);
	            pst.setInt(1, idcategoria);
	        }

	        rs = pst.executeQuery();

	        while (rs.next()) {
	            Producto p = new Producto();
	            p.setIdprod(rs.getString("idprod"));
	            p.setDescripcion(rs.getString("descripcion"));
	            p.setStock(rs.getInt("stock"));
	            p.setPrecio(rs.getDouble("precio"));
	            p.setIdcategoria(rs.getInt("idcategoria"));
	            p.setEstado(rs.getInt("estado"));
	            lista.add(p);
	        }
	    } catch (Exception e) {
	        System.err.println("Error: " + e.getMessage());
	    } finally {
	        MySQLConexion.closeConexion(con);
	    }
	    return lista;
	}


	
	public Producto obtener(String codigo) {
		Producto p = null;
		// -- proceso
		Connection con = null;         // validar la conexión con la BD
		PreparedStatement pst = null;  // preparar las sentencias
		ResultSet rs = null;           // guardará en MEM el select 
		try {
			con = MySQLConexion.getConexion();
			
			String sql = "select * from tb_productos where idprod = ?";
			pst = con.prepareStatement(sql);
			pst.setString(1, codigo);
 			
			rs = pst.executeQuery();
			
			if (rs.next()) {  // mientras hay dato en el rs 
				p = new Producto();
				p.setIdprod(rs.getString("idprod"));
				p.setDescripcion(rs.getString("descripcion"));
				p.setStock(rs.getInt("stock"));
				p.setPrecio(rs.getDouble("precio"));
				p.setIdcategoria(rs.getInt("idcategoria"));
				p.setEstado(rs.getInt("estado"));
			}			
		} catch (Exception e) {
			System.err.println("Error: " + e.getMessage());	
		} finally {
			MySQLConexion.closeConexion(con);
		}
		return p;
	}
	public List<Producto> filtrarPorPrecio(String orden) {
	    List<Producto> lista = new ArrayList<>();
	    Connection con = null;
	    PreparedStatement pst = null;
	    ResultSet rs = null;

	    try {
	        con = MySQLConexion.getConexion();
	        String sql = "SELECT p.*, c.descripcion AS nombreCategoria " +
	                     "FROM tb_productos p " +
	                     "JOIN tb_categorias c ON p.idcategoria = c.idcategoria " +
	                     "WHERE p.estado = 1 ORDER BY p.precio " + ("asc".equals(orden) ? "ASC" : "DESC");
	        pst = con.prepareStatement(sql);
	        rs = pst.executeQuery();

	        while (rs.next()) {
	            Producto p = new Producto();
	            p.setIdprod(rs.getString("idprod"));
	            p.setDescripcion(rs.getString("descripcion"));
	            p.setStock(rs.getInt("stock"));
	            p.setPrecio(rs.getDouble("precio"));
	            p.setIdcategoria(rs.getInt("idcategoria"));
	            p.setNombrecategoria(rs.getString("nombrecategoria")); // Asignar nombre de categoría
	            p.setEstado(rs.getInt("estado"));
	            lista.add(p);
	        }
	    } catch (Exception e) {
	        System.err.println("Error en filtrarPorPrecio(): " + e.getMessage());
	    } finally {
	        MySQLConexion.closeConexion(con);
	    }
	    return lista;
	}

	public List<Producto> ordenarPorCategoria() {
	    List<Producto> lista = new ArrayList<>();
	    Connection con = null;
	    PreparedStatement pst = null;
	    ResultSet rs = null;

	    try {
	        con = MySQLConexion.getConexion();
	        String sql = "SELECT p.*, c.descripcion AS nombreCategoria " +
	                     "FROM tb_productos p " +
	                     "JOIN tb_categorias c ON p.idcategoria = c.idcategoria " +
	                     "WHERE p.estado = 1 ORDER BY p.idcategoria";
	        pst = con.prepareStatement(sql);
	        rs = pst.executeQuery();

	        while (rs.next()) {
	            Producto p = new Producto();
	            p.setIdprod(rs.getString("idprod"));
	            p.setDescripcion(rs.getString("descripcion"));
	            p.setStock(rs.getInt("stock"));
	            p.setPrecio(rs.getDouble("precio"));
	            p.setIdcategoria(rs.getInt("idcategoria"));
	            p.setNombrecategoria(rs.getString("nombrecategoria")); // Asignar nombre de categoría
	            p.setEstado(rs.getInt("estado"));
	            lista.add(p);
	        }
	    } catch (Exception e) {
	        System.err.println("Error en ordenarPorCategoria(): " + e.getMessage());
	    } finally {
	        MySQLConexion.closeConexion(con);
	    }
	    return lista;
	}

	public List<Producto> filtrarPorCategoria(int idCategoria) {
	    List<Producto> lista = new ArrayList<>();
	    Connection con = null;
	    PreparedStatement pst = null;
	    ResultSet rs = null;

	    try {
	        con = MySQLConexion.getConexion();
	        String sql = "SELECT p.*, c.descripcion AS nombreCategoria " +
	                     "FROM tb_productos p " +
	                     "JOIN tb_categorias c ON p.idcategoria = c.idcategoria " +
	                     "WHERE p.idcategoria = ? AND p.estado = 1";
	        pst = con.prepareStatement(sql);
	        pst.setInt(1, idCategoria);
	        rs = pst.executeQuery();

	        while (rs.next()) {
	            Producto p = new Producto();
	            p.setIdprod(rs.getString("idprod"));
	            p.setDescripcion(rs.getString("descripcion"));
	            p.setStock(rs.getInt("stock"));
	            p.setPrecio(rs.getDouble("precio"));
	            p.setIdcategoria(rs.getInt("idcategoria"));
	            p.setNombrecategoria(rs.getString("nombreCategoria"));
	            lista.add(p);
	        }
	    } catch (Exception e) {
	        System.err.println("Error en filtrarPorCategoria(): " + e.getMessage());
	    } finally {
	        MySQLConexion.closeConexion(con);
	    }
	    return lista;
	}

	public List<Producto> buscarProductos(String buscar) {
	    List<Producto> lista = new ArrayList<>();
	    Connection con = null;
	    PreparedStatement pst = null;
	    ResultSet rs = null;

	    try {
	        con = MySQLConexion.getConexion();
	        String sql = "SELECT p.*, c.descripcion AS nombreCategoria " +
	                     "FROM tb_productos p " +
	                     "JOIN tb_categorias c ON p.idcategoria = c.idcategoria " +
	                     "WHERE p.estado = 1 AND p.descripcion LIKE ?";
	        pst = con.prepareStatement(sql);
	        pst.setString(1, "%" + buscar + "%");
	        rs = pst.executeQuery();

	        while (rs.next()) {
	            Producto p = new Producto();
	            p.setIdprod(rs.getString("idprod"));
	            p.setDescripcion(rs.getString("descripcion"));
	            p.setStock(rs.getInt("stock"));
	            p.setPrecio(rs.getDouble("precio"));
	            p.setIdcategoria(rs.getInt("idcategoria"));
	            p.setNombrecategoria(rs.getString("nombreCategoria"));
	            lista.add(p);
	        }
	    } catch (Exception e) {
	        System.err.println("Error en buscarProductos(): " + e.getMessage());
	    } finally {
	        MySQLConexion.closeConexion(con);
	    }
	    return lista;
	}
	public List<Producto> buscarYOrdenarPorCategoria(String buscar) {
	    List<Producto> lista = new ArrayList<>();
	    Connection con = null;
	    PreparedStatement pst = null;
	    ResultSet rs = null;

	    try {
	        con = MySQLConexion.getConexion();
	        String sql = "SELECT p.*, c.descripcion AS nombreCategoria " +
	                     "FROM tb_productos p " +
	                     "JOIN tb_categorias c ON p.idcategoria = c.idcategoria " +
	                     "WHERE p.estado = 1 AND p.descripcion LIKE ? " +
	                     "ORDER BY p.idcategoria";
	        pst = con.prepareStatement(sql);
	        pst.setString(1, "%" + buscar + "%");
	        rs = pst.executeQuery();

	        while (rs.next()) {
	            Producto p = new Producto();
	            p.setIdprod(rs.getString("idprod"));
	            p.setDescripcion(rs.getString("descripcion"));
	            p.setStock(rs.getInt("stock"));
	            p.setPrecio(rs.getDouble("precio"));
	            p.setIdcategoria(rs.getInt("idcategoria"));
	            p.setNombrecategoria(rs.getString("nombreCategoria"));
	            lista.add(p);
	        }
	    } catch (Exception e) {
	        System.err.println("Error en buscarYOrdenarPorCategoria(): " + e.getMessage());
	    } finally {
	        MySQLConexion.closeConexion(con);
	    }
	    return lista;
	}
	public List<Producto> buscarYFiltrarPorPrecio(String buscar, String orden) {
	    List<Producto> lista = new ArrayList<>();
	    Connection con = null;
	    PreparedStatement pst = null;
	    ResultSet rs = null;

	    try {
	        con = MySQLConexion.getConexion();
	        String sql = "SELECT p.*, c.descripcion AS nombreCategoria " +
	                     "FROM tb_productos p " +
	                     "JOIN tb_categorias c ON p.idcategoria = c.idcategoria " +
	                     "WHERE p.estado = 1 AND p.descripcion LIKE ? " +
	                     "ORDER BY p.precio " + ("asc".equals(orden) ? "ASC" : "DESC");
	        pst = con.prepareStatement(sql);
	        pst.setString(1, "%" + buscar + "%");
	        rs = pst.executeQuery();

	        while (rs.next()) {
	            Producto p = new Producto();
	            p.setIdprod(rs.getString("idprod"));
	            p.setDescripcion(rs.getString("descripcion"));
	            p.setStock(rs.getInt("stock"));
	            p.setPrecio(rs.getDouble("precio"));
	            p.setIdcategoria(rs.getInt("idcategoria"));
	            p.setNombrecategoria(rs.getString("nombreCategoria"));
	            lista.add(p);
	        }
	    } catch (Exception e) {
	        System.err.println("Error en buscarYFiltrarPorPrecio(): " + e.getMessage());
	    } finally {
	        MySQLConexion.closeConexion(con);
	    }
	    return lista;
	}
	public List<Producto> listadoConCategoria() {
	    List<Producto> lista = new ArrayList<>();
	    Connection con = null;
	    PreparedStatement pst = null;
	    ResultSet rs = null;

	    try {
	        con = MySQLConexion.getConexion();
	        String sql = "SELECT p.*, c.descripcion AS nombreCategoria " +
	                     "FROM tb_productos p " +
	                     "JOIN tb_categorias c ON p.idcategoria = c.idcategoria " +
	                     "WHERE p.estado = 1";
	        pst = con.prepareStatement(sql);
	        rs = pst.executeQuery();

	        while (rs.next()) {
	            Producto p = new Producto();
	            p.setIdprod(rs.getString("idprod"));
	            p.setDescripcion(rs.getString("descripcion"));
	            p.setStock(rs.getInt("stock"));
	            p.setPrecio(rs.getDouble("precio"));
	            p.setIdcategoria(rs.getInt("idcategoria"));
	            p.setNombrecategoria(rs.getString("nombreCategoria")); // Asignar nombre de categoría
	            lista.add(p);
	        }
	    } catch (Exception e) {
	        System.err.println("Error en listadoConCategoria(): " + e.getMessage());
	    } finally {
	        MySQLConexion.closeConexion(con);
	    }
	    return lista;
	}
	public Producto buscarPorCodigo(String id) {
        Producto p = null;
        String sql = "SELECT * FROM tb_productos WHERE idprod = ?";
        
        try (Connection cn = MySQLConexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
             
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                p = new Producto();
                p.setIdprod(rs.getString("idprod"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setStock(rs.getInt("stock"));
                p.setPrecio(rs.getDouble("precio"));
                p.setIdcategoria(rs.getInt("idcategoria"));
            }
        } catch (Exception e) {
            System.out.println("Error en buscarPorCodigo: " + e.getMessage());
        }
        return p;
    }
	
	
}
