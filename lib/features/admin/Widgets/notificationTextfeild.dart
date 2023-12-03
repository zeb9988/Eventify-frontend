import 'package:eventify/constant/Theme_constant.dart';
import 'package:flutter/material.dart';

class notificationfeild extends StatelessWidget {
  const notificationfeild({
    Key? key,
    required TextEditingController titleController,
  })  : _titleController = titleController,
        super(key: key);

  final TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 1,
      controller: _titleController,
      decoration: InputDecoration(
        labelText: 'Enter Title',
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        prefixIcon: const Icon(
          Icons.notification_important,
          color: COLOR_ACCENT,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: COLOR_ACCENT),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: COLOR_ACCENT),
          borderRadius: BorderRadius.circular(8.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: COLOR_ACCENT),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
