//package com.spring.service.impl;
//
//import com.spring.dto.*;
//import com.spring.model.User;
//import com.spring.model.UserRole;
//import com.spring.repository.UserRepository;
//import com.spring.service.UserService;
//import lombok.RequiredArgsConstructor;
//import org.springframework.stereotype.Service;
//
//import java.time.LocalDateTime;
//
//@Service
//@RequiredArgsConstructor
//public class UserServiceImpl implements UserService {
//
//    private final UserRepository userRepository;
//    
//    //new
//    @Override
//    public long getTotalUsers() {
//        return userRepository.count();
//    }
//    
//    @Override
//    public long getTotalSuppliers() {
//        return userRepository.countByRole(UserRole.SUPPLIER); // or include BOTH if needed
//    }
//
//
//    @Override
//    public UserResponse register(UserRegisterRequest request) {
//        if (userRepository.existsByEmail(request.getEmail())) {
//            throw new RuntimeException("Email already in use");
//        }
//
//        User user = User.builder()
//                .fullName(request.getFullName())
//                .email(request.getEmail())
//                .password(request.getPassword()) // 🔐 TODO: Hash in real app
//                .phoneNumber(request.getPhoneNumber())
//                .role(request.getRole())
//                .isActive(true)
//                .emailVerified(false)
//                .registrationDate(LocalDateTime.now())
//                .build();
//
//        User savedUser = userRepository.save(user);
//        return toResponse(savedUser);
//    }
//
//    @Override
//    public UserResponse login(UserLoginRequest request) {
//        User user = userRepository.findByEmail(request.getEmail())
//                .orElseThrow(() -> new RuntimeException("Invalid email or password"));
//
//        if (!user.getPassword().equals(request.getPassword())) {
//            throw new RuntimeException("Invalid email or password");
//        }
//
//        return toResponse(user);
//    }
//
//    private UserResponse toResponse(User user) {
//        return UserResponse.builder()
//                .id(user.getId())
//                .fullName(user.getFullName())
//                .email(user.getEmail())
//                .phoneNumber(user.getPhoneNumber())
//                .role(user.getRole())
//                .isActive(user.getIsActive())
//                .emailVerified(user.getEmailVerified())
//                .build();
//    }
//}
package com.spring.service.impl;

import com.spring.dto.*;
import com.spring.model.User;
import com.spring.model.UserRole;
import com.spring.repository.UserRepository;
import com.spring.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;

    @Override
    public long getTotalUsers() {
        return userRepository.count();
    }

    @Override
    public long getTotalSuppliers() {
        // Counts only SUPPLIER. If you also want BOTH included, change to:
        // return userRepository.countByRole(UserRole.SUPPLIER) + userRepository.countByRole(UserRole.BOTH);
        return userRepository.countByRole(UserRole.SUPPLIER);
    }

    @Override
    public UserResponse register(UserRegisterRequest request) {
        if (userRepository.existsByEmail(request.getEmail())) {
            throw new RuntimeException("Email already in use");
        }

        User user = User.builder()
                .fullName(request.getFullName())
                .email(request.getEmail())
                .password(request.getPassword()) // TODO: hash in real app
                .phoneNumber(request.getPhoneNumber())
                .role(request.getRole())
                .isActive(true)
                .emailVerified(false)
                .registrationDate(LocalDateTime.now())
                .build();

        User savedUser = userRepository.save(user);
        return toResponse(savedUser);
    }

    @Override
    public UserResponse login(UserLoginRequest request) {
        User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new RuntimeException("Invalid email or password"));

        if (!user.getPassword().equals(request.getPassword())) {
            throw new RuntimeException("Invalid email or password");
        }

        return toResponse(user);
    }

    // --- Optional, for listing suppliers if needed ---
    @Override
    public List<UserResponse> getSuppliers(UserRole role) {
        return userRepository.findAll().stream()
                .filter(u -> u.getRole() == role) // change if you want to include BOTH
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    private UserResponse toResponse(User user) {
        return UserResponse.builder()
                .id(user.getId())
                .fullName(user.getFullName())
                .email(user.getEmail())
                .phoneNumber(user.getPhoneNumber())
                .role(user.getRole())
                .isActive(user.getIsActive())
                .emailVerified(user.getEmailVerified())
                .build();
    }
}
