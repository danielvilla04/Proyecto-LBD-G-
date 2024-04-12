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
        int id = 6; 
        String sql = "INSERT INTO FACTURA_TB (ID_FACTURA,ID_CLIENTE,ID_EMPLEADO, ID_METODO_PAGO,detalles,FECHA_FACTURACION,ESTADO, TOTAL) VALUES (?,?,?,?,?,?,?,?)";
        jdbc.update(sql, id,idCliente,idEmpleado,idMetodoPago,detalles, fechaFacturacion, estado ,total);

    }

 
}
