package com.spring.controller;

import com.spring.model.UserAddress;
import com.spring.service.UserAddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@CrossOrigin(value = "*")
@RestController
@RequestMapping("/api/addresses")
public class UserAddressController {

    @Autowired
    private UserAddressService userAddressService;

    @PostMapping
    public UserAddress create(@RequestBody UserAddress address) {
        return userAddressService.createAddress(address);
    }

    @PutMapping("/{id}")
    public UserAddress update(@PathVariable Long id, @RequestBody UserAddress address) {
        return userAddressService.updateAddress(id, address);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        userAddressService.deleteAddress(id);
    }

    @GetMapping("/{id}")
    public UserAddress getById(@PathVariable Long id) {
        return userAddressService.getAddressById(id);
    }

    @GetMapping
    public List<UserAddress> getAll() {
        return userAddressService.getAllAddresses();
    }
}
