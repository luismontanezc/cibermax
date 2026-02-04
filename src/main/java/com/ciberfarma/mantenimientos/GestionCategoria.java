package com.ciberfarma.mantenimientos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.ciberfarma.conexion.MySQLConexion;
import com.ciberfarma.model.Categoria;

public class GestionCategoria {

    // Listado de categorías
	public List<Categoria> listado() {
	    List<Categoria> lista = new ArrayList<>();
	    String sql = "SELECT idcategoria, descripcion FROM tb_categorias";
	    try (Connection cn = MySQLConexion.getConexion();
	         PreparedStatement ps = cn.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) {
	        while (rs.next()) {
	            Categoria c = new Categoria();
	            c.setIdcategoria(rs.getInt("idcategoria")); // Usa el método existente
	            c.setDescripcion(rs.getString("descripcion"));
	            lista.add(c);
	        }
	    } catch (Exception e) {
	        System.out.println("Error en listado de categorías: " + e.getMessage());
	    }
	    return lista;
	}

}
