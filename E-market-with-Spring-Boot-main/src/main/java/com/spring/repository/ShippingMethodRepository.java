package com.spring.repository;

import com.spring.model.ShippingMethod;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ShippingMethodRepository extends JpaRepository<ShippingMethod, Long> {
    // JpaRepository-র built-in method গুলো ব্যবহার করবো
}
