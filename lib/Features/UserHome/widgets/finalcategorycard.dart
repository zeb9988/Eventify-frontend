import 'package:eventify/constant/Theme_constant.dart';
import 'package:flutter/material.dart';

class Finalcat extends StatelessWidget {
  final String image;
  final String name;
  final String description;
  final VoidCallback press;
  final bool isHotDeal; // Add a flag to determine if it's a hot deal

  const Finalcat({
    required this.image,
    required this.name,
    required this.description,
    required this.press,
    this.isHotDeal = true, // Default is not a hot deal
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        height: 250,
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200, width: 1),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 110,
                  color: Colors.white,
                  width: double.infinity,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        description,
                        maxLines: 3,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            if (isHotDeal) // Display "Hot Deal" label if it's a hot deal
              Positioned(
                top: 70,
                right: 5,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Text(
                    '🔥 Hot Deal',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
