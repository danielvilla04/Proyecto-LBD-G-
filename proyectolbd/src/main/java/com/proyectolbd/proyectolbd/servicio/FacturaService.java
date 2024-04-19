package com.proyectolbd.proyectolbd.servicio;

import java.math.BigDecimal;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Service;

import com.proyectolbd.proyectolbd.modelo.ClienteTb;
import com.proyectolbd.proyectolbd.modelo.EmpleadoTb;
import com.proyectolbd.proyectolbd.modelo.Factura;
import com.proyectolbd.proyectolbd.modelo.ventas.DetalleFactura;





@Service
public class FacturaService {
    
    @Autowired
    private JdbcTemplate jdbc;

    public void insertarFactura(int idCliente, int idEmpleado, int idMetodoPago, String fechaFacturacion, String estado , String detalles, int total){
        String sql = "CALL INSERTAR_FACTURA(?,?,?,?,?,?,?)";
        jdbc.update(sql, idCliente,idEmpleado,idMetodoPago,detalles, estado, fechaFacturacion, total);
    } 
    public void crearFactua(Factura factura) {

        int idFactura;

        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbc)
                .withCatalogName("FACTURACION")
                .withFunctionName("INSERTAR_FACTURA")
                .declareParameters(
                        new SqlParameter("id_cliente", Types.NUMERIC),
                        new SqlParameter("id_empleado", Types.NUMERIC),
                        new SqlParameter("id_metodo", Types.NUMERIC),
                        new SqlParameter("detalles", Types.VARCHAR),
                        new SqlParameter("estado", Types.VARCHAR),
                        new SqlParameter("fecha_facturacion", Types.DATE),
                        new SqlParameter("total", Types.NUMERIC),
                        new SqlOutParameter("RESULT", Types.NUMERIC));

        Map<String, Object> inParams = new HashMap<>();
        inParams.put("id_cliente", factura.getIdCliente());
        inParams.put("id_empleado", factura.getIdEmpleado());
        inParams.put("id_metodo", factura.getIdMetodoPago());
        inParams.put("detalles", factura.getDetalles());
        inParams.put("estado", factura.getEstado());
        inParams.put("fecha_facturacion", factura.getFechaFacturacion());
        inParams.put("total", factura.getTotal());


        Map<String, Object> result = jdbcCall.execute(inParams);

        BigDecimal resultadoBD = (BigDecimal) result.get("RESULT");
        idFactura = resultadoBD.intValue();


        List<DetalleFactura> detalles = factura.getDetallesFac();
        for (DetalleFactura detalle : detalles) {
            if(detalle.getCantidadProductos() != 0 && detalle.getIdProducto() != 0)
            {
                jdbc.update("CALL facturacion.INSERTAR_DETALLE_FACTURA(?, ?, ?, ?)",
                    idFactura,
                    detalle.getIdProducto(),
                    detalle.getCantidadProductos(),
                    detalle.getTotalFila());
            }

        }
    }

    public List<ClienteTb> obtenerClientes() {
        String sql = "select * from v_cliente_id"; 
        return jdbc.query(sql, (rs, rowNum) -> {
            ClienteTb cliente = new ClienteTb();
            cliente.setIdCliente(rs.getInt("id_cliente"));
            cliente.setNombreCliente(rs.getString("nombre_cliente"));
            return cliente;
        });
    }

    public List<EmpleadoTb> obtenerEmpleados() {
        String sql = "select * from v_empleado_id"; 
        return jdbc.query(sql, (rs, rowNum) -> {
            EmpleadoTb empleado = new EmpleadoTb();
            empleado.setIdEmpleado(rs.getInt("id_empleado"));
            empleado.setNombreEmpleado(rs.getString("nombre_empleado"));
            return empleado;
        });
    }

 
}
