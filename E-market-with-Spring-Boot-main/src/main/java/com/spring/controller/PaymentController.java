//package com.spring.controller;
//
//import com.spring.model.Payment;
//import com.spring.service.PaymentService;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.*;
//
//import java.util.List;
//@CrossOrigin(value = "*")
//@RestController
//@RequestMapping("/api/payments")
//public class PaymentController {
//
//    private final PaymentService paymentService;
//
//    public PaymentController(PaymentService paymentService) {
//        this.paymentService = paymentService;
//    }
//
//    @PostMapping
//    public ResponseEntity<Payment> createPayment(@RequestBody Payment payment) {
//        Payment savedPayment = paymentService.savePayment(payment);
//        return ResponseEntity.ok(savedPayment);
//    }
//
//    @GetMapping("/{id}")
//    public ResponseEntity<Payment> getPaymentById(@PathVariable Long id) {
//        return paymentService.getPaymentById(id)
//                .map(ResponseEntity::ok)
//                .orElse(ResponseEntity.notFound().build());
//    }
//
//    @GetMapping
//    public ResponseEntity<List<Payment>> getAllPayments() {
//        return ResponseEntity.ok(paymentService.getAllPayments());
//    }
//
//    @DeleteMapping("/{id}")
//    public ResponseEntity<Void> deletePayment(@PathVariable Long id) {
//        paymentService.deletePayment(id);
//        return ResponseEntity.noContent().build();
//    }
//}
