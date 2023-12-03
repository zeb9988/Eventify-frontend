import 'package:eventify/constant/Theme_constant.dart';
import 'package:flutter/material.dart';

class TotalEarningsCard extends StatelessWidget {
  final double? totalSales;
  final String text;
  const TotalEarningsCard({
    Key? key,
    required this.totalSales,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
       Card(
         color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Adjust the radius as needed
        ),
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),

          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(child: Text(
    'Rs: ${totalSales!.toStringAsFixed(0)}',
    style: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.blue, // Adjust the color as needed
    ),
    ), )

            ],
          ),
        ),
      );

  }
}
