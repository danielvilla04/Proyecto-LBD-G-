/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.proyectolbd.proyectolbd.controller;

import com.proyectolbd.proyectolbd.modelo.Cliente;
import com.proyectolbd.proyectolbd.modelo.Empleado;
import com.proyectolbd.proyectolbd.servicio.ClientesService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author Saul
 */
@Controller
public class ClienteController {
     @Autowired
    private ClientesService cliente;
     
     @GetMapping("/ListaClientes")
     public String mostrarClientes() {
      //List<Map<String, Object>> cliente = clientes.();
      //model.addAttribute("datosclientes", cliente);
      return "/pages/clientes/clientes_lista";
   }
   
    @GetMapping("/listaClientes")
    @ResponseBody
     public List<Cliente> listaClientes(){
         return cliente.obtenerClientes();
     }
    

    @PostMapping("/insert_cliente")
    public String insertarCliente(@RequestParam("id_cliente") Integer idCliente,
                                  @RequestParam("nombre") String nombre,
                                  @RequestParam("primer_Apellido") String primerApellido,
                                  @RequestParam("segundo_Apellido") String segundoApellido,
                                  @RequestParam("cedula") Integer numeroCedula,
                                  @RequestParam("edad") Integer edad,
                                  @RequestParam("genero") String genero,
                                  @RequestParam("id_direccion") Integer idDireccion) {
        cliente.insertarCliente(idCliente, nombre, primerApellido, segundoApellido, numeroCedula, edad, genero, idDireccion);
        return "redirect:/clientes";
    }
    
    //pegar PostMapping y en los parametros @RequestParam("idCliente") Integer id, cuando este lista la vista
    @GetMapping("/eliminar_cliente/{id}")
    public String eliminarCliente(@PathVariable("id") int id) {
        cliente.eliminarCliente(id);
        return "redirect:/ListaClientes";
    }
    
    @GetMapping("/actualizarCliente/{id}")
     public String actualizarCliente(@PathVariable("id") String id){
         Cliente cl = cliente.obtenerCliente(id);
         if(cl == null){
             return "redirect:/ListaClientes";
         }
         return "/pages/clientes/clientes_actualizar";
     }
    
     @PostMapping("/obtenerCliente")
     @ResponseBody
     public Cliente obtenerCliente(@RequestParam("id_cliente") String id){
         //modificar para recibir parametro
         return cliente.obtenerCliente(id);
     }
     
     @PostMapping("/actualizar_cliente")
    public String actualizar_cliente(@RequestParam("id_cliente") Integer idCliente,
                                  @RequestParam("nombre") String nombre,
                                  @RequestParam("primer_Apellido") String primerApellido,
                                  @RequestParam("segundo_Apellido") String segundoApellido,
                                  @RequestParam("cedula") Integer numeroCedula,
                                  @RequestParam("edad") Integer edad,
                                  @RequestParam("genero") String genero,
                                  @RequestParam("id_direccion") Integer idDireccion) {
        
        cliente.actualizar(idCliente, nombre, primerApellido, segundoApellido, numeroCedula, edad, genero, idDireccion);
        return "redirect:/ListaClientes";
    
    }
    
}
