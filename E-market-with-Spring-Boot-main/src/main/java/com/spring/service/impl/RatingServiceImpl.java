package com.spring.service.impl;

import com.spring.model.Rating;
import com.spring.repository.RatingRepository;
import com.spring.service.RatingService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class RatingServiceImpl implements RatingService {

    private final RatingRepository ratingRepository;

    @Override
    public Rating saveRating(Rating rating) {
        return ratingRepository.save(rating);
    }

    @Override
    public List<Rating> getAllRatings() {
        return ratingRepository.findAll();
    }

    @Override
    public Optional<Rating> getRatingById(Long id) {
        return ratingRepository.findById(id);
    }

    @Override
    public Rating updateRating(Long id, Rating rating) {
        return ratingRepository.findById(id)
                .map(existing -> {
                    existing.setRating(rating.getRating());
                    existing.setReview(rating.getReview());
                    existing.setUser(rating.getUser());
                    existing.setProduct(rating.getProduct());
                    return ratingRepository.save(existing);
                }).orElseThrow(() -> new RuntimeException("Rating not found"));
    }

    @Override
    public void deleteRating(Long id) {
        ratingRepository.deleteById(id);
    }
}
