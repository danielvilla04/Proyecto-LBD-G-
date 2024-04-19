package com.proyectolbd.proyectolbd.servicio;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service
public class VentaService {
    

    @Autowired
    private JdbcTemplate jdbc;

    public List<Map<String, Object>> obtenerVentas() {
        String sql = "SELECT * FROM vista_ventas "; //
        return jdbc.queryForList(sql);
    }

    public void eliminarVenta(int idVenta) {
        // Llama al stored procedure para eliminar la venta utilizando el ID proporcionado
        String sql = "CALL ventas_pkg.eliminar_venta(?)"; // Suponiendo que el nombre del stored procedure es eliminar_venta
        jdbc.update(sql, idVenta);
    }

    public void actualizarVentas(){
        String sql = "CALL CREAR_HISTORIAL_VENTAS()";
        jdbc.execute(sql);

    }

}

