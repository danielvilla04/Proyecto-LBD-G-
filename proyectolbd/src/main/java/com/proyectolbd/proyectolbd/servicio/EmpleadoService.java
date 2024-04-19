package com.proyectolbd.proyectolbd.servicio;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import javax.swing.tree.RowMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.proyectolbd.proyectolbd.modelo.Empleado;
import com.proyectolbd.proyectolbd.modelo.Puesto;

@Service
public class EmpleadoService {

    @Autowired
    private JdbcTemplate jdbc;
    public void insertarEmpleado(String nombre, String pApellido, String sApellido, String cedula, int  edad,String genero, String direccion, Date fecha, int puesto, String telefono, String email)
    {
        jdbc.update("CALL EMPLEADOS_PKG.INSERTAR_EMPLEADO( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)", nombre,  pApellido,  sApellido, cedula,   edad, genero,  direccion,  fecha,  puesto,  telefono,  email);
    }

    public List<Empleado> obtenerEmpleados() {
        String sql = "select * from v_empleados_lista";
        return jdbc.query(sql, (rs, rowNum) -> {
            Empleado empleado = new Empleado();
            empleado.setIdEmpleado(rs.getInt("ID_EMPLEADO"));
            empleado.setNombreCompleto(rs.getString("NOMBRE_COMPLETO"));
            empleado.setNumeroCedula(rs.getString("NUMERO_CEDULA"));
            empleado.setEdad(rs.getInt("EDAD"));
            empleado.setGenero(rs.getString("GENERO"));
            empleado.setDetalleDireccion(rs.getString("DETALLE_DIRECCION"));
            empleado.setFechaContratacion(rs.getDate("FECHA_CONTRATACION"));
            empleado.setNombrePuesto(rs.getString("NOMBRE_PUESTO"));
            empleado.setSalario(rs.getInt("SALARIO"));
            return empleado;
        });
    }

    public List<Map<String, Object>> obtenerVistaEmpleados() {
        String sql = "SELECT * FROM v_empleados_lista";
        return jdbc.queryForList(sql);
    }

    public void eliminarEmpleado(int id) {
        System.out.println("este es el id service:"+id);
        jdbc.update("CALL EMPLEADOS_PKG.eliminar_empleado_con_facturas(?)", id);
    }

    public List<Puesto> obtenerPuestos() {
        String sql = "select * from v_puestos_id"; 
        return jdbc.query(sql, (rs, rowNum) -> {
            Puesto proveedor = new Puesto();
            proveedor.setIdPuesto(rs.getInt("id_puesto"));
            proveedor.setNombrePuesto(rs.getString("nombre_puesto"));
            return proveedor;
        });
    }



    @SuppressWarnings("deprecation")
    public Empleado obtenerEmpleadoPorId(int id) {
        String query = "SELECT * FROM EMPLEADO_tb WHERE ID_EMPLEADO = ?";
        return jdbc.queryForObject(query, new Object[]{id}, (resultSet, rowNum) -> {
            Empleado empleado = new Empleado();
            empleado.setIdEmpleado(resultSet.getInt("ID_EMPLEADO"));
            empleado.setNombreEmpleado(resultSet.getString("NOMBRE_EMPLEADO"));
            empleado.setPrimerApellido(resultSet.getString("PRIMER_APELLIDO"));
            empleado.setSegundoApellido(resultSet.getString("SEGUNDO_APELLIDO"));
            empleado.setNumeroCedula(resultSet.getString("NUMERO_CEDULA"));
            empleado.setEdad(resultSet.getInt("EDAD"));
            empleado.setGenero(resultSet.getString("GENERO"));
            empleado.setFechaContratacion(resultSet.getDate("FECHA_CONTRATACION"));
            empleado.setIdPuesto(resultSet.getInt("ID_PUESTO"));
            empleado.setTelefono(resultSet.getString("TELEFONO"));
            empleado.setEmail(resultSet.getString("EMAIL"));
            empleado.setDetalleDireccion(resultSet.getString("DIRECCION"));

            // Setear el resto de los atributos del empleado
            return empleado;
        });
    }

    public void actualizarEmpleado( Empleado empleado)
    {
        System.out.println("este es mi nombreeeeeee:    "+empleado.getIdEmpleado());
        String query = "CALL EMPLEADOS_PKG.ACTUALIZAR_EMPLEADO(?,?,?,?,?,?,?,?,?,?,?,?)";
        jdbc.update(query,
        empleado.getIdEmpleado(),
        empleado.getNombreEmpleado(),
        empleado.getPrimerApellido(),
        empleado.getSegundoApellido(),
        empleado.getNumeroCedula(),
        empleado.getEdad(),
        empleado.getGenero(),
        empleado.getDetalleDireccion(),
        empleado.getFechaContratacion(),
        empleado.getIdPuesto(),
        empleado.getTelefono(),
        empleado.getEmail());

    }

}
