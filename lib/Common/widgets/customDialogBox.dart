// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import '../../constant/Theme_constant.dart';
import 'custombutton.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<CustomButton> buttons;

  const CustomDialog({
    Key? key,
    required this.title,
    required this.icon,
    required this.buttons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.4,
        height: MediaQuery.of(context).size.height / 3.5,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.1)),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                backgroundColor: COLOR_ACCENT,
                radius: 25,
                child: Icon(
                  icon,
                  color: Colors.white,
                )),
            SizedBox(
              height: 15,
            ),
            if (title.isNotEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            const SizedBox(
              height: 10,
            ),
            if (buttons.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: buttons,
              ),
          ],
        ),
      ),
    );
  }
}
