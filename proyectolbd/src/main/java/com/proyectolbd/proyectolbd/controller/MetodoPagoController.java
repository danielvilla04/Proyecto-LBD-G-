package com.proyectolbd.proyectolbd.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;


import com.proyectolbd.proyectolbd.servicio.ServiceMetodoPago;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;



@RestController
public class MetodoPagoController {
    
    @Autowired
    private ServiceMetodoPago metodoPago;

    @PostMapping("/insert_metodo_pago")
    public String insertarMetodoPago(@RequestParam("nombreMetodoPago") String nombre,
                                     @RequestParam("detallesMetodoPago") String detalles){

        metodoPago.insertarDatos(nombre, detalles);
        return "Insercion exitosa";
    }
    
}
