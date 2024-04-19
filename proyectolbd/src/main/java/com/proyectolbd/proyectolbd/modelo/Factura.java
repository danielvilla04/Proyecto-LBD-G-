package com.proyectolbd.proyectolbd.modelo;

import java.sql.Date;
import java.util.List;

import com.proyectolbd.proyectolbd.modelo.ventas.DetalleFactura;

public class Factura {

    private int idFactura;
    private int idCliente;
    private int idEmpleado;
    private int idMetodoPago;
    private String detalles;
    private String estado;
    private Date fechaFacturacion;
    private double  total;

    private List<DetalleFactura> detallesFac;

    
    public Factura() {
    }


    public Factura(int idFactura, int idCliente, int idEmpleado, int idMetodoPago, String detalles, String estado,
            Date fechaFacturacion, double  total,List<DetalleFactura> detallesFac) {
        this.idFactura = idFactura;
        this.idCliente = idCliente;
        this.idEmpleado = idEmpleado;
        this.idMetodoPago = idMetodoPago;
        this.detalles = detalles;
        this.estado = estado;
        this.fechaFacturacion = fechaFacturacion;
        this.total = total;
        this.detallesFac = detallesFac;
    }


    public int getIdFactura() {
        return idFactura;
    }


    public void setIdFactura(int idFactura) {
        this.idFactura = idFactura;
    }


    public int getIdCliente() {
        return idCliente;
    }


    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }


    public int getIdEmpleado() {
        return idEmpleado;
    }


    public void setIdEmpleado(int idEmpleado) {
        this.idEmpleado = idEmpleado;
    }


    public int getIdMetodoPago() {
        return idMetodoPago;
    }


    public void setIdMetodoPago(int idMetodoPago) {
        this.idMetodoPago = idMetodoPago;
    }


    public String getDetalles() {
        return detalles;
    }


    public void setDetalles(String detalles) {
        this.detalles = detalles;
    }


    public String getEstado() {
        return estado;
    }


    public void setEstado(String estado) {
        this.estado = estado;
    }


    public Date getFechaFacturacion() {
        return fechaFacturacion;
    }


    public void setFechaFacturacion(Date fechaFacturacion) {
        this.fechaFacturacion = fechaFacturacion;
    }


    public double  getTotal() {
        return total;
    }


    public void setTotal(double  total) {
        this.total = total;
    }


    public List<DetalleFactura> getDetallesFac() {
        return detallesFac;
    }


    public void setDetallesFac(List<DetalleFactura> detallesFac) {
        this.detallesFac = detallesFac;
    }
    



    


    




}
