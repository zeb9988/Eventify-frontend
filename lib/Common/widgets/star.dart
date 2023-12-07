import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Star extends StatelessWidget {
  final double rating;
  const Star({required this.rating});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      itemSize: 20,
      direction: Axis.horizontal,
      itemCount: 5,
      rating: rating,
      itemBuilder: (context, index) {
        return const Icon(
          Icons.star,
          color: Colors.yellow,

        );
      },
    );
  }
}
