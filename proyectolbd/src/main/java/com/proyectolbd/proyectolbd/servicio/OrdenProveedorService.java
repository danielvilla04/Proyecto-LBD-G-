package com.proyectolbd.proyectolbd.servicio;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Service;

import com.proyectolbd.proyectolbd.modelo.OrdenProveedor;
import com.proyectolbd.proyectolbd.modelo.ProductoTb;
import com.proyectolbd.proyectolbd.modelo.ProveedorTb;
import com.proyectolbd.proyectolbd.modelo.Venta;
import com.proyectolbd.proyectolbd.modelo.ventas.DetalleOrdenProveedor;

@Service
public class OrdenProveedorService {

    @Autowired
    private JdbcTemplate jdbc;
    /* , List<DetalleOrdenProveedor> detalles */

    public void crearOrden(OrdenProveedor ordenProveedor) {

        int idOrden;

        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbc)
                .withCatalogName("PEDIDOS_PROVEEDORES_PKG")
                .withFunctionName("INSERTAR_ORDEN_PROVEEDOR")
                .declareParameters(
                        new SqlParameter("p_id_proveedor", Types.NUMERIC),
                        new SqlParameter("p_detalles", Types.VARCHAR),
                        new SqlParameter("p_fecha_pedido", Types.DATE),
                        new SqlParameter("p_fecha_estimada_fin", Types.DATE),
                        new SqlOutParameter("RESULT", Types.NUMERIC));

        Map<String, Object> inParams = new HashMap<>();
        inParams.put("p_id_proveedor", ordenProveedor.getIdProveedor());
        inParams.put("p_detalles", ordenProveedor.getDetalles());
        inParams.put("p_fecha_pedido", ordenProveedor.getFechaPedido());
        inParams.put("p_fecha_estimada_fin", ordenProveedor.getFechaEstimadaFin());

        Map<String, Object> result = jdbcCall.execute(inParams);

        BigDecimal resultadoBD = (BigDecimal) result.get("RESULT");
        idOrden = resultadoBD.intValue();
        /*
         * jdbc.
         * update("CALL PEDIDOS_PROVEEDORES_PKG.INSERTAR_ORDEN_PROVEEDOR(?, ?, ?, ?)",
         * ordenProveedor.getIdProveedor(),
         * ordenProveedor.getDetalles(),
         * ordenProveedor.getFechaPedido(),
         * ordenProveedor.getFechaEstimadaFin());
         */

        List<DetalleOrdenProveedor> detalles = ordenProveedor.getDetalles_prov();
        for (DetalleOrdenProveedor detalle : detalles) {
            if(detalle.getCantidad()!=null && detalle.getIdProducto()!=null)
            {
                jdbc.update("CALL PEDIDOS_PROVEEDORES_PKG.INSERTAR_DETALLE_ORDEN_PROVEEDOR(?, ?, ?)",
                    idOrden,
                    detalle.getIdProducto(),
                    detalle.getCantidad());
            }

        }
    }


    public List<ProductoTb> obtenerProductos() {
        String sql = "select * from v_producto_id"; 
        return jdbc.query(sql, (rs, rowNum) -> {
            ProductoTb producto = new ProductoTb();
            producto.setIdProducto(rs.getInt("id_producto"));
            producto.setNombreProducto(rs.getString("nombre_producto"));
            return producto;
        });
    }

    public List<ProveedorTb> obtenerProveedores() {
        String sql = "select * from v_proveedor_id"; 
        return jdbc.query(sql, (rs, rowNum) -> {
            ProveedorTb proveedor = new ProveedorTb();
            proveedor.setIdProveedor(rs.getInt("id_proveedor"));
            proveedor.setNombreEmpresa(rs.getString("nombre_empresa"));
            return proveedor;
        });
    }

    public List<Map<String, Object>> obtenerPedidos() {
        String sql = "SELECT * FROM v_pedidos_proveedores "; //
        return jdbc.queryForList(sql);
    }

    public List<OrdenProveedor> obtenerOrdenesPorRango(java.sql.Date fechaInicio, java.sql.Date fechaFin) {
        List<OrdenProveedor> ordenes = new ArrayList<>();
        try {
            // Establecer la conexión con la base de datos Oracle
            Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "DANIEL_PROJECT", "12345");

            // Llamar al procedimiento almacenado
            CallableStatement cs = conn.prepareCall("{call PEDIDOS_PROVEEDORES_PKG.obtener_ordenes_por_rango(?, ?, ?)}");
            cs.setDate(1, fechaInicio);
            cs.setDate(2, fechaFin);
            cs.registerOutParameter(3, oracle.jdbc.OracleTypes.CURSOR); // Tipo específico para Oracle
            cs.execute();

            // Obtener el cursor
            ResultSet rs = (ResultSet) cs.getObject(3);

            // Iterar sobre los resultados y crear objetos Venta
            while (rs.next()) {
                OrdenProveedor orden = new OrdenProveedor();
                orden.setIdOrdenProveedor(rs.getInt("id_orden_proveedor"));
                orden.setDetalles(rs.getString("detalles"));
                orden.setFechaPedido(rs.getDate("fecha_pedido"));
                orden.setFechaEstimadaFin(rs.getDate("fecha_estimada_fin"));

                ordenes.add(orden);
            }


            // Cerrar los recursos
            rs.close();
            cs.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ordenes;
    }
}

