package com.spring.service;

import com.spring.model.SubCategory;

import java.util.List;
import java.util.Optional;

public interface SubCategoryService {
    SubCategory save(SubCategory subCategory);
    SubCategory update(Long id, SubCategory subCategory);
    Optional<SubCategory> findById(Long id);
    List<SubCategory> findAll();
    void deleteById(Long id);
}
