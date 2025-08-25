package com.spring.controller;

import com.spring.model.ShippingMethod;
import com.spring.service.ShippingMethodService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@CrossOrigin(value = "*")
@RestController
@RequestMapping("/api/shipping-methods")
@RequiredArgsConstructor
public class ShippingMethodController {

    private final ShippingMethodService shippingMethodService;

    // Create - নতুন ShippingMethod যোগ করা
    @PostMapping
    public ResponseEntity<ShippingMethod> createShippingMethod(@RequestBody ShippingMethod shippingMethod) {
        ShippingMethod created = shippingMethodService.createShippingMethod(shippingMethod);
        return ResponseEntity.ok(created);
    }

    // Read - সব ShippingMethod এর লিস্ট দেখানো
    @GetMapping
    public ResponseEntity<List<ShippingMethod>> getAllShippingMethods() {
        List<ShippingMethod> list = shippingMethodService.getAllShippingMethods();
        return ResponseEntity.ok(list);
    }

    // Read - id অনুযায়ী একটি ShippingMethod আনা
    @GetMapping("/{id}")
    public ResponseEntity<ShippingMethod> getShippingMethodById(@PathVariable Long id) {
        return shippingMethodService.getShippingMethodById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

}
