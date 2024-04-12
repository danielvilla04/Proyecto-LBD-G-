package com.proyectolbd.proyectolbd.servicio;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;





@Service
public class DetalleFacturaService {
    
    @Autowired
    private JdbcTemplate jdbc;

    public void insertarDetalleFactura(int idDetalleFactura ,int idFactura, int idProducto, int cantidadProducto, int totalFila){
        
        jdbc.update("CALL INSERTAR_DETALLE_FACTURA( ?, ?, ?, ?, ? )",idDetalleFactura, idFactura, idProducto,cantidadProducto,totalFila);
    }

 
}
