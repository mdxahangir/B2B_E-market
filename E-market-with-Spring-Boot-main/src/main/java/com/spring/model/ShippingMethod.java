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
    private String name; // e.g., "Standard Shipping", "Express", "Next-Day"

    @Column(length = 255)
    private String description;

    @Column(nullable = false, precision = 10, scale = 2)
    private BigDecimal cost; // Flat shipping cost or base cost

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ShippingProvider provider; // e.g., DHL, FedEx, Local, Other

    @Column(nullable = false)
    private Integer estimatedDeliveryDays; // e.g., 3, 5

    @Column(nullable = false)
    private Boolean isActive; // enable/disable for frontend

}
