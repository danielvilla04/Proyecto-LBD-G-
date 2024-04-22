package com.proyectolbd.proyectolbd.servicio;

import java.util.List;
import java.util.Map;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import org.springframework.stereotype.Service;

import com.proyectolbd.proyectolbd.modelo.Usuario;

@Service
public class UsuarioService {

    @Autowired
    JdbcTemplate jdbc;

    public void crearUsuario(Usuario user) {
        String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());

        jdbc.update("CALL USUARIO_PKG.crear_usuario(?, ?, ?, ?)", user.getUsername(), hashedPassword, user.getRole(),
                user.getActivo());
    }

    public List<Map<String, Object>> obtenerVistaUsuarios() {
        String sql = "SELECT * FROM v_usuarios_lista";
        return jdbc.queryForList(sql);
    }

    public void eliminarUsuario(int id) {
        System.out.println("este es el id service:" + id);
        jdbc.update("CALL USUARIO_PKG.eliminar_usuario(?)", id);
    }

    @SuppressWarnings("deprecation")
    public Usuario obtenerUsuarioPorId(int id) {
        String query = "SELECT * FROM USUARIOS WHERE ID_USUARIO = ?";
        return jdbc.queryForObject(query, new Object[] { id }, (resultSet, rowNum) -> {
            Usuario usuario = new Usuario();
            usuario.setUsername(resultSet.getString("USERNAME"));
            // Obtener la contraseña desde la base de datos
            String hashedPassword = resultSet.getString("PASSWORD");
            // Decodificar la contraseña
            String decryptedPassword = BCrypt.checkpw(hashedPassword, BCrypt.gensalt()) ? "Contraseña válida"
                    : "Contraseña inválida";
            // Establecer la contraseña decodificada en el objeto Usuario
            usuario.setPassword(decryptedPassword);
            usuario.setRole(resultSet.getString("ROLE"));
            usuario.setIdUsuario(resultSet.getInt("ID_USUARIO"));

            return usuario;
        });
    }

    public void actualizarUsuario(Usuario user) {
        System.out.println("este es mi nombreeeeeee:    " + user.getIdUsuario());
        String query = "CALL USUARIO_PKG.actualizar_usuario(?,?,?,?, ?)";
        jdbc.update(query,
                user.getIdUsuario(),
                user.getUsername(),
                user.getPassword(),
                user.getRole(),
                user.getActivo());

    }

}
