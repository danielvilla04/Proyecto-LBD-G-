/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.proyectolbd.proyectolbd.modelo;

/**
 *
 * @author Saul
 */

public class Cliente {
    
    private int id_cliente;
    private String nombre;
    private String primer_Apellido;
    private String segundo_Apellido;
    private int cedula;
    private int edad;
    private String genero;
    private int id_direccion;

    public Cliente() {
    }

    public Cliente(int id_cliente, String nombre, String primer_Apellido, String segundo_Apellido, int cedula, int edad, String genero, int id_direccion) {
        this.id_cliente = id_cliente;
        this.nombre = nombre;
        this.primer_Apellido = primer_Apellido;
        this.segundo_Apellido = segundo_Apellido;
        this.cedula = cedula;
        this.edad = edad;
        this.genero = genero;
        this.id_direccion = id_direccion;
    }

    public int getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(int id_cliente) {
        this.id_cliente = id_cliente;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getPrimer_Apellido() {
        return primer_Apellido;
    }

    public void setPrimer_Apellido(String primer_Apellido) {
        this.primer_Apellido = primer_Apellido;
    }

    public String getSegundo_Apellido() {
        return segundo_Apellido;
    }

    public void setSegundo_Apellido(String segundo_Apellido) {
        this.segundo_Apellido = segundo_Apellido;
    }

    public int getCedula() {
        return cedula;
    }

    public void setCedula(int cedula) {
        this.cedula = cedula;
    }

    public int getEdad() {
        return edad;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public int getId_direccion() {
        return id_direccion;
    }

    public void setId_direccion(int id_direccion) {
        this.id_direccion = id_direccion;
    }

    @Override
    public String toString() {
        return "Clientes{" + "id_cliente=" + id_cliente + 
                ", nombre=" + nombre + 
                ", primer_Apellido=" + primer_Apellido + 
                ", segundo_Apellido=" + segundo_Apellido + 
                ", cedula=" + cedula + 
                ", edad=" + edad + 
                ", genero=" + genero + 
                ", id_direccion=" + id_direccion + '}';
    }
    


}
