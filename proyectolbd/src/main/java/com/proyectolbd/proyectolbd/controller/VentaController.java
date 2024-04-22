package com.proyectolbd.proyectolbd.controller;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.proyectolbd.proyectolbd.modelo.FechasForm;
import com.proyectolbd.proyectolbd.modelo.Venta;
import com.proyectolbd.proyectolbd.servicio.VentaService;



@Controller
public class VentaController {

    @Autowired
    VentaService venta;

    @GetMapping("/ventas")
    public ResponseEntity<Map<String, Object>> obtenerVentas() {
        List<Map<String, Object>> ventas = venta.obtenerVentas();
        for (Map<String, Object> venta : ventas) {
            System.out.println("Venta:");
            for (Map.Entry<String, Object> entry : venta.entrySet()) {
                System.out.println(entry.getKey() + ": " + entry.getValue());
            }
            System.out.println("-------------");
        }
        Map<String, Object> response = new HashMap<>();
        response.put("data", ventas); // Coloca los datos dentro de una clave "data"
        return ResponseEntity.ok(response);
    }

    @PostMapping("/eliminar_venta/{idVenta}")
    public void eliminarVenta(@PathVariable int idVenta) {
        System.out.println("Id de la venta:"+idVenta);
        // Aquí puedes llamar al servicio para eliminar la venta utilizando el ID proporcionado
        venta.eliminarVenta(idVenta);
        // Puedes utilizar los datos del cuerpo de la solicitud si es necesario
    
    }

    @PostMapping("/actualizar_ventas")
    public String actualizarVentas() {
        venta.actualizarVentas();
        return "pages/Ventas/historial_ventas";
    }

    
    @PostMapping("/obtener_ventas_rango")
    public String obtenerVentasRango(@ModelAttribute FechasForm fechas , Model model ) {

           List<Venta> ventas = venta.obtenerVentasPorRango(fechas.getFechaInicio(), fechas.getFechaFin());
           model.addAttribute("ventas", ventas);
           return "pages/Ventas/reportes_ventas"; // Esto es el nombre de la vista Thymeleaf
    }
}
