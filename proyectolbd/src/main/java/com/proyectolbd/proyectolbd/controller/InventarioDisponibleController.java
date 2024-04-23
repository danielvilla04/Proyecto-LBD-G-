/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.proyectolbd.proyectolbd.controller;

import com.proyectolbd.proyectolbd.servicio.InventarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;
import java.util.Map;

import com.proyectolbd.proyectolbd.servicio.InventarioDisponibleService;

import org.springframework.ui.Model;

import com.proyectolbd.proyectolbd.servicio.InventarioDisponibleService;

@Controller
public class InventarioDisponibleController {

    @Autowired
    private InventarioDisponibleService consultaInventarioservicio;

    @GetMapping("/inventario/disponible")
    public String mostrarInventarioDisponible(Model model) {
        // Consultar la vista v_inventario_disponible
        List<Map<String, Object>> inventarioDisponible = consultaInventarioservicio.obtenerInventarioDisponible();
        
        // Agregar el resultado al modelo
        model.addAttribute("inventarioDisponible", inventarioDisponible);
        
        // Devolver el nombre de la vista para mostrar el resultado
        return "v_inventario_disponible";
    }
}
