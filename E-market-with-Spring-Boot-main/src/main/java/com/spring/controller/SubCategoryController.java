package com.spring.controller;

import com.spring.model.SubCategory;
import com.spring.service.SubCategoryService;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/sub-categories")
@CrossOrigin(origins = "*")
@RequiredArgsConstructor
public class SubCategoryController {

    private final SubCategoryService subCategoryService;

    @PostMapping
    public ResponseEntity<SubCategory> create(@RequestBody SubCategory subCategory) {
        return ResponseEntity.ok(subCategoryService.save(subCategory));
    }

    @PutMapping("/{id}")
    public ResponseEntity<SubCategory> update(@PathVariable Long id, @RequestBody SubCategory subCategory) {
        return ResponseEntity.ok(subCategoryService.update(id, subCategory));
    }

    @GetMapping("/{id}")
    public ResponseEntity<SubCategory> getById(@PathVariable Long id) {
        return subCategoryService.findById(id)
                .map(ResponseEntity::ok)
                .orElseThrow(() -> new EntityNotFoundException("SubCategory not found with id: " + id));
    }

    @GetMapping
    public ResponseEntity<List<SubCategory>> getAll() {
        return ResponseEntity.ok(subCategoryService.findAll());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        subCategoryService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
