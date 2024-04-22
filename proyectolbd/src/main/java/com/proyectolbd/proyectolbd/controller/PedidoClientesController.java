package com.proyectolbd.proyectolbd.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import com.proyectolbd.proyectolbd.modelo.PedidoCliente;
import com.proyectolbd.proyectolbd.servicio.PedidoClienteService;

@Controller
public class PedidoClientesController {

    @Autowired
    PedidoClienteService pedidoService;

    @PostMapping("/crear_pedido")
    public String crearPedido(@ModelAttribute PedidoCliente pedido) {

        pedidoService.crearPedido(pedido);
        return "/pages/PedidosClientes/pedidos_gestion";
    }

    @PostMapping("/eliminar_pedido_cliente")
    public String eliminarEmpleado(@RequestParam("id_pedido") int id) {
        
        pedidoService.eliminarPedido(id);
        return "redirect:/pedidos_gestion_lista";
    }

    @GetMapping("/pedidos_listar/{id}")
    public String obtenerUsuario(@PathVariable("id") int id, Model model) {
        System.out.println("mi id es:"+id);
        PedidoCliente pedido = pedidoService.obtenerPedidoPorId(id);
        model.addAttribute("pedidoCliente", pedido);
        return "pages/PedidosClientes/pedidos_actualizar"; // Nombre de la página HTML para el formulario de actualización
    }

    @PostMapping("/actualizar_pedido")
    public String actualizarPedido(@ModelAttribute PedidoCliente pedido) {
        pedidoService.actualizarPedido(pedido);
        return "redirect:/pedidos_gestion_lista"; // Redirigir a la página principal después de la actualización
    }

}
