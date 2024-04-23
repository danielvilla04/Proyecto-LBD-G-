package com.proyectolbd.proyectolbd.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.proyectolbd.proyectolbd.modelo.inventario.Producto;
import com.proyectolbd.proyectolbd.servicio.ProductoTbService;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
@RequestMapping("/productos")
public class ProductoController {

    @Autowired
    private ProductoTbService productoService;

    @GetMapping("/listar_productos")
    @ResponseBody
    public List<Map<String, Object>> obtenerProductosDisponibles() {
        return productoService.obtenerProductosDisponibles();
    }

    @GetMapping("/listar_productos_agotados")
    @ResponseBody
    public List<Map<String, Object>> obtenerProductosAgotados() {
        return productoService.obtenerProductosAgotados();
    }

    @PostMapping("/insertar_producto")
    public String insertarProducto(@RequestParam("idProducto") int idProducto,
                                   @RequestParam("nombreProducto") String nombreProducto,
                                   @RequestParam("descripcionProducto") String descripcionProducto,
                                   @RequestParam("precio") double precio,
                                   @RequestParam("idCategoria") int idCategoria) {

        productoService.agregarProducto(idProducto, nombreProducto, descripcionProducto, precio, idCategoria);
        return "redirect:/productos";
    }

    @PostMapping("/eliminar_producto")
    public String eliminarProducto(@RequestParam("idProducto") int idProducto) {
        productoService.eliminarProducto(idProducto);
        return "redirect:/productos";
    }


    @GetMapping("/listar/{id}")
    public String obtenerProducto(@PathVariable("id") int id, Model model) {
        // Lógica para obtener un producto por su ID y enviarlo al modelo
        return "/pages/Producto/producto_actualizar"; // Nombre de la página HTML para el formulario de actualización
    }

    @PostMapping("/actualizar_producto")
    public String actualizarProducto(@ModelAttribute ProductoTbService producto) {
        // Lógica para actualizar el producto
        return "redirect:/productos"; // Redirigir a la página principal después de la actualización
    }
}
