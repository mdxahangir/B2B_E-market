//package com.spring.dto;
//
//import lombok.Builder;
//import lombok.Data;
//
//import java.math.BigDecimal;
//import java.util.List;
//
//@Data
//@Builder
//public class CartSummaryResponse {
//    private String userCode;
//    private int totalItems;
//    private BigDecimal totalPrice;
//    private List<CartItemResponse> items;
//}
package com.spring.dto;

import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

@Data
@Builder
public class CartSummaryResponse {
    private String userCode;
    private int totalItems;
    private BigDecimal totalPrice;
    private BigDecimal shippingCost;
    private BigDecimal grandTotal;
    private List<CartItemResponse> items;
}
