package com.proyectolbd.proyectolbd.controller;

import com.proyectolbd.proyectolbd.servicio.InventarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class InventarioController {

    @Autowired
    private InventarioService inventarioService;

    @GetMapping("/inventario/agregar")
    public String mostrarFormularioAgregar(Model model) {
        // Aquí podrías agregar lógica para cargar datos adicionales necesarios en el formulario
        return "formulario_agregar_inventario"; // Nombre de la página HTML para el formulario de agregar inventario
    }

    @PostMapping("/inventario/agregar")
    public String agregarInventario(/* Aquí puedes agregar parámetros necesarios desde el formulario */) {
        // Aquí podrías llamar al servicio para agregar el inventario utilizando los parámetros recibidos
        return "redirect:/inventario/listar"; // Redirigir a la página de listado de inventario
    }

    @GetMapping("/inventario/listar")
    public String listarInventario(Model model) {
        // Aquí podrías llamar al servicio para obtener la lista de inventario y pasarla al modelo
        return "lista_inventario"; // Nombre de la página HTML para mostrar la lista de inventario
    }

    @GetMapping("/inventario/{id}/editar")
    public String mostrarFormularioEditar(@PathVariable("id") int id, Model model) {
        // Aquí podrías llamar al servicio para obtener los datos del inventario con el ID especificado y pasarlos al modelo
        return "formulario_editar_inventario"; // Nombre de la página HTML para el formulario de editar inventario
    }

    @PostMapping("/inventario/{id}/editar")
    public String editarInventario(/* Aquí puedes agregar parámetros necesarios desde el formulario */) {
        // Aquí podrías llamar al servicio para actualizar el inventario utilizando los parámetros recibidos
        return "redirect:/inventario/listar"; // Redirigir a la página de listado de inventario
    }

    @PostMapping("/inventario/{id}/eliminar")
    public String eliminarInventario(@PathVariable("id") int id) {
        // Aquí podrías llamar al servicio para eliminar el inventario con el ID especificado
        return "redirect:/inventario/listar"; // Redirigir a la página de listado de inventario
    }
}
