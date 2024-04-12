package com.proyectolbd.proyectolbd.repositorio;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.proyectolbd.proyectolbd.modelo.ventas.MetodoPago;



@Repository
public class RepositoryMetodoPago {
    

    @Autowired
    private JdbcTemplate jdbc;

   

     

   
}
