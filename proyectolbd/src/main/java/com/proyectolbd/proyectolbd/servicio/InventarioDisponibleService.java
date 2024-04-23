/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.proyectolbd.proyectolbd.servicio;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class InventarioDisponibleService {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Map<String, Object>> obtenerInventarioDisponible() {
        // Consultar la vista v_inventario_disponible y devolver los resultados
        String sql = "SELECT * FROM v_inventario_disponible";
        return jdbcTemplate.queryForList(sql);
    }
}
