package com.proyectolbd.proyectolbd.servicio;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.proyectolbd.proyectolbd.modelo.ProveedorTb;

@Service
public class ProveedorService {

    @Autowired
    JdbcTemplate jdbc;

    public List<Map<String, Object>> obtenerVistaProveedores() {
        String sql = "SELECT * FROM v_proveedores_lista";
        return jdbc.queryForList(sql);
    }

    public void eliminarProveedor(int id) {
        System.out.println("este es el id service:" + id);
        jdbc.update("CALL PROVEEDOR_PKG.eliminar_proveedor(?)", id);
    }


    @SuppressWarnings("deprecation")
    public ProveedorTb obtenerProveedorPorId(int id) {
        String query = "SELECT * FROM PROVEEDOR_TB WHERE ID_PROVEEDOR = ?";
        return jdbc.queryForObject(query, new Object[] { id }, (resultSet, rowNum) -> {
            ProveedorTb proveedor = new ProveedorTb();
            proveedor.setIdProveedor(resultSet.getInt("ID_PROVEEDOR"));
            proveedor.setNombreEmpresa(resultSet.getString("NOMBRE_EMPRESA"));
            proveedor.setPersonaContacto(resultSet.getString("PERSONA_CONTACTO"));
            proveedor.setDireccion(resultSet.getString("DIRECCION"));
            proveedor.setTipoProveedor(resultSet.getString("TIPO_PROVEEDOR"));


            return proveedor;
        });
    }
    
}
