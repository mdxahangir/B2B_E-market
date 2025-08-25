//package com.spring.service.impl;
//
//import com.spring.model.Product;
//import com.spring.repository.ProductRepository;
//import com.spring.service.ProductService;
//import jakarta.persistence.EntityNotFoundException;
//import lombok.RequiredArgsConstructor;
//import org.springframework.stereotype.Service;
//
//import java.util.List;
//import java.util.Optional;
//
//@Service
//@RequiredArgsConstructor
//public class ProductServiceImpl implements ProductService {
//
//    private final ProductRepository productRepository;
//
//    @Override
//    public Product create(Product product) {
//        if (productRepository.existsByName(product.getName())) {
//            throw new IllegalArgumentException("Product with name '" + product.getName() + "' already exists.");
//        }
//        return productRepository.save(product);
//    }
//
//    @Override
//    public Product update(Long id, Product product) {
//        Product existing = productRepository.findById(id)
//                .orElseThrow(() -> new EntityNotFoundException("Product not found with id: " + id));
//
//        existing.setName(product.getName());
//        existing.setDescription(product.getDescription());
//        existing.setPrice(product.getPrice());
//        existing.setStock(product.getStock());
//        existing.setDiscount(product.getDiscount()); // ✅ added discount update
//        existing.setCategory(product.getCategory());
//        existing.setSubCategory(product.getSubCategory());
//        existing.setImage_url(product.getImage_url());
//        existing.setUpdatedByCode(product.getUpdatedByCode());
//        existing.setUpdatedByName(product.getUpdatedByName());
//
//        return productRepository.save(existing);
//    }
//
//    @Override
//    public Optional<Product> getById(Long id) {
//        return productRepository.findById(id);
//    }
//
//    @Override
//    public List<Product> getAll() {
//        return productRepository.findAll();
//    }
//
//    @Override
//    public void delete(Long id) {
//        if (!productRepository.existsById(id)) {
//            throw new EntityNotFoundException("Product not found with id: " + id);
//        }
//        productRepository.deleteById(id);
//    }
//}
package com.spring.service.impl;

import com.spring.model.Product;
import com.spring.repository.ProductRepository;
import com.spring.service.ProductService;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {

    private final ProductRepository productRepository;

    @Override
    public Product create(Product product) {
        if (productRepository.existsByName(product.getName())) {
            throw new IllegalArgumentException("Product with name '" + product.getName() + "' already exists.");
        }
        return productRepository.save(product);
    }

    @Override
    public Product update(Long id, Product product) {
        Product existing = productRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Product not found with id: " + id));

        existing.setName(product.getName());
        existing.setDescription(product.getDescription());
        existing.setPrice(product.getPrice());
        existing.setStock(product.getStock());
        existing.setDiscount(product.getDiscount());
        existing.setCategory(product.getCategory());
        existing.setSubCategory(product.getSubCategory());
        existing.setImage_url(product.getImage_url());
       // existing.setRatings(product.getRatings()); // ✅ Set ratings list
        existing.setUpdatedByCode(product.getUpdatedByCode());
        existing.setUpdatedByName(product.getUpdatedByName());

        return productRepository.save(existing);
    }

    @Override
    public Optional<Product> getById(Long id) {
        return productRepository.findById(id);
    }

    @Override
    public List<Product> getAll() {
        return productRepository.findAll();
    }

    @Override
    public void delete(Long id) {
        if (!productRepository.existsById(id)) {
            throw new EntityNotFoundException("Product not found with id: " + id);
        }
        productRepository.deleteById(id);
    }
}
