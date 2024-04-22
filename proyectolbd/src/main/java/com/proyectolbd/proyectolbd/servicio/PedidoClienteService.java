package com.proyectolbd.proyectolbd.servicio;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.proyectolbd.proyectolbd.modelo.PedidoCliente;

@Service
public class PedidoClienteService {
    
    @Autowired
    JdbcTemplate jdbc;


    public void crearPedido(PedidoCliente pedido) {
        jdbc.update("CALL PEDIDO_CLIENTE_PKG.INSERTAR_PEDIDO_CLIENTE(?, ?, ?, ?)", 
        pedido.getIdFactura(), 
        pedido.getDireccion(), 
        pedido.getIdCliente(), 
        pedido.getEstadoPedido());
    }


    public List<Map<String, Object>> obtenerVistaPedidos() {
        System.out.println("al parecer si llega aqui");
        String sql = "SELECT * FROM v_pedidos_empleados_lista";
        return jdbc.queryForList(sql);
    }

    public void eliminarPedido(int id) {
        System.out.println("este es el id service:" + id);
        jdbc.update("CALL PEDIDO_CLIENTE_PKG.ELIMINAR_PEDIDO_CLIENTE(?)", id);
    }

    @SuppressWarnings("deprecation")
    public PedidoCliente obtenerPedidoPorId(int id) {
        String query = "SELECT * FROM PEDIDO_CLIENTE_TB WHERE ID_PEDIDO_CLIENTE = ?";
        return jdbc.queryForObject(query, new Object[] { id }, (resultSet, rowNum) -> {
            PedidoCliente pedido = new PedidoCliente();
            pedido.setIdPedidoCliente(resultSet.getInt("ID_PEDIDO_CLIENTE"));
            pedido.setIdFactura(resultSet.getInt("ID_FACTURA"));
            pedido.setIdCliente(resultSet.getInt("ID_CLIENTE"));
            pedido.setDireccion(resultSet.getString("DIRECCION"));
            pedido.setEstadoPedido(resultSet.getString("ESTADO_PEDIDO"));

            return pedido;
        });
    }

    public void actualizarPedido(PedidoCliente pedido) {
        System.out.println("este es mi nombreeeeeee:    " + pedido.getIdPedidoCliente());
        String query = "CALL PEDIDO_CLIENTE_PKG.ACTUALIZAR_PEDIDO_CLIENTE(?,?,?)";
        jdbc.update(query,
                pedido.getIdPedidoCliente(),
                pedido.getDireccion(),
                pedido.getEstadoPedido());

    }
}
