package com.proyectolbd.proyectolbd.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController {

//    @RequestMapping("/login")
//    public String loginPage(){
//        return "/auth_login";
//    }

    @RequestMapping("/login")
    public String loginSubmit1(){
        return "/pages/home";
    }

}