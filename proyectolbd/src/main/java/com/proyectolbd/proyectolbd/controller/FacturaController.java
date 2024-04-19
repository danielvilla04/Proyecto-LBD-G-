package com.proyectolbd.proyectolbd.controller;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.proyectolbd.proyectolbd.modelo.ClienteTb;
import com.proyectolbd.proyectolbd.modelo.EmpleadoTb;
import com.proyectolbd.proyectolbd.modelo.Factura;
import com.proyectolbd.proyectolbd.modelo.ventas.DetalleFactura;
import com.proyectolbd.proyectolbd.servicio.DetalleFacturaService;
import com.proyectolbd.proyectolbd.servicio.FacturaService;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
public class FacturaController {

    @Autowired
    private FacturaService facturaService;
    @Autowired
    private DetalleFacturaService detalleFacturaService;

    @PostMapping("/crear_factura")
    public String crearFactura(@ModelAttribute Factura factura) {
       
        facturaService.crearFactua(factura);
        return "redirect:/facturacion";
    }

    @GetMapping("/obtener_clientes")
    @ResponseBody
    public List<ClienteTb> obtenerClientes() {
        return facturaService.obtenerClientes();
    }

    @GetMapping("/obtener_empleados")
    @ResponseBody
    public List<EmpleadoTb> obtenerEmpleados() {
        return facturaService.obtenerEmpleados();
    }

}
