import 'dart:convert';

class Rating {
  final String userId;
  final String username;
  final double rating;
  final String feedback;
  Rating(
      {required this.userId,
      required this.username,
      required this.rating,
      required this.feedback});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'rating': rating,
      'feedback': feedback
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
        userId: map['userId'] ?? '',
        username: map['username'] ?? '',
        rating: map['rating']?.toDouble() ?? 0.0,
        feedback: map['feedback'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory Rating.fromJson(String source) => Rating.fromMap(json.decode(source));
}
