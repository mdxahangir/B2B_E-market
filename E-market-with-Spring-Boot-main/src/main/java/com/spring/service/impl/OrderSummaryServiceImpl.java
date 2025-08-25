package com.spring.service.impl;

import com.spring.model.OrderSummary;
import com.spring.repository.OrderSummaryRepository;
import com.spring.service.OrderSummaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class OrderSummaryServiceImpl implements OrderSummaryService {

    @Autowired
    private OrderSummaryRepository orderSummaryRepository;
    
    //new
    @Override
    public BigDecimal getTotalRevenue() {
        return orderSummaryRepository.getTotalRevenue();
    }

    
    @Override
    public long getTotalOrders() {
        return orderSummaryRepository.count();
    }


    @Override
    public OrderSummary saveOrderSummary(OrderSummary orderSummary) {
        if (orderSummary.getOrderDate() == null) {
            orderSummary.setOrderDate(LocalDateTime.now());
        }
        return orderSummaryRepository.save(orderSummary);
    }

    @Override
    public List<OrderSummary> getAllOrderSummaries() {
        return orderSummaryRepository.findAll();
    }

    @Override
    public Optional<OrderSummary> getOrderSummaryById(Long id) {
        return orderSummaryRepository.findById(id);
    }

    @Override
    public OrderSummary updateOrderSummary(Long id, OrderSummary updatedOrderSummary) {
        return orderSummaryRepository.findById(id).map(existing -> {
            existing.setUserId(updatedOrderSummary.getUserId());
            existing.setAddressId(updatedOrderSummary.getAddressId());
            existing.setProductId(updatedOrderSummary.getProductId());
            existing.setName(updatedOrderSummary.getName());
            existing.setQuantity(updatedOrderSummary.getQuantity());
            existing.setGrandTotal(updatedOrderSummary.getGrandTotal());
            existing.setStatus(updatedOrderSummary.getStatus());
            existing.setMethod(updatedOrderSummary.getMethod());
            existing.setOrderDate(updatedOrderSummary.getOrderDate() != null
                    ? updatedOrderSummary.getOrderDate()
                    : existing.getOrderDate());
            return orderSummaryRepository.save(existing);
        }).orElseThrow(() -> new RuntimeException("OrderSummary not found with ID: " + id));
    }

    @Override
    public void deleteOrderSummary(Long id) {
        if (!orderSummaryRepository.existsById(id)) {
            throw new RuntimeException("OrderSummary not found with ID: " + id);
        }
        orderSummaryRepository.deleteById(id);
    }
}
