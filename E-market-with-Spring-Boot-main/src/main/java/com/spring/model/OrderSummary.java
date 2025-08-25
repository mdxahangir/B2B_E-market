package com.spring.model;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "order_summaries")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderSummary {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Long userId;

    @Column(nullable = false)
    private Long addressId;


    @Column(name = "product_id", nullable = false)
    private Long productId;

    @Column(nullable = false, length = 150)
    private String name;

    @Column(name = "quantity", nullable = false)
    private int quantity;

    @Column(name = "grand_total", nullable = false)
    private BigDecimal grandTotal;

    @Column(name = "order_date", nullable = false)
    private LocalDateTime orderDate;
    
  @Enumerated(EnumType.STRING)
  @Column(nullable = false)
  private PaymentStatus status;

  @Enumerated(EnumType.STRING)
  @Column(nullable = false)
  private PaymentMethod method;

    @PrePersist
    public void prePersist() {
        if (orderDate == null) {
            orderDate = LocalDateTime.now();
        }
    }
}
