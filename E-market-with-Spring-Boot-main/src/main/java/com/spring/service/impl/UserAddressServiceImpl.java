package com.spring.service.impl;

import com.spring.model.UserAddress;
import com.spring.repository.UserAddressRepository;
import com.spring.service.UserAddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserAddressServiceImpl implements UserAddressService {

    @Autowired
    private UserAddressRepository userAddressRepository;

    @Override
    public UserAddress createAddress(UserAddress address) {
        return userAddressRepository.save(address);
    }

    @Override
    public UserAddress updateAddress(Long id, UserAddress updatedAddress) {
        UserAddress existing = userAddressRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Address not found with id: " + id));
        updatedAddress.setId(id); // ID সেট করে দিয়ে নতুন Address save করি
        return userAddressRepository.save(updatedAddress);
    }

    @Override
    public void deleteAddress(Long id) {
        userAddressRepository.deleteById(id);
    }

    @Override
    public UserAddress getAddressById(Long id) {
        return userAddressRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Address not found with id: " + id));
    }

    @Override
    public List<UserAddress> getAllAddresses() {
        return userAddressRepository.findAll();
    }
}
