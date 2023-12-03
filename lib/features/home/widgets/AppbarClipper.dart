// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(0, size.height - 40, 20, size.height - 40);
    path.lineTo(size.width - 20, size.height - 40);
    path.quadraticBezierTo(
        size.width, size.height - 40, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}