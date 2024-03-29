package com.proyectolbd.proyectolbd.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;





@Controller
public class MenuController {

     //Controler para los links del menu
     //Links de ventas
     @GetMapping("/facturacion")
     public String mostrarFacturacion(){return "/pages/ventas/facturacion";}

     @GetMapping("/metodos_pago")
     public String mostrarMetodosPago(){return "/pages/ventas/metodos_pago";}

     @GetMapping ("/historial_ventas")
     public String mostrarVentas(){return "/pages/ventas/historial_ventas";}

     @GetMapping("/reportes_ventas")
     public String MostrarReportes(){return "/pages/ventas/reportes_ventas";}
     

     //Links de Inventario

     //Links de Clientes

     ////Links de Proveedores
     
}
