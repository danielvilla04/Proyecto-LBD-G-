package com.proyectolbd.proyectolbd.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.proyectolbd.proyectolbd.modelo.Usuario;
import com.proyectolbd.proyectolbd.servicio.UsuarioService;

@Controller
public class UsuarioController {

    @Autowired UsuarioService userService;

    

    @PostMapping("/usuarios_crear")
    public String crearUsuario(@ModelAttribute Usuario user) {

        userService.crearUsuario(user);

        return "/pages/Usuario/registrar";
    }

    @PostMapping("/usuarios_eliminar")
    public String eliminarEmpleado(@RequestParam("id_usuario") int id) {
        
        userService.eliminarUsuario(id);
        return "redirect:/usuarios_administracion";
    }

    @GetMapping("/usuarios_listar/{id}")
    public String obtenerUsuario(@PathVariable("id") int id, Model model) {
        System.out.println("mi id es:"+id);
        Usuario usuarioM = userService.obtenerUsuarioPorId(id);
        model.addAttribute("usuario", usuarioM);
        return "/pages/Usuario/users_actualizar"; // Nombre de la página HTML para el formulario de actualización
    }


    @PostMapping("/usuario_actualizar")
    public String actualizarUsuario(@ModelAttribute Usuario usuarioM) {
        userService.actualizarUsuario(usuarioM);
        return "redirect:/usuarios_administracion"; // Redirigir a la página principal después de la actualización
    }
}