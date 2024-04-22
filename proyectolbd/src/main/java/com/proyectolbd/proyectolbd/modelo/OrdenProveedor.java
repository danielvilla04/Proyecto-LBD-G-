package com.proyectolbd.proyectolbd.modelo;
import java.util.*;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import com.proyectolbd.proyectolbd.modelo.ventas.DetalleOrdenProveedor;

public class OrdenProveedor {
    

    private int idOrdenProveedor;
    

    private int idProveedor;
    
    private String detalles;

    private Date fechaPedido;
    
    private Date fechaEstimadaFin;

    private List<DetalleOrdenProveedor> detalles_prov ;

    public OrdenProveedor() {
    }

    public OrdenProveedor(int idOrdenProveedor, int idProveedor, String detalles, Date fechaPedido,
            Date fechaEstimadaFin, List<DetalleOrdenProveedor> detalles_prov) {
        this.idOrdenProveedor = idOrdenProveedor;
        this.idProveedor = idProveedor;
        this.detalles = detalles;
        this.fechaPedido = fechaPedido;
        this.fechaEstimadaFin = fechaEstimadaFin;
        this.detalles_prov = detalles_prov;
    }

    public int getIdOrdenProveedor() {
        return idOrdenProveedor;
    }

    public void setIdOrdenProveedor(int idOrdenProveedor) {
        this.idOrdenProveedor = idOrdenProveedor;
    }

    public int getIdProveedor() {
        return idProveedor;
    }

    public void setIdProveedor(int idProveedor) {
        this.idProveedor = idProveedor;
    }

    public String getDetalles() {
        return detalles;
    }

    public void setDetalles(String detalles) {
        this.detalles = detalles;
    }

    public Date getFechaPedido() {
        return fechaPedido;
    }

    public void setFechaPedido(Date fechaPedido) {
        this.fechaPedido = fechaPedido;
    }

    public Date getFechaEstimadaFin() {
        return fechaEstimadaFin;
    }

    public void setFechaEstimadaFin(Date fechaEstimadaFin) {
        this.fechaEstimadaFin = fechaEstimadaFin;
    }

    public List<DetalleOrdenProveedor> getDetalles_prov() {
        return detalles_prov;
    }

    public void setDetalles_prov(List<DetalleOrdenProveedor> detalles_prov) {
        this.detalles_prov = detalles_prov;
    }

    

    
    

    
}
