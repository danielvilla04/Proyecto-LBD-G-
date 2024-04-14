package com.proyectolbd.proyectolbd;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import com.proyectolbd.proyectolbd.modelo.ventas.MetodoPago;



@SpringBootApplication
public class ProyectolbdApplication implements CommandLineRunner{

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public static void main(String[] args) {
		SpringApplication.run(ProyectolbdApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
		
		String sql ="select * from metodo_pago_tb";
		List<MetodoPago> metodos = jdbcTemplate.query(sql,
		 BeanPropertyRowMapper.newInstance(MetodoPago.class));

		 metodos.forEach(System.out :: println );
	}



}