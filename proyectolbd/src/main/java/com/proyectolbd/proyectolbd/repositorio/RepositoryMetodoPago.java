package com.proyectolbd.proyectolbd.repositorio;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class RepositoryMetodoPago {
    

    @Autowired
    private JdbcTemplate jdbc;

    public void insertarMetodoPago(String nombre, String detalles){
        jdbc.update("CALL INSERTAR_METODOPAGO( ?, ?)", nombre,detalles);
    }
}
