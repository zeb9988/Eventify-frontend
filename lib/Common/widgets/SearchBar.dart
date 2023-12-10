// ignore: file_names
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const CustomSearchBar({
    Key? key,
    required this.hintText,
    required this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: TextField(
          controller: controller,
          onChanged: onChanged, // Add the onChanged callback here
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            icon: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
