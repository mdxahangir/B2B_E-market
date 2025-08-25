//package com.spring.controller;
//
//import com.spring.dto.AddToCartRequest;
//import com.spring.dto.CartSummaryResponse;
//import com.spring.service.CartService;
//import lombok.RequiredArgsConstructor;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.*;
//@CrossOrigin(value = "*")
//@RestController
//@RequestMapping("/api/cart")
//@RequiredArgsConstructor
//public class CartController {
//
//    private final CartService cartService;
//
//    @PostMapping("/add")
//    public ResponseEntity<String> addToCart(@RequestBody AddToCartRequest request) {
//        cartService.addToCart(request);
//        return ResponseEntity.ok("Product added to cart successfully!");
//    }
//    @GetMapping("/summary/{userCode}")
//    public ResponseEntity<CartSummaryResponse> getCartSummary(@PathVariable String userCode) {
//        CartSummaryResponse summary = cartService.getCartSummary(userCode);
//        return ResponseEntity.ok(summary);
//    }
//
//}
package com.spring.controller;

import com.spring.dto.AddToCartRequest;
import com.spring.dto.CartSummaryResponse;
import com.spring.service.CartService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
@CrossOrigin(value = "*")
@RestController
@RequestMapping("/api/cart")
@RequiredArgsConstructor
public class CartController {

    private final CartService cartService;

    @PostMapping("/add")
    public String addToCart(@RequestBody AddToCartRequest request) {
        cartService.addToCart(request);
        return "Product added to cart successfully!";
    }

    @GetMapping("/summary/{userCode}")
    public CartSummaryResponse getSummary(@PathVariable String userCode) {
        return cartService.getCartSummary(userCode);
    }
}
