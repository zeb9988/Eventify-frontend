// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant/Theme_constant.dart';


class SubCard extends StatefulWidget {
  final String image;
  final String text;
  final VoidCallback onPressed; // Add this line

  const SubCard(
      {Key? key, required this.image,
        required this.text,
        required this.onPressed}) : super(key: key); // Update the constructor

  @override
  _SubCardState createState() => _SubCardState();
}

class _SubCardState extends State<SubCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Wrap with GestureDetector to handle taps
      onTap: widget.onPressed, // Call the provided onPressed function
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
              width: 50.0,
              height: 60.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: COLOR_PRIMARY,
              ),
              child: Center(
                child: Image.asset(
                  widget.image,
                  width: 40.0,
                  height: 40.0,
                  fit: BoxFit.contain,
                  color: COLOR_ACCENT,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Center(
              child: Text(
                widget.text,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
