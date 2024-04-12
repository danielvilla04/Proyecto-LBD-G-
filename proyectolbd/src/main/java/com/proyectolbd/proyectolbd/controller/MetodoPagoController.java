package com.proyectolbd.proyectolbd.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RestController;

import com.proyectolbd.proyectolbd.modelo.ventas.MetodoPago;
import com.proyectolbd.proyectolbd.servicio.ServiceMetodoPago;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.List;
import java.util.Map;

@Controller
@RestController
public class MetodoPagoController {

    @Autowired
    private ServiceMetodoPago metodoPago;

    /*@GetMapping("/metodos_pago")
    public String listarMetodosPago(Model model) {
        /*List<Map<String, Object>> metodos = metodoPago.obtenerVistaMetodosPago();
        model.addAttribute("datosMetodos", metodos);
        System.out.println("Datos de métodos obtenidos: " + metodos);
        return "pages/Ventas/metodosPago";
    }*/
    


    @PostMapping("/insert_metodo_pago")
    public String insertarMetodoPago(@RequestParam("nombreMetodoPago") String nombre,
            @RequestParam("detallesMetodoPago") String detalles) {

        metodoPago.insertarMetodoPago(nombre, detalles);
        return "redirect:/metodos_pago";
    }

   
    @PostMapping("/eliminar_metodo_pago")
    public String eliminarMetodoPago(@RequestParam("id_metodo") int id) {
        metodoPago.eliminarMetodoPago(id);
        return "redirect:/metodos_pago";
    }

    @GetMapping("/obtener_metodos_pago")
    public List<MetodoPago> obtenerMetodosPago() {
       return  metodoPago.obtenerMetodosPago();
    }
    

}
