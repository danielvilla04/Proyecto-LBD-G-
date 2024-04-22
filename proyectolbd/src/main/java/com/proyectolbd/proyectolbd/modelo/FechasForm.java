package com.proyectolbd.proyectolbd.modelo;

import java.sql.Date;

public class FechasForm {
        private Date fechaInicio;
        private Date fechaFin;

        
    
        public FechasForm() {
        }

        public Date getFechaInicio() {
            return fechaInicio;
        }
    
        public void setFechaInicio(Date fechaInicio) {
            this.fechaInicio = fechaInicio;
        }
    
        public Date getFechaFin() {
            return fechaFin;
        }
    
        public void setFechaFin(Date fechaFin) {
            this.fechaFin = fechaFin;
        }
    }

