import 'package:flutter/material.dart';

class SubCard1 extends StatefulWidget {
  final String image;
  final String text;
  final VoidCallback onPressed; // Add this line

  const SubCard1(
      {required this.image,
        required this.text,
        required this.onPressed}); // Update the constructor

  @override
  _SubCard1State createState() => _SubCard1State();
}

class _SubCard1State extends State<SubCard1> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60.0,
              height: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              child: Center(
                child: Image.asset(
                  widget.image,
                  width: 40.0,
                  height: 40.0,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              width: 80.0, // Adjust the width as needed
              child: Center(
                child: Text(
                  widget.text,
                  textAlign: TextAlign.center, // Center-align the text
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
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