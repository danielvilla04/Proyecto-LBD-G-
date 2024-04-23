package com.proyectolbd.proyectolbd.servicio;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class InventarioService {

    @Autowired
    private JdbcTemplate jdbc;

    public void agregarInventario(int idProducto, int cantidadProducto, Date fechaActualizacion, int disponible) {
        jdbc.update("CALL inventario_pkg.agregar_inventario(DEFAULT, ?, ?, ?, ?)", idProducto, cantidadProducto, fechaActualizacion, disponible);
    }

    public void actualizarInventario(int idInventario, int cantidadProducto, Date fechaActualizacion, int disponible) {
        jdbc.update("CALL inventario_pkg.actualizar_inventario(?, ?, ?, ?)", idInventario, cantidadProducto, fechaActualizacion, disponible);
    }

    public void eliminarInventario(int idInventario) {
        jdbc.update("CALL inventario_pkg.eliminar_inventario(?)", idInventario);
    }

    public List<Map<String, Object>> obtenerInventarioPorProducto() {
        return jdbc.queryForList("CALL inventario_pkg.obtener_inventario_por_producto");
    }

    public List<Map<String, Object>> obtenerProductosSinInventario() {
        return jdbc.queryForList("CALL inventario_pkg.obtener_productos_sin_inventario");
    }

    public int obtenerCantidadTotalProducto(int idProducto) {
        return jdbc.queryForObject("CALL inventario_pkg.OBTENER_CANTIDAD_TOTAL_PRODUCTO(?)", Integer.class, idProducto);
    }

    public int actualizarDisponibilidadProducto(int idProducto) {
        return jdbc.queryForObject("CALL inventario_pkg.ACTUALIZAR_DISPONIBILIDAD_PRODUCTO(?)", Integer.class, idProducto);
    }

    public double calcularValorTotalInventario() {
        return jdbc.queryForObject("CALL inventario_pkg.calcular_valor_total_inventario", Double.class);
    }

    public List<Map<String, Object>> obtenerVistaInventario() {
        String sql = "SELECT * FROM v_inventario_lista";
        return jdbc.queryForList(sql);
    }
    
}
