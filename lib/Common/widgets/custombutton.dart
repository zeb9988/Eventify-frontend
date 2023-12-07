
import 'package:eventify/constant/Theme_constant.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(

        child: Text(
          text,
        ),
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder( 
            borderRadius: BorderRadius.circular(5)
          ),
          foregroundColor: Colors.white,
minimumSize: Size(100, 40),
            backgroundColor: COLOR_ACCENT),
      ),
    );
  }
}
