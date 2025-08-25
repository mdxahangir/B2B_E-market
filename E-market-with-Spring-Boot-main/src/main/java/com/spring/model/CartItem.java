//package com.spring.model;
//
//import java.math.BigDecimal;
//import jakarta.persistence.*;
//import lombok.*;
//
//@Entity
//@Table(name = "cart_items")
//@Data
//@NoArgsConstructor
//@AllArgsConstructor
//@Builder
//public class CartItem {
//
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    private Long id;
//
//    @ManyToOne(fetch = FetchType.LAZY)
//    private Product product;
//
//    @ManyToOne(fetch = FetchType.LAZY)
//    private Cart cart;
//
//    private int quantity;
//
//    private BigDecimal price;
//
//}
package com.spring.model;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;

@Entity
@Table(name = "cart_items")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CartItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    private Product product;

    @ManyToOne(fetch = FetchType.LAZY)
    private Cart cart;

    private int quantity;

    private BigDecimal price;

    private BigDecimal discount;
}
