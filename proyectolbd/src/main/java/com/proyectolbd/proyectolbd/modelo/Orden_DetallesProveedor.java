package com.proyectolbd.proyectolbd.modelo;

import java.util.List;

import com.proyectolbd.proyectolbd.modelo.ventas.DetalleOrdenProveedor;

public class Orden_DetallesProveedor {
    
    private OrdenProveedor ordenProveedor;
    private List<DetalleOrdenProveedor> detalles;

    
    public Orden_DetallesProveedor(OrdenProveedor ordenProveedor, List<DetalleOrdenProveedor> detalles) {
        this.ordenProveedor = ordenProveedor;
        this.detalles = detalles;
    }


    public OrdenProveedor getOrdenProveedor() {
        return ordenProveedor;
    }


    public void setOrdenProveedor(OrdenProveedor ordenProveedor) {
        this.ordenProveedor = ordenProveedor;
    }


    public List<DetalleOrdenProveedor> getDetalles() {
        return detalles;
    }


    public void setDetalles(List<DetalleOrdenProveedor> detalles) {
        this.detalles = detalles;
    }



    


}
