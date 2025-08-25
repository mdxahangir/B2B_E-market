package com.spring.service.impl;

import com.spring.model.SubCategory;
import com.spring.repository.SubCategoryRepository;
import com.spring.service.SubCategoryService;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class SubCategoryServiceImpl implements SubCategoryService {

    private final SubCategoryRepository subCategoryRepository;

    @Override
    public SubCategory save(SubCategory subCategory) {
        if (subCategoryRepository.existsByName(subCategory.getName())) {
            throw new IllegalArgumentException("SubCategory with name '" + subCategory.getName() + "' already exists.");
        }
        return subCategoryRepository.save(subCategory);
    }

    @Override
    public SubCategory update(Long id, SubCategory subCategory) {
        SubCategory existing = subCategoryRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("SubCategory not found with id: " + id));

        existing.setName(subCategory.getName());
        existing.setDescription(subCategory.getDescription());
        existing.setCategory(subCategory.getCategory());
        existing.setUpdatedByCode(subCategory.getUpdatedByCode());
        existing.setUpdatedByName(subCategory.getUpdatedByName());

        return subCategoryRepository.save(existing);
    }

    @Override
    public Optional<SubCategory> findById(Long id) {
        return subCategoryRepository.findById(id);
    }

    @Override
    public List<SubCategory> findAll() {
        return subCategoryRepository.findAll();
    }

    @Override
    public void deleteById(Long id) {
        if (!subCategoryRepository.existsById(id)) {
            throw new EntityNotFoundException("SubCategory not found with id: " + id);
        }
        subCategoryRepository.deleteById(id);
    }
}
