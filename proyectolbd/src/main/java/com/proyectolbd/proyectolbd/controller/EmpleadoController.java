package com.proyectolbd.proyectolbd.controller;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.proyectolbd.proyectolbd.modelo.Empleado;
import com.proyectolbd.proyectolbd.modelo.Puesto;
import com.proyectolbd.proyectolbd.servicio.EmpleadoService;

@Controller
@RequestMapping("/empleados")
public class EmpleadoController {
    
    @Autowired
    private EmpleadoService empleado;

    @GetMapping("/listar_empleados")
    @ResponseBody
    public List<Empleado> obtenerMetodosPago() {
       return  empleado.obtenerEmpleados();
    }

    @PostMapping("/insert_empleado")
    public String insertarMetodoPago(@RequestParam("nombreEmpleado") String nombre,
                                     @RequestParam("primerApellido") String pApellido,
                                     @RequestParam("segundoApellido") String sApellido,
                                     @RequestParam("cedula") String cedula,
                                     @RequestParam("edad") int edad,
                                     @RequestParam("genero") String genero,
                                     @RequestParam("direccion") String direccion,
                                     @RequestParam("fechaContratacion") Date fecha,
                                     @RequestParam("puesto") int puesto,
                                     @RequestParam("telefono") String telefono,
                                     @RequestParam("email") String email) {

        empleado.insertarEmpleado(nombre, pApellido,sApellido,cedula,edad,genero,direccion,fecha,puesto,telefono,email);
        return "redirect:/empleados";
    }

    @PostMapping("/eliminar_empleado")
    public String eliminarEmpleado(@RequestParam("id_empleado") int id) {
        
        empleado.eliminarEmpleado(id);
        return "redirect:/empleado";
    }
    @GetMapping("/obtener_puestos")
    @ResponseBody
    public List<Puesto> obtenerPuestos() {
        return empleado.obtenerPuestos();
    }

 
    @GetMapping("/listar/{id}")
    public String obtenerEmpleado(@PathVariable("id") int id, Model model) {
        Empleado empleadoM = empleado.obtenerEmpleadoPorId(id);
        model.addAttribute("empleado", empleadoM);
        return "/pages/Empleado/empleados_actualizar"; // Nombre de la página HTML para el formulario de actualización
    }

    @PostMapping("/actualizar_empleado")
    public String actualizarEmpleado(@ModelAttribute Empleado empleadoM) {
        empleado.actualizarEmpleado(empleadoM);
        return "redirect:/empleados"; // Redirigir a la página principal después de la actualización
    }
}
