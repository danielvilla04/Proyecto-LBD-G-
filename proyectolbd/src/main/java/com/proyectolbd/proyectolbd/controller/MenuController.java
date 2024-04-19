package com.proyectolbd.proyectolbd.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.ArrayList;
import java.util.LinkedList;

import java.util.Map;

import com.proyectolbd.proyectolbd.modelo.Empleado;
import com.proyectolbd.proyectolbd.modelo.Factura;
import com.proyectolbd.proyectolbd.modelo.OrdenProveedor;
import com.proyectolbd.proyectolbd.modelo.ventas.DetalleFactura;
import com.proyectolbd.proyectolbd.modelo.ventas.DetalleOrdenProveedor;
import com.proyectolbd.proyectolbd.servicio.EmpleadoService;
import com.proyectolbd.proyectolbd.servicio.ServiceMetodoPago;
import com.proyectolbd.proyectolbd.servicio.VentaService;

@Controller

public class MenuController {
   @Autowired
   private ServiceMetodoPago metodoPago;
   @Autowired
   private EmpleadoService empleado;

   @Autowired
   private VentaService venta;

   // Controler para los links del menu
   // Links de ventas
   @GetMapping("/facturacion")
   public String mostrarFacturacion(Model model) {
      Factura factura = new Factura();

      // Llenar la lista de objetos con 10 objetos vacíos
      List<DetalleFactura> listaDeObjetos = new ArrayList<>();
      for (int i = 0; i < 10; i++) {
          listaDeObjetos.add(new DetalleFactura());
      }
      
      factura.setDetallesFac(listaDeObjetos);
      model.addAttribute("factura", factura);

      return "/pages/ventas/facturacion";
   }

   @GetMapping("/historial_ventas")

   public String mostrarVentas() {
  
      return "/pages/ventas/historial_ventas";
   }

   @GetMapping("/metodos_pago")
   public String mostrarMetodos(Model model) {
      List<Map<String, Object>> metodos = metodoPago.obtenerVistaMetodosPago();
      model.addAttribute("datosMetodos", metodos);
      return "/pages/ventas/metodosPago";
   }

   @GetMapping("/reportes_ventas")
   public String MostrarReportes() {
      return "/pages/ventas/reportes_ventas";
   }

   // Links de Inventario

   // Links de Clientes

   //// Links de Proveedores
   /*
    * @GetMapping("/pedido_proveedor")
    * public String mostrarPedidosProveedores(){return
    * "/pages/PedidosProveedores/pedido_proveedor";}
    */

   @GetMapping("/pedido_proveedor")
   public String mostrarFormulario(Model model) {
      OrdenProveedor orden = new OrdenProveedor();

      // Llenar la lista de objetos con 10 objetos vacíos
      List<DetalleOrdenProveedor> listaDeObjetos = new ArrayList<>();
      for (int i = 0; i < 10; i++) {
          listaDeObjetos.add(new DetalleOrdenProveedor());
      }
      
      orden.setDetalles_prov(listaDeObjetos);
      model.addAttribute("orden", orden);


      return "/pages/PedidosProveedores/pedido_proveedor";
   }

   @GetMapping("/pedido_proveedor_lista")

   public String mostrarPedidosProveedor() {
  
      return "/pages/PedidosProveedores/pedidos_proveedores_lista";
   }

     //// Links de Empleados
     @GetMapping("/empleados")
     public String mostrarEmpleados(Model model) {
        List<Map<String, Object>> empleados = empleado.obtenerVistaEmpleados();
        model.addAttribute("empleados", empleados);
        return "/pages/Empleado/empleados";
     }


}
