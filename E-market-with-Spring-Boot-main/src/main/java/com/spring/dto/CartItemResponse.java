package com.spring.dto;

import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Builder
public class CartItemResponse {
    private Long productId;
    private String productName;
    private int quantity;
    private BigDecimal price;
    private BigDecimal discount;
    private BigDecimal totalPrice;
}
