package com.proyectolbd.proyectolbd.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;





@Controller
public class LoginController {

     @RequestMapping("/home")
     public String loginSubmit(){return "/pages/home";}

     @RequestMapping("/login")
     public String login(){return "auth-login";}
     
     
}
