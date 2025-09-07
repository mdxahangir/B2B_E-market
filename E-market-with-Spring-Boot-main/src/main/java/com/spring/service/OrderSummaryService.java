package com.spring.service;

import com.spring.model.OrderSummary;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

import com.spring.model.OrderSummary;

public interface OrderSummaryService {
    OrderSummary saveOrderSummary(OrderSummary orderSummary);
    List<OrderSummary> getAllOrderSummaries();
    Optional<OrderSummary> getOrderSummaryById(Long id);
    OrderSummary updateOrderSummary(Long id, OrderSummary updatedOrderSummary);
    void deleteOrderSummary(Long id);

    long getTotalOrders();
    
    BigDecimal getTotalRevenue();
}
