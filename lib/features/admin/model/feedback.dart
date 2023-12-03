import 'dart:convert';

class Feedbacks {
  final String userId;
  final String username;
  final double rating;
  final String feedback;
  Feedbacks(
      {required this.userId,
      required this.username,
      required this.rating,
      required this.feedback});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'rating': rating,
      'feedback': feedback,
    };
  }

  factory Feedbacks.fromMap(Map<String, dynamic> map) {
    return Feedbacks(
      userId: map['userId'] ?? '',
      username: map['username'] ?? '',
      feedback: map['feedback'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Feedbacks.fromJson(String source) =>
      Feedbacks.fromMap(json.decode(source));
}
