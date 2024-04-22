/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.proyectolbd.proyectolbd.servicio;

import com.proyectolbd.proyectolbd.modelo.Cliente;
import com.proyectolbd.proyectolbd.modelo.Empleado;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

/**
 *
 * @author Saul
 */
@Service
public class ClientesService {
    @Autowired
    private JdbcTemplate jdbc;
    
    public void insertarCliente(int id_cliente, String nombre, String primer_Apellido, String segundo_Apellido, int cedula, int edad, String genero, int id_direccion) {
        jdbc.update("CALL INSERTAR_CLIENTE(?, ?, ?, ?, ?, ?, ?, ?)", id_cliente, nombre, primer_Apellido, segundo_Apellido, cedula, edad, genero, id_direccion);
    }
    
    public List<Cliente> obtenerClientes(){
        String sql = "select * from VISTA_CLIENTES";
         return jdbc.query(sql, (rs, rowNum) -> {
            Cliente clientes = new Cliente();
            clientes.setId_cliente(rs.getInt("ID_CLIENTE"));
            clientes.setNombre(rs.getString("NOMBRE_CLIENTE"));
            clientes.setPrimer_Apellido(rs.getString("PRIMER_APELLIDO"));
            clientes.setSegundo_Apellido(rs.getString("SEGUNDO_APELLIDO"));
            clientes.setCedula(rs.getInt("NUMERO_CEDULA"));
            clientes.setEdad(rs.getInt("EDAD"));
            clientes.setGenero(rs.getString("GENERO"));
            clientes.setId_direccion(rs.getInt("ID_DIRECCION"));
            return clientes;
        });
    }
    
    public void eliminarCliente(int id_Cliente) {
        jdbc.update("CALL ELIMINAR_CLIENTE(?)", id_Cliente);
    }
    
    public Cliente obtenerCliente(String id){
        String query = "SELECT * FROM VISTA_CLIENTES WHERE ID_CLIENTE = ?";
        
           try {
             return jdbc.queryForObject(query, new Object[]{id}, (resultSet, rowNum) -> {
            Cliente clientes = new Cliente();
            clientes.setId_cliente(resultSet.getInt("ID_CLIENTE"));
            clientes.setNombre(resultSet.getString("NOMBRE_CLIENTE"));
            clientes.setPrimer_Apellido(resultSet.getString("PRIMER_APELLIDO"));
            clientes.setSegundo_Apellido(resultSet.getString("SEGUNDO_APELLIDO"));
            clientes.setCedula(resultSet.getInt("NUMERO_CEDULA"));
            clientes.setEdad(resultSet.getInt("EDAD"));
            clientes.setGenero(resultSet.getString("GENERO"));
            clientes.setId_direccion(resultSet.getInt("ID_DIRECCION"));
            return clientes;
        });
        } catch (EmptyResultDataAccessException e) {
            // Manejar el caso en el que no se encontró ningún cliente con el ID proporcionado
            return null;
        } catch (Exception e) {
            // Manejar cualquier otro error que pueda ocurrir al recuperar el cliente
            e.printStackTrace(); // Opcional: imprimir el stack trace para depuración
            return null;
        }
    }
    
    public void actualizar(int idCliente, String nombre_cliente, String primer_apellido, String segundo_apellido, int numero_cedula, int edad, String genero, int id_direccion)
    {
        System.out.println("id cliente:    "+ idCliente);
        String query = "CALL ACTUALIZAR_CLIENTE(?, ?, ?, ?, ?, ?, ?, ?)";
        jdbc.update(query,
        idCliente,
        nombre_cliente,
        primer_apellido,
        segundo_apellido,
        numero_cedula,
        edad,
        genero,
        id_direccion);
    }
}
