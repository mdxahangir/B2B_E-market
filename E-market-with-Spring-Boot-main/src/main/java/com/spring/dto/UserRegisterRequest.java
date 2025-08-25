package com.spring.dto;

import com.spring.model.UserRole;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserRegisterRequest {
    private String fullName;
    private String email;
    private String password;
    private String phoneNumber;
    private UserRole role;
}
