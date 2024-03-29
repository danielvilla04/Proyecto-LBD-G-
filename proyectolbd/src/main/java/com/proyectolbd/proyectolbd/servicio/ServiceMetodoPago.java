package com.proyectolbd.proyectolbd.servicio;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proyectolbd.proyectolbd.modelo.ventas.MetodoPago;
import com.proyectolbd.proyectolbd.repositorio.RepositoryMetodoPago;



@Service
public class ServiceMetodoPago {
    
    @Autowired
    private RepositoryMetodoPago RepMetodoPago;

    public void insertarDatos(String nombre, String detalles){
        RepMetodoPago.insertarMetodoPago(nombre, detalles);
    }
}
