package com.spring.service;

import com.spring.model.UserAddress;

import java.util.List;

public interface UserAddressService {
    UserAddress createAddress(UserAddress address);
    UserAddress updateAddress(Long id, UserAddress address);
    void deleteAddress(Long id);
    UserAddress getAddressById(Long id);
    List<UserAddress> getAllAddresses();
}
