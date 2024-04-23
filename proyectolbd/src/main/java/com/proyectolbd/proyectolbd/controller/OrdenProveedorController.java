package com.proyectolbd.proyectolbd.controller;

import java.net.http.HttpHeaders;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.proyectolbd.proyectolbd.modelo.FechasForm;
import com.proyectolbd.proyectolbd.modelo.OrdenProveedor;
import com.proyectolbd.proyectolbd.modelo.Orden_DetallesProveedor;
import com.proyectolbd.proyectolbd.modelo.ProductoTb;
import com.proyectolbd.proyectolbd.modelo.ProveedorTb;
import com.proyectolbd.proyectolbd.modelo.ventas.DetalleOrdenProveedor;
import com.proyectolbd.proyectolbd.servicio.OrdenProveedorService;

@Controller
public class OrdenProveedorController {

    @Autowired
    private OrdenProveedorService ordenProveedorService;

    @PostMapping("/crear_orden")
    public String crearFactura(@ModelAttribute OrdenProveedor orden) {
        ordenProveedorService.crearOrden(orden);
        List<DetalleOrdenProveedor> detalles = orden.getDetalles_prov();
        for (DetalleOrdenProveedor detalle : detalles) {
            System.out.println("Cantidad" + detalle.getCantidad());
            System.out.println("Producto" + detalle.getIdProducto());

        }
        // Redirige a la página 'pedidos_proveedor'*/
        return "redirect:/pedido_proveedor";
    }

    @GetMapping("/obtener_productos")
    @ResponseBody
    public List<ProductoTb> obtenerProducto() {
        return ordenProveedorService.obtenerProductos();
    }

    @GetMapping("/obtener_proveedor")
    @ResponseBody
    public List<ProveedorTb> obtenerProveedor() {
        return ordenProveedorService.obtenerProveedores();
    }

    @GetMapping("/pedidos")
    public ResponseEntity<Map<String, Object>> obtenerVentas() {
        List<Map<String, Object>> ventas = ordenProveedorService.obtenerPedidos();
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

    @PostMapping("/obtener_pedidos_reportes")
    public String obtenerPedidosRango(@ModelAttribute FechasForm fechas , Model model ) {
            System.out.println("fdslfsdfjdslfhd"+ fechas.getFechaFin());
           List<OrdenProveedor> ordenes = ordenProveedorService.obtenerOrdenesPorRango(fechas.getFechaInicio(), fechas.getFechaFin());
           model.addAttribute("pedidos", ordenes);
           return "/pages/PedidosProveedores/reportes_pedidos"; // Esto es el nombre de la vista Thymeleaf
    }

}
