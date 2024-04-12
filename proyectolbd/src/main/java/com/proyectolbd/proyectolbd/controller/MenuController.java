package com.proyectolbd.proyectolbd.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import java.util.List;
import java.util.Map;
import com.proyectolbd.proyectolbd.servicio.ServiceMetodoPago;





@Controller

public class MenuController {
     @Autowired
     private ServiceMetodoPago metodoPago;

     //Controler para los links del menu
     //Links de ventas
     @GetMapping("/facturacion")
     public String mostrarFacturacion(){return "/pages/ventas/facturacion";}

     @GetMapping ("/historial_ventas")
     public String mostrarVentas(){return "/pages/ventas/historial_ventas";}

     @GetMapping ("/metodos_pago")
     public String mostrarMetodos(Model model){
     List<Map<String, Object>> metodos = metodoPago.obtenerVistaMetodosPago();
        model.addAttribute("datosMetodos", metodos);return "/pages/ventas/metodosPago";}

     @GetMapping("/reportes_ventas")
     public String MostrarReportes(){return "/pages/ventas/reportes_ventas";}
     

     //Links de Inventario

     //Links de Clientes

     ////Links de Proveedores
     
}
