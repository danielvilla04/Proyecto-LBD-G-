package com.proyectolbd.proyectolbd.modelo.ventas;

public class MetodoPago {
    private int metodoPago;
    private String nombre;
    private int activo;
    private String detalles;


    public int getMetodoPago() {
        return metodoPago;
    }
    public void setMetodoPago(int metodoPago) {
        this.metodoPago = metodoPago;
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
        return "MetodoPago [metodoPago=" + metodoPago + ", nombre=" + nombre + ", activo=" + activo + ", detalles="
                + detalles + "]";
    }

    

    
}
