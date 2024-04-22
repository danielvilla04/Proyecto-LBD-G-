package com.proyectolbd.proyectolbd.modelo;

import java.sql.Date;

public class Venta {
    
    private int idVenta;
    private int idFactura;
    private Date fechaVenta;
    private double totalVenta;


    public Venta() {
    }


    public Venta(int idVenta, int idFactura, Date fechaVenta, double totalVenta) {
        this.idVenta = idVenta;
        this.idFactura = idFactura;
        this.fechaVenta = fechaVenta;
        this.totalVenta = totalVenta;
    }


    public int getIdVenta() {
        return idVenta;
    }


    public void setIdVenta(int idVenta) {
        this.idVenta = idVenta;
    }


    public int getIdFactura() {
        return idFactura;
    }


    public void setIdFactura(int idFactura) {
        this.idFactura = idFactura;
    }


    public Date getFechaVenta() {
        return fechaVenta;
    }


    public void setFechaVenta(Date fechaVenta) {
        this.fechaVenta = fechaVenta;
    }


    public double getTotalVenta() {
        return totalVenta;
    }


    public void setTotalVenta(double d) {
        this.totalVenta = d;
    }

    
    

}
