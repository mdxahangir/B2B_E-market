package com.spring.service.impl;

import com.spring.model.ShippingMethod;
import com.spring.repository.ShippingMethodRepository;
import com.spring.service.ShippingMethodService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ShippingMethodServiceImpl implements ShippingMethodService {

    private final ShippingMethodRepository shippingMethodRepository;

    @Override
    public ShippingMethod createShippingMethod(ShippingMethod shippingMethod) {
        return shippingMethodRepository.save(shippingMethod);
    }

    @Override
    public List<ShippingMethod> getAllShippingMethods() {
        return shippingMethodRepository.findAll();
    }

    @Override
    public Optional<ShippingMethod> getShippingMethodById(Long id) {
        return shippingMethodRepository.findById(id);
    }
}
