package com.proyectolbd.proyectolbd.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.sql.Date;
import java.util.ArrayList;
import java.util.LinkedList;

import java.util.Map;

import com.proyectolbd.proyectolbd.modelo.Empleado;
import com.proyectolbd.proyectolbd.modelo.Factura;
import com.proyectolbd.proyectolbd.modelo.FechasForm;
import com.proyectolbd.proyectolbd.modelo.OrdenProveedor;
import com.proyectolbd.proyectolbd.modelo.PedidoCliente;
import com.proyectolbd.proyectolbd.modelo.Usuario;
import com.proyectolbd.proyectolbd.modelo.Venta;
import com.proyectolbd.proyectolbd.modelo.ventas.DetalleFactura;
import com.proyectolbd.proyectolbd.modelo.ventas.DetalleOrdenProveedor;
import com.proyectolbd.proyectolbd.servicio.EmpleadoService;
import com.proyectolbd.proyectolbd.servicio.FacturaService;
import com.proyectolbd.proyectolbd.servicio.PedidoClienteService;
import com.proyectolbd.proyectolbd.servicio.ProveedorService;
import com.proyectolbd.proyectolbd.servicio.ServiceMetodoPago;
import com.proyectolbd.proyectolbd.servicio.UsuarioService;
import com.proyectolbd.proyectolbd.servicio.VentaService;

@Controller

public class MenuController {
   @Autowired
   private ServiceMetodoPago metodoPago;
   @Autowired
   private EmpleadoService empleado;

   @Autowired
   private UsuarioService usuario;

   @Autowired
   private FacturaService facturaService;

   @Autowired
   private PedidoClienteService pedidosClientesService;

   @Autowired
   private ProveedorService proveedorService;

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

   @GetMapping("/facturas")
   public String mostrarFacturas(Model model) {
      List<Map<String, Object>> facturas = facturaService.obtenerVistaFacturas();
      model.addAttribute("facturas", facturas);
      return "/pages/ventas/facturas";
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
   public String MostrarReportes(Model model) {
      model.addAttribute("fechasForm", new FechasForm());
      return "/pages/ventas/reportes_ventas";
   }

   // Links de Inventario

   // Links de Clientes

   @GetMapping("/pedidos_gestion")
   public String mostrarPedidosClientes(Model model) {
      PedidoCliente pedido = new PedidoCliente();
      model.addAttribute("pedidoCliente", pedido);
      return "/pages/PedidosClientes/pedidos_gestion";
   }

   @GetMapping("/pedidos_gestion_lista")
   public String mostrarPedidosClientesLista(Model model) {
      List<Map<String, Object>> pedidos = pedidosClientesService.obtenerVistaPedidos();
      model.addAttribute("pedidosClientes", pedidos);
      return "/pages/PedidosClientes/pedidos_gestion_lista";
   }

   //// Links de Proveedores

   @GetMapping("/proveedores")
   public String mostrarProveedores() {

      return "/pages/Proveedor/proveedor";
   }

   @GetMapping("/proveedores_lista")
   public String mostrarProveedoresLista(Model model) {
      List<Map<String, Object>> proveedores = proveedorService.obtenerVistaProveedores();
      model.addAttribute("proveedores", proveedores);
      return "/pages/Proveedor/proveedor_lista";
   }

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

   @GetMapping("/reportes_pedidos")
   public String MostrarReportesPedidos(Model model) {
      model.addAttribute("fechasForm", new FechasForm());
      return "/pages/PedidosProveedores/reportes_pedidos";
   }

   //// Links de Empleados
   @GetMapping("/empleados")
   public String mostrarEmpleados(Model model) {
      List<Map<String, Object>> empleados = empleado.obtenerVistaEmpleados();
      model.addAttribute("empleados", empleados);
      return "/pages/Empleado/empleados";
   }

   @GetMapping("/usuarios")
   public String register(Model model) {

      Usuario usuario = new Usuario();
      model.addAttribute("usuario", usuario);
      return "/pages/Usuario/registrar";
   }

   @GetMapping("/usuarios_administracion")
   public String mostrarUsuarios(Model model) {
      List<Map<String, Object>> usuarios = usuario.obtenerVistaUsuarios();
      model.addAttribute("usuarios", usuarios);
      return "/pages/Usuario/usuarios_administracion";
   }

}
