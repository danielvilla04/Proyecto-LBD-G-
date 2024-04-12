package com.proyectolbd.proyectolbd.servicio;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.proyectolbd.proyectolbd.modelo.ventas.MetodoPago;
import com.proyectolbd.proyectolbd.repositorio.RepositoryMetodoPago;



@Service
public class ServiceMetodoPago {
    
    @Autowired
    private RepositoryMetodoPago RepMetodoPago;
    @Autowired
    private JdbcTemplate jdbc;

    public void insertarMetodoPago(String nombre, String detalles){
        jdbc.update("CALL INSERTAR_METODOPAGO( ?, ?)", nombre,detalles);
    }

    public List<Map<String, Object>> obtenerVistaMetodosPago() {
        String sql = "SELECT * FROM vista_metodos_pago"; 
        return jdbc.queryForList(sql);
    }
    
    public void eliminarMetodoPago(int id) {
        jdbc.update("CALL ELIMINAR_METODOPAGO(?)", id);
    }

    public List<MetodoPago> obtenerMetodosPago() {
    String sql = "SELECT * FROM vista_metodos_pago"; 
    return jdbc.query(sql, (rs, rowNum) -> {
        MetodoPago metodoPago = new MetodoPago();
        metodoPago.setIdMetodoPago(rs.getInt("id_metodo"));
        metodoPago.setNombre(rs.getString("nombre"));
        return metodoPago;
    });
}
}
