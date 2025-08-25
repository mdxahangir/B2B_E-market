package com.spring.service;

import com.spring.model.ShippingMethod;

import java.util.List;
import java.util.Optional;

public interface ShippingMethodService {

    ShippingMethod createShippingMethod(ShippingMethod shippingMethod);

    List<ShippingMethod> getAllShippingMethods();

    Optional<ShippingMethod> getShippingMethodById(Long id);

}
