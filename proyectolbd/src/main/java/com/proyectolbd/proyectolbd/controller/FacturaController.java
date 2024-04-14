package com.proyectolbd.proyectolbd.controller;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.proyectolbd.proyectolbd.modelo.ventas.DetalleFactura;
import com.proyectolbd.proyectolbd.servicio.DetalleFacturaService;
import com.proyectolbd.proyectolbd.servicio.FacturaService;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;


@Controller
@RestController
public class FacturaController {

    @Autowired
    private FacturaService facturaService;
    @Autowired
    private DetalleFacturaService detalleFacturaService;

    @PostMapping("/crear_factura")
    public String crearFactura(@RequestParam("cliente") int idCliente,
            @RequestParam("empleado") int idEmpleado,
            @RequestParam("metodo") int idMetodoPago,
            @RequestParam("fecha_facturacion") String fechaFacturacion,
            @RequestParam("estado") String estado,
            @RequestParam("detalles") String detalles,
            @RequestParam("total") int total) {
        // Crear un formato para la fecha de entrada
        SimpleDateFormat inputFormatter = new SimpleDateFormat("yyyy-MM-dd");
        // Crear un formato para la fecha de salida en el formato deseado
        // ('DD-MON-YYYY')
        SimpleDateFormat outputFormatter = new SimpleDateFormat("dd-MMM-yyyy");
        Date fecha = null;
        try {
            // Parsear la fecha de entrada
            fecha = inputFormatter.parse(fechaFacturacion);
            // Formatear la fecha al formato deseado
            fechaFacturacion = outputFormatter.format(fecha);
        } catch (ParseException e) {
            e.printStackTrace();
            // Manejar el error de análisis de fecha según sea necesario
        } 

        // Insertar la factura en la base de datos y obtener su ID
        facturaService.insertarFactura(idCliente, idEmpleado, idMetodoPago, fechaFacturacion, estado, detalles,total);




        

        
        return "redirect:/facturacion";
    }

}
