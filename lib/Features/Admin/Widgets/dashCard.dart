import 'package:flutter/material.dart';

class dashCard extends StatelessWidget {
  final String text;
  final String image;
  const dashCard({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 160, // Adjust the fraction as needed
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Color(0x1F6E9AE6),
            offset: Offset(0, 12),
            blurRadius: 20,
            spreadRadius: 0.05,
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        children: [
          Expanded(child: Image.asset(image)),
          Text(
            text,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
