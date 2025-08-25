package com.spring.b2b.ecommerce;


import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@ComponentScan(basePackages = "com.spring")
@EntityScan(basePackages = "com.spring")
@EnableJpaRepositories("com.spring")
public class B2BEcommerceApplication {
    public static void main(String[] args) {
        SpringApplication.run(B2BEcommerceApplication.class, args);
    }
}