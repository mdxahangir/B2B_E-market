//package com.spring.repository;
//
//import com.spring.model.OrderSummary;
//import org.springframework.data.jpa.repository.JpaRepository;
//import org.springframework.stereotype.Repository;
//
//@Repository
//public interface OrderSummaryRepository extends JpaRepository<OrderSummary, Long> {
//}
package com.spring.repository;

import com.spring.model.OrderSummary;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;

@Repository
public interface OrderSummaryRepository extends JpaRepository<OrderSummary, Long> {

    @Query("SELECT COALESCE(SUM(o.grandTotal), 0) FROM OrderSummary o")
    BigDecimal getTotalRevenue();
}
