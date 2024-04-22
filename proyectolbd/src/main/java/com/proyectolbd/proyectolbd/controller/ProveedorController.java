package com.proyectolbd.proyectolbd.controller;

import com.proyectolbd.proyectolbd.modelo.Proveedor;
import com.proyectolbd.proyectolbd.servicio.ProveedorService;
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

@Controller
@RequestMapping("/proveedor")
public class ProveedorController {
    
    @Autowired
    private ProveedorService proveedor;
    
    @GetMapping("/listar_proveedor")
    @ResponseBody
    public List<Proveedor> obtenerProveedor() {
       return  proveedor.obtenerProveedor();
    }
    
    @PostMapping("/insert_proveedor")
    public String insertarMetodoPago(@RequestParam("idProveedor") Integer id_Proveedor,
                                     @RequestParam("nombre") String nombre,
                                     @RequestParam("contacto") String contacto,
                                     @RequestParam("tipoProveedor") String tipo_proveedor,
                                     @RequestParam("idDireccion") Integer id_Direccion) {

        proveedor.insertarProveedor(id_Proveedor, nombre, contacto, tipo_proveedor, id_Direccion);
        return "redirect:/proveedor";
    }
    
    @PostMapping("/eliminar_proveedor")
    public String eliminarProveedor(@RequestParam("id_Proveedor") int id) {
        proveedor.eliminarProveedor(id);
        return "redirect:/empleado";
    }
    
    @GetMapping("/listar/{id}")
    public String obtenerProveedor(@PathVariable("id") int id, Model model) {
        Proveedor proveedores = proveedor.obtenerProveedorPorId(id);
        model.addAttribute("proveedores", proveedores);
        return "/pages/Proveedor/proveedor"; // Nombre de la página HTML para el formulario de actualización
    }
    
    @PostMapping("/actualizar_proveedor")
    public String actualizarProveedores(@ModelAttribute Proveedor proveedorS) {
        proveedor.actualizarProveedor(proveedorS);
        return "redirect:/empleados"; // Redirigir a la página principal después de la actualización
    }
    
}
