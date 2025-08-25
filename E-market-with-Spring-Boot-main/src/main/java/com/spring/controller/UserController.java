package com.spring.controller;

import com.spring.dto.*;
import com.spring.model.UserRole;
import com.spring.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @PostMapping("/register")
    public ResponseEntity<UserResponse> register(@RequestBody UserRegisterRequest request) {
        return ResponseEntity.ok(userService.register(request));
    }

    @PostMapping("/login")
    public ResponseEntity<UserResponse> login(@RequestBody UserLoginRequest request) {
        return ResponseEntity.ok(userService.login(request));
    }

    @GetMapping("/count")
    public ResponseEntity<Long> getTotalUsers() {
        return ResponseEntity.ok(userService.getTotalUsers());
    }

    @GetMapping("/count-suppliers")
    public ResponseEntity<Long> getTotalSuppliers() {
        return ResponseEntity.ok(userService.getTotalSuppliers());
    }

    @GetMapping("/suppliers")
    public ResponseEntity<List<UserResponse>> getSuppliers() {
        return ResponseEntity.ok(userService.getSuppliers(UserRole.SUPPLIER));
    }
}
