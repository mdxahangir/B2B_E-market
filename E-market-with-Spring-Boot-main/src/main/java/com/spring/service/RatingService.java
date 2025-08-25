package com.spring.service;

import com.spring.model.Rating;

import java.util.List;
import java.util.Optional;

public interface RatingService {
    Rating saveRating(Rating rating);
    List<Rating> getAllRatings();
    Optional<Rating> getRatingById(Long id);
    Rating updateRating(Long id, Rating rating);
    void deleteRating(Long id);
}
