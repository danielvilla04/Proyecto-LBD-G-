package com.proyectolbd.proyectolbd.modelo;

public class PedidoCliente {
 
    private int idPedidoCliente;

    private int idFactura;

    private String direccion;

    private int idCliente;

    private String estadoPedido;

    // Constructor vacío (obligatorio para JPA)
    public PedidoCliente() {
    }

    public PedidoCliente(int idPedidoCliente, int idFactura, String direccion, int idCliente, String estadoPedido) {
        this.idPedidoCliente = idPedidoCliente;
        this.idFactura = idFactura;
        this.direccion = direccion;
        this.idCliente = idCliente;
        this.estadoPedido = estadoPedido;
    }

    public int getIdPedidoCliente() {
        return idPedidoCliente;
    }

    public void setIdPedidoCliente(int idPedidoCliente) {
        this.idPedidoCliente = idPedidoCliente;
    }

    public int getIdFactura() {
        return idFactura;
    }

    public void setIdFactura(int idFactura) {
        this.idFactura = idFactura;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public String getEstadoPedido() {
        return estadoPedido;
    }

    public void setEstadoPedido(String estadoPedido) {
        this.estadoPedido = estadoPedido;
    }


}
