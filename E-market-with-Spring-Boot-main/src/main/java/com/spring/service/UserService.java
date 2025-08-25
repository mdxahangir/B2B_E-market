//package com.spring.service;
//
//import com.spring.dto.UserRegisterRequest;
//import com.spring.dto.UserLoginRequest;
//import com.spring.dto.UserResponse;
//
//public interface UserService {
//    UserResponse register(UserRegisterRequest request);
//    UserResponse login(UserLoginRequest request);
//    
//    long getTotalUsers();
//    long getTotalSuppliers();
//
//    
//}
package com.spring.service;

import com.spring.dto.UserRegisterRequest;
import com.spring.dto.UserLoginRequest;
import com.spring.dto.UserResponse;
import com.spring.model.UserRole;

import java.util.List;

public interface UserService {
    UserResponse register(UserRegisterRequest request);
    UserResponse login(UserLoginRequest request);

    long getTotalUsers();
    long getTotalSuppliers();

    // --- Optional, for listing suppliers if needed later ---
    List<UserResponse> getSuppliers(UserRole role);
}
