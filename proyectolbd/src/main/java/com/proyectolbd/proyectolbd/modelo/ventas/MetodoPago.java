package com.proyectolbd.proyectolbd.modelo.ventas;



public class MetodoPago {
    private int idMetodoPago;
    private String nombre;
    private int activo;
    private String detalles;
    
    public MetodoPago(){

    }


    public MetodoPago(int idMetodoPago, String nombre, int activo, String detalles) {
        this.idMetodoPago = idMetodoPago;
        this.nombre = nombre;
        this.activo = activo;
        this.detalles = detalles;
    }
  
    public int getIdMetodoPago() {
        return idMetodoPago;
    }
    public void setIdMetodoPago(int idMetodoPago) {
        this.idMetodoPago = idMetodoPago;
    }

 
    public String getNombre() {
        return nombre;
    }
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    public int getActivo() {
        return activo;
    }
    public void setActivo(int activo) {
        this.activo = activo;
    }
    public String getDetalles() {
        return detalles;
    }
    public void setDetalles(String detalles) {
        this.detalles = detalles;
    }
    
    @Override
    public String toString() {
        return "MetodoPago [idMetodoPago=" + idMetodoPago + ", nombre=" + nombre + ", activo=" + activo + ", detalles="
                + detalles + "]";
    }

    

    
}
