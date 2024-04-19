package com.proyectolbd.proyectolbd.modelo;

public class ProveedorTb {


    private int idProveedor;

  
    private String nombreEmpresa;

  
    private String personaContacto;


    private String tipoProveedor;

    private int direccion;

    

    // Constructor, getters y setters
public ProveedorTb() {
    }



public ProveedorTb(int idProveedor, String nombreEmpresa, String personaContacto, String tipoProveedor, int direccion) {
    this.idProveedor = idProveedor;
    this.nombreEmpresa = nombreEmpresa;
    this.personaContacto = personaContacto;
    this.tipoProveedor = tipoProveedor;
    this.direccion = direccion;
}



public int getIdProveedor() {
    return idProveedor;
}



public void setIdProveedor(int idProveedor) {
    this.idProveedor = idProveedor;
}



public String getNombreEmpresa() {
    return nombreEmpresa;
}



public void setNombreEmpresa(String nombreEmpresa) {
    this.nombreEmpresa = nombreEmpresa;
}



public String getPersonaContacto() {
    return personaContacto;
}



public void setPersonaContacto(String personaContacto) {
    this.personaContacto = personaContacto;
}



public String getTipoProveedor() {
    return tipoProveedor;
}



public void setTipoProveedor(String tipoProveedor) {
    this.tipoProveedor = tipoProveedor;
}



public int getDireccion() {
    return direccion;
}



public void setDireccion(int direccion) {
    this.direccion = direccion;
}

    

    
}