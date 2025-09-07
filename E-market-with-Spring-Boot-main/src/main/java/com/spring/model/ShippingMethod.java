package com.spring.model;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;

@Entity
@Table(name = "shipping_methods")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ShippingMethod {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 100, unique = true)
    private String name; 

    @Column(length = 255)
    private String description;

    @Column(nullable = false, precision = 10, scale = 2)
    private BigDecimal cost; 

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ShippingProvider provider; 

    @Column(nullable = false)
    private Integer estimatedDeliveryDays; 

    @Column(nullable = false)
    private Boolean isActive; 

}
