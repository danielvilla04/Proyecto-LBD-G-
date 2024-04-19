package com.proyectolbd.proyectolbd.modelo.ventas;

public class DetalleOrdenProveedor {

    private Long idDetalleOrden;
    private Long idOrdenProveedor;
    private Long idProducto;
    private Integer cantidad;


    public DetalleOrdenProveedor() {
    }


    public DetalleOrdenProveedor(Long idDetalleOrden, Long idOrdenProveedor, Long idProducto, Integer cantidad) {
        this.idDetalleOrden = idDetalleOrden;
        this.idOrdenProveedor = idOrdenProveedor;
        this.idProducto = idProducto;
        this.cantidad = cantidad;
    }


    public Long getIdDetalleOrden() {
        return idDetalleOrden;
    }


    public void setIdDetalleOrden(Long idDetalleOrden) {
        this.idDetalleOrden = idDetalleOrden;
    }


    public Long getIdOrdenProveedor() {
        return idOrdenProveedor;
    }


    public void setIdOrdenProveedor(Long idOrdenProveedor) {
        this.idOrdenProveedor = idOrdenProveedor;
    }


    public Long getIdProducto() {
        return idProducto;
    }


    public void setIdProducto(Long idProducto) {
        this.idProducto = idProducto;
    }


    public Integer getCantidad() {
        return cantidad;
    }


    public void setCantidad(Integer cantidad) {
        this.cantidad = cantidad;
    }

    

    // Getters and setters


    

    
}