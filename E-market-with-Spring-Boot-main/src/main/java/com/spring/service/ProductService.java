package com.spring.service;

import com.spring.model.Product;

import java.util.List;
import java.util.Optional;

public interface ProductService {
    Product create(Product product);
    Product update(Long id, Product product);
    Optional<Product> getById(Long id);
    List<Product> getAll();
    void delete(Long id);
}
