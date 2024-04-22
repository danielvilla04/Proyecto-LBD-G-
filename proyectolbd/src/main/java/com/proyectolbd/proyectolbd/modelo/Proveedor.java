package com.proyectolbd.proyectolbd.modelo;
public class Proveedor {
    
    private int id_Provedor;
    private String nombre;
    private String Contacto;
    private String tipo_Proveedor;
    private int id_Direccion;

    public Proveedor() {
    }

    public Proveedor(int id_Provedor, String nombre, String Contacto, String tipo_Proveedor, int id_Direccion) {
        this.id_Provedor = id_Provedor;
        this.nombre = nombre;
        this.Contacto = Contacto;
        this.tipo_Proveedor = tipo_Proveedor;
        this.id_Direccion = id_Direccion;
    }

    public int getId_Provedor() {
        return id_Provedor;
    }

    public void setId_Provedor(int id_Provedor) {
        this.id_Provedor = id_Provedor;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getContacto() {
        return Contacto;
    }

    public void setContacto(String Contacto) {
        this.Contacto = Contacto;
    }

    public String getTipo_Proveedor() {
        return tipo_Proveedor;
    }

    public void setTipo_Proveedor(String tipo_Proveedor) {
        this.tipo_Proveedor = tipo_Proveedor;
    }

    public int getId_Direccion() {
        return id_Direccion;
    }

    public void setId_Direccion(int id_Direccion) {
        this.id_Direccion = id_Direccion;
    }

    @Override
    public String toString() {
        return "Proveedor{" + "id_Provedor=" + id_Provedor 
                + ", nombre=" + nombre 
                + ", Contacto=" + Contacto 
                + ", tipo_Proveedor=" + tipo_Proveedor 
                + ", id_Direccion=" + id_Direccion + '}';
    }
            
}
