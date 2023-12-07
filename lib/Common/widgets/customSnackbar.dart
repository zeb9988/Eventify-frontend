// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../constant/Theme_constant.dart';

void showCustomSnackBar({
  required BuildContext context,
  required String text,
  required String label,
  required VoidCallback onPressed,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: COLOR_ACCENT,
      action: SnackBarAction(
        backgroundColor: Colors.white,
        textColor: Colors.black,
        label: label,
        onPressed: onPressed,
      ),
      content: Text(text),
      duration: const Duration(milliseconds: 3000),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 80, left: 15, right: 15),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
