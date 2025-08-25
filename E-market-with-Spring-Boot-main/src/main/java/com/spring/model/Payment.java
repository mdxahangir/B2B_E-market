//package com.spring.model;
//
//import jakarta.persistence.*;
//import lombok.*;
//
//import java.math.BigDecimal;
//import java.time.LocalDateTime;
//
//@Entity
//@Table(name = "payments")
//@Data
//@NoArgsConstructor
//@AllArgsConstructor
//@Builder
//public class Payment {
//
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    private Long id;
//
//    // User Reference (or User entity relation)
//    @Column(nullable = false)
//    private Long userId;
//
//    // Order Reference (or Order entity relation if you have Order entity)
//    @Column(nullable = false)
//    private Long orderId;
//
//    @Column(nullable = false)
//    private BigDecimal amount;
//
//    @Enumerated(EnumType.STRING)
//    @Column(nullable = false)
//    private PaymentStatus status;
//
//    @Enumerated(EnumType.STRING)
//    @Column(nullable = false)
//    private PaymentMethod method;
//
//    @Column(nullable = false)
//    private LocalDateTime paymentDate;
//
//    @Column(length = 255)
//    private String transactionId;
//
//    @Column(length = 255)
//    private String paymentGatewayResponse; // store JSON string or reference
//
//}
