package com.proyectolbd.proyectolbd.modelo;

public class Puesto {
    

    private int idPuesto;
    

    private String nombrePuesto;


    public Puesto() {
    }


    public Puesto(int idPuesto, String nombrePuesto) {
        this.idPuesto = idPuesto;
        this.nombrePuesto = nombrePuesto;
    }


    public int getIdPuesto() {
        return idPuesto;
    }


    public void setIdPuesto(int idPuesto) {
        this.idPuesto = idPuesto;
    }


    public String getNombrePuesto() {
        return nombrePuesto;
    }


    public void setNombrePuesto(String nombrePuesto) {
        this.nombrePuesto = nombrePuesto;
    }
    

    


    
    
}
