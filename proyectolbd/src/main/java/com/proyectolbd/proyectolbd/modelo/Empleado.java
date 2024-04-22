package com.proyectolbd.proyectolbd.modelo;

import java.sql.Date;

public class Empleado {
 
    


    private int idEmpleado;
    private String nombreCompleto;
    private String nombreEmpleado;
    private String primerApellido;
    private String segundoApellido;
    private String numeroCedula;
    private int edad;
    private String genero;
    private String telefono;
    private String email;
    private String detalleDireccion;
    private int idDireccion;
    private Date fechaContratacion;
    private String nombrePuesto;
    private int idPuesto;
    private int salario;
    private String direccion;

    public Empleado() {
    }

    


    



    public String getTelefono() {
        return telefono;
    }








    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }








    public String getEmail() {
        return email;
    }








    public void setEmail(String email) {
        this.email = email;
    }








    public Empleado(int idEmpleado, String nombreCompleto, String nombreEmpleado, String primerApellido,
            String segundoApellido, String numeroCedula, int edad, String genero, String telefono, String email,
            String detalleDireccion, int idDireccion, Date fechaContratacion, String nombrePuesto, int idPuesto,
            int salario,String direccion) {
        this.idEmpleado = idEmpleado;
        this.nombreCompleto = nombreCompleto;
        this.nombreEmpleado = nombreEmpleado;
        this.primerApellido = primerApellido;
        this.segundoApellido = segundoApellido;
        this.numeroCedula = numeroCedula;
        this.edad = edad;
        this.genero = genero;
        this.telefono = telefono;
        this.email = email;
        this.detalleDireccion = detalleDireccion;
        this.idDireccion = idDireccion;
        this.fechaContratacion = fechaContratacion;
        this.nombrePuesto = nombrePuesto;
        this.idPuesto = idPuesto;
        this.salario = salario;
        this.direccion = direccion;
    }








    public String getDireccion() {
        return direccion;
    }








    public void setDireccion(String direccion) {
        this.direccion = direccion;
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

    public String getNumeroCedula() {
        return numeroCedula;
    }

    public void setNumeroCedula(String numeroCedula) {
        this.numeroCedula = numeroCedula;
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




    public String getNombreCompleto() {
        return nombreCompleto;
    }




    public void setNombreCompleto(String nombreCompleto) {
        this.nombreCompleto = nombreCompleto;
    }




    public String getNombrePuesto() {
        return nombrePuesto;
    }




    public void setNombrePuesto(String nombrePuesto) {
        this.nombrePuesto = nombrePuesto;
    }




    public int getSalario() {
        return salario;
    }




    public void setSalario(int salario) {
        this.salario = salario;
    }




    public String getDetalleDireccion() {
        return detalleDireccion;
    }




    public void setDetalleDireccion(String detalleDireccion) {
        this.detalleDireccion = detalleDireccion;
    }

    
    
    

}
