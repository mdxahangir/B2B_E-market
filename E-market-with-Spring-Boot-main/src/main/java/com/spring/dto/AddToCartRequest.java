//package com.spring.dto;
//
//import lombok.Data;
//
//@Data
//public class AddToCartRequest {
//    private String userCode;
//    private Long productId;
//    private int quantity;
//}
package com.spring.dto;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class AddToCartRequest {
    private String userCode;
    private Long productId;
    private int quantity;
    private BigDecimal discount;
    private Long shippingMethodId; // optional
}
