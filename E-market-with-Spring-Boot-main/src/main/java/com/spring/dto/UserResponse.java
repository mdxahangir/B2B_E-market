package com.spring.dto;

import com.spring.model.UserRole;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserResponse {
    private Long id;
    private String fullName;
    private String email;
    private String phoneNumber;
    private UserRole role;
    private Boolean isActive;
    private Boolean emailVerified;
}
