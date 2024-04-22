package com.proyectolbd.proyectolbd.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.proyectolbd.proyectolbd.modelo.ProveedorTb;
import com.proyectolbd.proyectolbd.servicio.ProveedorService;

@Controller
public class ProveedorController {

    @Autowired
    ProveedorService proveedor;

    @PostMapping("/proveedor_eliminar")
    public String eliminarProveedor(@RequestParam("id_proveedor") int id) {
        
        proveedor.eliminarProveedor(id);
        return "/pages/Proveedor/proveedor_lista";
    }

    @GetMapping("/proveedor_listar/{id}")
    public String obtenerUsuario(@PathVariable("id") int id, Model model) {
        System.out.println("mi id es:"+id);
        ProveedorTb proveedorM = proveedor.obtenerProveedorPorId(id);
        model.addAttribute("proveedor", proveedorM);
        return "pages/Proveedor/proveedor_actualizar"; // Nombre de la página HTML para el formulario de actualización
    }
    
}
