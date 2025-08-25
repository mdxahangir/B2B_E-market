package com.spring.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "user_addresses")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserAddress {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // ইউজার রেফারেন্স (চাইলে User Entity তে @ManyToOne ব্যবহার করে যুক্ত করা যাবে)
    @Column(nullable = false)
    private Long userId;

    @Column(nullable = false, length = 100)
    private String fullName;

    @Column(nullable = false, length = 20)
    private String phoneNumber;

    @Column(nullable = false, length = 255)
    private String addressLine1;

    @Column(length = 255)
    private String addressLine2;

    @Column(nullable = false, length = 100)
    private String city;

    @Column(nullable = false, length = 100)
    private String stateOrProvince;

    @Column(nullable = false, length = 20)
    private String postalCode;

    @Column(nullable = false, length = 100)
    private String country;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private AddressType addressType; // SHIPPING, BILLING

    @Column(name = "is_default", nullable = false)
    private Boolean isDefault = false; // default value set

}
