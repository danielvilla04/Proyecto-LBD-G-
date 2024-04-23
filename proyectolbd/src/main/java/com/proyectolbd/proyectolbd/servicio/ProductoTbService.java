package com.proyectolbd.proyectolbd.servicio;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.proyectolbd.proyectolbd.modelo.Empleado;
import com.proyectolbd.proyectolbd.modelo.Puesto;

@Service
public class ProductoTbService {

    @Autowired
    private JdbcTemplate jdbc;

    public void agregarProducto(int idProducto, String nombreProducto, String descripcionProducto, double precio, int idCategoria) {
        jdbc.update("CALL producto_pkg.agregar_producto(?, ?, ?, ?, ?)", idProducto, nombreProducto, descripcionProducto, precio, idCategoria);
    }

    public void actualizarProducto(int idProducto, String nombreProducto, String descripcionProducto, double precio, int idCategoria) {
        jdbc.update("CALL producto_pkg.actualizar_producto(?, ?, ?, ?, ?)", idProducto, nombreProducto, descripcionProducto, precio, idCategoria);
    }

    public void eliminarProducto(int idProducto) {
        jdbc.update("CALL producto_pkg.eliminar_producto(?)", idProducto);
    }

    public List<Map<String, Object>> obtenerProductosDisponibles() {
        return jdbc.queryForList("CALL producto_pkg.obtener_productos_disponibles");
    }

    public List<Map<String, Object>> obtenerProductosAgotados() {
        return jdbc.queryForList("CALL producto_pkg.obtener_productos_agotados");
    }

    public int obtenerCantidadProductosPorCategoria(int idCategoria) {
        return jdbc.queryForObject("CALL producto_pkg.OBTENER_CANTIDAD_PRODUCTOS_POR_CATEGORIA(?)", Integer.class, idCategoria);
    }

    public List<Map<String, Object>> obtenerVistaProductos() {
        String sql = "SELECT * FROM v_productos_lista";
        return jdbc.queryForList(sql);
    }

}
