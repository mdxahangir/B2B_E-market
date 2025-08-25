package com.spring.service;

import com.spring.model.Category;

import java.util.List;
import java.util.Optional;

public interface CategoryService {
    Category createCategory(Category category);
    Category updateCategory(Long id, Category category);
    void deleteCategory(Long id);
    Optional<Category> getCategoryById(Long id);
    List<Category> getAllCategories();
}
