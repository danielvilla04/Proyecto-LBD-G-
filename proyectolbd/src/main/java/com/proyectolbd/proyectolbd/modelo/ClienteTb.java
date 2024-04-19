package com.proyectolbd.proyectolbd.modelo;

public class ClienteTb {
    

    private int idCliente;
    

    private String nombreCliente;
    

    private String primerApellido;
    
   
    private String segundoApellido;
    
 
    private Long numeroCedula;
    

    private Integer edad;
    

    private String genero;
    
  
    private Long idDireccion;


    public ClienteTb() {
    }


    public ClienteTb(int idCliente, String nombreCliente, String primerApellido, String segundoApellido,
            Long numeroCedula, Integer edad, String genero, Long idDireccion) {
        this.idCliente = idCliente;
        this.nombreCliente = nombreCliente;
        this.primerApellido = primerApellido;
        this.segundoApellido = segundoApellido;
        this.numeroCedula = numeroCedula;
        this.edad = edad;
        this.genero = genero;
        this.idDireccion = idDireccion;
    }


    public int getIdCliente() {
        return idCliente;
    }


    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }


    public String getNombreCliente() {
        return nombreCliente;
    }


    public void setNombreCliente(String nombreCliente) {
        this.nombreCliente = nombreCliente;
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


    public Long getNumeroCedula() {
        return numeroCedula;
    }


    public void setNumeroCedula(Long numeroCedula) {
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


    public Long getIdDireccion() {
        return idDireccion;
    }


    public void setIdDireccion(Long idDireccion) {
        this.idDireccion = idDireccion;
    }

    
    
    // Constructor, getters y setters
    
}
