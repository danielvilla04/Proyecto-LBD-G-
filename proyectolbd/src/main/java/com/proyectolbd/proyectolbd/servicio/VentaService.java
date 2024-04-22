package com.proyectolbd.proyectolbd.servicio;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.proyectolbd.proyectolbd.modelo.Venta;

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



    public List<Venta> obtenerVentasPorRango(java.sql.Date fechaInicio, java.sql.Date fechaFin) {
        List<Venta> ventas = new ArrayList<>();
        try {
            // Establecer la conexión con la base de datos Oracle
            Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "DANIEL_PROJECT", "12345");

            // Llamar al procedimiento almacenado
            CallableStatement cs = conn.prepareCall("{call ventas_pkg.obtener_ventas_por_rango(?, ?, ?)}");
            cs.setDate(1, fechaInicio);
            cs.setDate(2, fechaFin);
            cs.registerOutParameter(3, oracle.jdbc.OracleTypes.CURSOR); // Tipo específico para Oracle
            cs.execute();

            // Obtener el cursor
            ResultSet rs = (ResultSet) cs.getObject(3);

            // Iterar sobre los resultados y crear objetos Venta
            while (rs.next()) {
                Venta venta = new Venta();
                venta.setIdVenta(rs.getInt("id_venta"));
                venta.setFechaVenta(rs.getDate("fecha_venta"));
                venta.setTotalVenta(rs.getDouble("total_venta"));
                ventas.add(venta);
            }


            // Cerrar los recursos
            rs.close();
            cs.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ventas;
    }

}

