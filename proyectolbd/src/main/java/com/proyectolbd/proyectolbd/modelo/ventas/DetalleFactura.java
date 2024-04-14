package com.proyectolbd.proyectolbd.modelo.ventas;

public class DetalleFactura {
    

    private int idDetalleFactura;
    private int idFactura;
    private int idProducto;
    private int cantidadProductos;
    private int totalFila;


    public DetalleFactura() {
    }
 

    public DetalleFactura(int idDetalleFactura, int idFactura, int idProducto, int cantidadProductos,
            int totalFila) {
        this.idDetalleFactura = idDetalleFactura;
        this.idFactura = idFactura;
        this.idProducto = idProducto;
        this.cantidadProductos = cantidadProductos;
        this.totalFila = totalFila;
    }


    public int getIdDetalleFactura() {
        return idDetalleFactura;
    }


    public void setIdDetalleFactura(int idDetalleFactura) {
        this.idDetalleFactura = idDetalleFactura;
    }


    public int getIdFactura() {
        return idFactura;
    }


    public void setIdFactura(int idFactura) {
        this.idFactura = idFactura;
    }


    public int getIdProducto() {
        return idProducto;
    }


    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }


    public int getCantidadProductos() {
        return cantidadProductos;
    }


    public void setCantidadProductos(int cantidadProductos) {
        this.cantidadProductos = cantidadProductos;
    }


    public int getTotalFila() {
        return totalFila;
    }


    public void setTotalFila(int totalFila) {
        this.totalFila = totalFila;
    }

    
    


}
