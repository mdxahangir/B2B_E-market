import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/rating.dart';

class RatingService {
  static const String baseUrl = 'http://localhost:8080/api/ratings';

  static Future<List<Rating>> getByProduct(int productId) async {
    final response = await http.get(Uri.parse('$baseUrl?productId=$productId'));
    if (response.statusCode == 200) {
      final List jsonList = jsonDecode(response.body);
      return jsonList.map((e) => Rating.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load ratings');
    }
  }

  static Future<void> createRating({
    required int productId,
    required int rating,
    required String review,
    int userId = 1, 
  }) async {
    final ratingData = Rating(
      id: 0,
      rating: rating,
      review: review,
      createdAt: DateTime.now(),
      user: null,
    );

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(ratingData.toJson(userId, productId)),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to submit rating');
    }
  }
}
