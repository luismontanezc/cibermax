package com.ciberfarma.mantenimientos;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.ciberfarma.conexion.MySQLConexion;
import com.ciberfarma.model.Usuario;

public class GestionUsuario {
	// reg, eli, act, listado
	
	// validar (consulta)
	public Usuario validar(String usuario, String clave) {
		Usuario u = null;  // variable de control > null : NO existe
		//-- plantilla
		Connection con = null;         
		PreparedStatement pst = null;  
		ResultSet rs = null;  
		try {
			con = MySQLConexion.getConexion();
			
			// select * from tb_usuarios where usuario = 'u001@gmail.com' and clave = 'clave';
			String sql = "select * from tb_usuarios where usuario = ? and clave = ?";
			
			// prepara la sentencia
			pst = con.prepareStatement(sql);
			pst.setString(1, usuario);
			pst.setString(2, clave);
			
			rs = pst.executeQuery();
			
			if (rs.next()) {  // si hay dato en el rs 
				u = new Usuario();
				u.setCodigo(rs.getInt("codigo"));
				u.setNombre(rs.getString("nombre"));
				u.setApellido(rs.getString("apellido"));
				u.setUsuario(rs.getString("usuario"));
				u.setClave(rs.getString("clave"));
				u.setFnacim(rs.getString("fnacim"));
				u.setTipo(rs.getInt("tipo"));
			}
			
		} catch (Exception e) {
			System.err.println("Error: " + e.getMessage());	
		} finally {
			MySQLConexion.closeConexion(con);
		}
		return u;
	}
	
	
	// actualizar
	public int actualizar(Usuario u) {
		int ok = 0;
		// plantilla
		Connection con = null;         
		PreparedStatement pst = null;  
		try {
			con = MySQLConexion.getConexion();
			
			String sql = "update tb_usuarios set nombre = ?, apellido = ?, clave = ? where codigo = ?";
			
			// prepara la sentencia
			pst = con.prepareStatement(sql);
			pst.setString(1, u.getNombre());
			pst.setString(2, u.getApellido());
			pst.setString(3, u.getClave());
			pst.setInt(4, u.getCodigo());

			ok = pst.executeUpdate(); 
		} catch (Exception e) {
			System.err.println("Error: " + e.getMessage());	
		} finally {
			MySQLConexion.closeConexion(con);
		}
		return ok;
	}
	
	    
	    // Método para registrar un usuario
	    public int registrar(Usuario objUsuario) {
	        int salida = 0;
	        Connection con = null;
	        CallableStatement cst = null;

	        try {
	            // Conexión a la base de datos
	            con = MySQLConexion.getConexion();

	            // SQL de inserción para los datos del usuario
	            String sql = "INSERT INTO tb_usuarios (nombre, apellido, usuario, clave, fnacim, tipo) VALUES (?, ?, ?, ?, ?, 2)";

	            // Crear la llamada al procedimiento
	            cst = con.prepareCall(sql);
	            
	            cst.setString(1, objUsuario.getNombre());
	            cst.setString(2, objUsuario.getApellido());
	            cst.setString(3, objUsuario.getUsuario());
	            cst.setString(4, objUsuario.getClave()); 
	            cst.setString(5, objUsuario.getFnacim());
	            

	            salida = cst.executeUpdate();

	        } catch (Exception e) {
	            // Capturar cualquier excepción que ocurra
	            System.out.println("Error: " + e.getMessage());
	        } finally {
	            // Cerrar la conexión a la base de datos
	            MySQLConexion.closeConexion(con);
	        }

	        return salida;
	    }

	    
	    


}
