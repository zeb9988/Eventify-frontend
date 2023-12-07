import 'package:flutter/material.dart';

class Subcard2 extends StatefulWidget {
  final String image;
  final String text;
  final VoidCallback onPressed; // Add this line


  const Subcard2({Key? key, required this.image, required this.text, required this.onPressed}) : super(key: key);

  @override
  State<Subcard2> createState() => _Subcard2State();
}

class _Subcard2State extends State<Subcard2> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(right: 10),
        child: Stack(
          children: [
            Container(
              width: 120,
              height: 60,
              child: Image.asset(

                widget.image,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                ),
                child: Center(
                  child: Text(widget.text, textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
                ),
              ),
            )
          ],
        ),
      ),
    );;
  }
}
