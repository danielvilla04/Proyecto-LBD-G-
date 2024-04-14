package com.proyectolbd.proyectolbd.servicio;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;





@Service
public class FacturaService {
    
    @Autowired
    private JdbcTemplate jdbc;

    public void insertarFactura(int idCliente, int idEmpleado, int idMetodoPago, String fechaFacturacion, String estado , String detalles, int total){
        String sql = "CALL INSERTAR_FACTURA(?,?,?,?,?,?,?)";
        jdbc.update(sql, idCliente,idEmpleado,idMetodoPago,detalles, estado, fechaFacturacion, total);
    } 

 
}
