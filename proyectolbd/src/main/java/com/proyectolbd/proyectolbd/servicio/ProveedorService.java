package com.proyectolbd.proyectolbd.servicio;

import com.proyectolbd.proyectolbd.modelo.Proveedor;
import java.sql.Date;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service
public class ProveedorService {
    
    @Autowired
    private JdbcTemplate jdbc;
    
    public void insertarProveedor(int id_Proveedor , String nombre, String contacto, String tipo_proveedor, int  id_Direccion)
    {
        jdbc.update("CALL PROVEEDOR_PKG.insertar_proveedor( ?, ?, ?, ?, ?)", id_Proveedor,nombre,  contacto,tipo_proveedor,id_Direccion);
    }
    
    public List<Proveedor> obtenerProveedor() {
        String sql = "select * from vista_proveedores";
        return jdbc.query(sql, (rs, rowNum) -> {
            Proveedor proveedor = new Proveedor();
            proveedor.setId_Provedor(rs.getInt("ID_PROVEEDOR"));
            proveedor.setNombre(rs.getString("NOMBRE_EMPRESA"));
            proveedor.setContacto(rs.getString("PERSONA_CONTACTO"));
            proveedor.setTipo_Proveedor(rs.getString("TIPO_PROVEEDOR"));
            proveedor.setId_Direccion(rs.getInt("ID_DIRECCION"));
            return proveedor;
        });
    }
    
    public List<Map<String, Object>> obtenerVistaProveedor() {
        String sql = "SELECT * FROM vista_proveedores";
        return jdbc.queryForList(sql);
    }
    
    public void eliminarProveedor(int id) {
        System.out.println("este es el id service:"+id);
        jdbc.update("CALL PROVEEDOR_PKG.eliminar_proveedor(?)", id);
    }
    
    @SuppressWarnings("deprecation")
    public Proveedor obtenerProveedorPorId(int id) {
        String query = "SELECT * FROM PROVEEDOR_TB WHERE ID_PROVEEDOR = ?";
        return jdbc.queryForObject(query, new Object[]{id}, (resultSet, rowNum) -> {
            Proveedor proveedor = new Proveedor();
            proveedor.setId_Provedor(resultSet.getInt("ID_PROVEEDOR"));
            proveedor.setNombre(resultSet.getString("NOMBRE_EMPRESA"));
            proveedor.setContacto(resultSet.getString("PERSONA_CONTACTO"));
            proveedor.setTipo_Proveedor(resultSet.getString("TIPO_PROVEEDOR"));
            proveedor.setId_Direccion(resultSet.getInt("ID_DIRECCION"));
            return proveedor;
        });
    }
    
    public void actualizarProveedor( Proveedor proveedor)
    {
        System.out.println("este es mi nombreeeeeee:    "+proveedor.getId_Provedor());
        String query = "CALL PROVEEDOR_PKG.actualizar_proveedor(?,?,?,?,?)";
        jdbc.update(query,
        proveedor.getId_Provedor(),
        proveedor.getNombre(),
        proveedor.getContacto(),
        proveedor.getTipo_Proveedor(),
        proveedor.getId_Direccion());
    }
}
