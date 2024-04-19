package com.proyectolbd.proyectolbd.modelo;

import java.sql.Date;

public class EmpleadoTb {
    
    private int idEmpleado;
    

    private String nombreEmpleado;
    

    private String primerApellido;

    private String segundoApellido;
    

    private int numeroCedula;
    
   
    private Integer edad;
    

    private String genero;
    

    private int idDireccion;
    

    private Date fechaContratacion;
    

    private int idPuesto;


    public EmpleadoTb() {
    }


    public EmpleadoTb(int idEmpleado, String nombreEmpleado, String primerApellido, String segundoApellido,
            int numeroCedula, Integer edad, String genero, int idDireccion, Date fechaContratacion, int idPuesto) {
        this.idEmpleado = idEmpleado;
        this.nombreEmpleado = nombreEmpleado;
        this.primerApellido = primerApellido;
        this.segundoApellido = segundoApellido;
        this.numeroCedula = numeroCedula;
        this.edad = edad;
        this.genero = genero;
        this.idDireccion = idDireccion;
        this.fechaContratacion = fechaContratacion;
        this.idPuesto = idPuesto;
    }


    public int getIdEmpleado() {
        return idEmpleado;
    }


    public void setIdEmpleado(int idEmpleado) {
        this.idEmpleado = idEmpleado;
    }


    public String getNombreEmpleado() {
        return nombreEmpleado;
    }


    public void setNombreEmpleado(String nombreEmpleado) {
        this.nombreEmpleado = nombreEmpleado;
    }


    public String getPrimerApellido() {
        return primerApellido;
    }


    public void setPrimerApellido(String primerApellido) {
        this.primerApellido = primerApellido;
    }


    public String getSegundoApellido() {
        return segundoApellido;
    }


    public void setSegundoApellido(String segundoApellido) {
        this.segundoApellido = segundoApellido;
    }


    public int getNumeroCedula() {
        return numeroCedula;
    }


    public void setNumeroCedula(int numeroCedula) {
        this.numeroCedula = numeroCedula;
    }


    public Integer getEdad() {
        return edad;
    }


    public void setEdad(Integer edad) {
        this.edad = edad;
    }


    public String getGenero() {
        return genero;
    }


    public void setGenero(String genero) {
        this.genero = genero;
    }


    public int getIdDireccion() {
        return idDireccion;
    }


    public void setIdDireccion(int idDireccion) {
        this.idDireccion = idDireccion;
    }


    public Date getFechaContratacion() {
        return fechaContratacion;
    }


    public void setFechaContratacion(Date fechaContratacion) {
        this.fechaContratacion = fechaContratacion;
    }


    public int getIdPuesto() {
        return idPuesto;
    }


    public void setIdPuesto(int idPuesto) {
        this.idPuesto = idPuesto;
    }
    

    
    // Constructor, getters y setters

    
}