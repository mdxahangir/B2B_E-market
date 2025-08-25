import 'package:e_market/models/user.dart';

class Rating {
  final int id;
  final int rating;
  final String? review;
  final DateTime createdAt;
  final User? user;

  Rating({
    required this.id,
    required this.rating,
    this.review,
    required this.createdAt,
    this.user,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['id'],
      rating: json['rating'],
      review: json['review'],
      createdAt: DateTime.parse(json['createdAt']),
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  // ✅ এটা ক্লাসের ভেতরেই রাখতে হবে
  Map<String, dynamic> toJson(int userId, int productId) {
    return {
      'rating': rating,
      'review': review,
      'userId': userId,
      'productId': productId,
    };
  }
}
