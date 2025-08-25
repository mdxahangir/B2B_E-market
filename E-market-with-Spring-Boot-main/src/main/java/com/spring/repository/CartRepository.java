//package com.spring.repository;
//
//import com.spring.model.Cart;
//import org.springframework.data.jpa.repository.JpaRepository;
//import java.util.Optional;
//
//public interface CartRepository extends JpaRepository<Cart, Long> {
//    Optional<Cart> findByUserCode(String userCode);
//}
package com.spring.repository;

import com.spring.model.Cart;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CartRepository extends JpaRepository<Cart, Long> {
    Optional<Cart> findByUserCode(String userCode);
}
