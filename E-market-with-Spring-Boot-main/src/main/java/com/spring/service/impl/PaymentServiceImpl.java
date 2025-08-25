//package com.spring.service.impl;
//
//import com.spring.model.Payment;
//import com.spring.repository.PaymentRepository;
//import com.spring.service.PaymentService;
//import org.springframework.stereotype.Service;
//
//import java.util.List;
//import java.util.Optional;
//
//@Service
//public class PaymentServiceImpl implements PaymentService {
//
//    private final PaymentRepository paymentRepository;
//
//    public PaymentServiceImpl(PaymentRepository paymentRepository) {
//        this.paymentRepository = paymentRepository;
//    }
//
//    @Override
//    public Payment savePayment(Payment payment) {
//        return paymentRepository.save(payment);
//    }
//
//    @Override
//    public Optional<Payment> getPaymentById(Long id) {
//        return paymentRepository.findById(id);
//    }
//
//    @Override
//    public List<Payment> getAllPayments() {
//        return paymentRepository.findAll();
//    }
//
//    @Override
//    public void deletePayment(Long id) {
//        paymentRepository.deleteById(id);
//    }
//}
