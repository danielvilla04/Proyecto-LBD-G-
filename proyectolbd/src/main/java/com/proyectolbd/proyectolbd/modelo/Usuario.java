package com.proyectolbd.proyectolbd.modelo;

public class Usuario {
    

    private String username;
    private String password;
    private String email;
    private String role;
    private Boolean activo;
    private int idUsuario;
    
    public Usuario() {
    }

    public Usuario(String username, String password, String email, String role, Boolean activo, int idUsuario) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.role = role;
        this.activo = activo;
        this.idUsuario =  idUsuario;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Boolean getActivo() {
        return activo;
    }

    public void setActivo(Boolean activo) {
        this.activo = activo;
    }

    
}
