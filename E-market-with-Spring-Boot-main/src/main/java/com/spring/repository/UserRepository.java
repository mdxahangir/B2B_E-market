package com.spring.repository;

import com.spring.model.User;
import com.spring.model.UserRole;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String email);
    boolean existsByEmail(String email);
    
    
    long countByRole(UserRole role);
}
