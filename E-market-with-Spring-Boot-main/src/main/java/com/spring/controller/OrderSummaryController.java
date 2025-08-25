package com.spring.controller;

import com.spring.model.OrderSummary;
import com.spring.service.OrderSummaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;

@CrossOrigin("*")
@RestController
@RequestMapping("/api/orders")
public class OrderSummaryController {

    @Autowired
    private OrderSummaryService orderSummaryService;
    
    @GetMapping("/revenue")
    public ResponseEntity<BigDecimal> getTotalRevenue() {
        return ResponseEntity.ok(orderSummaryService.getTotalRevenue());
    }

    
    @GetMapping("/count")
    public ResponseEntity<Long> getTotalOrders() {
        return ResponseEntity.ok(orderSummaryService.getTotalOrders());
    }


    @PostMapping
    public ResponseEntity<OrderSummary> createOrder(@RequestBody OrderSummary orderSummary) {
        if (orderSummary.getGrandTotal() == null || orderSummary.getStatus() == null || orderSummary.getMethod() == null) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.ok(orderSummaryService.saveOrderSummary(orderSummary));
    }

    @GetMapping
    public ResponseEntity<List<OrderSummary>> getAllOrders() {
        return ResponseEntity.ok(orderSummaryService.getAllOrderSummaries());
    }

    @GetMapping("/{id}")
    public ResponseEntity<OrderSummary> getOrderById(@PathVariable Long id) {
        return orderSummaryService.getOrderSummaryById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PutMapping("/{id}")
    public ResponseEntity<OrderSummary> updateOrder(@PathVariable Long id, @RequestBody OrderSummary updatedOrder) {
        try {
            return ResponseEntity.ok(orderSummaryService.updateOrderSummary(id, updatedOrder));
        } catch (RuntimeException ex) {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteOrder(@PathVariable Long id) {
        try {
            orderSummaryService.deleteOrderSummary(id);
            return ResponseEntity.noContent().build();
        } catch (RuntimeException ex) {
            return ResponseEntity.notFound().build();
        }
    }
}
