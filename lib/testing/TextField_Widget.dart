import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Text_Field_Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(31, 173, 173, 173),
                blurRadius: 15,
                spreadRadius: 1,
                offset: Offset(0, 10),
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            const SizedBox(
              width: 5,
            ),
            Icon(Icons.search),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Search Item",
              style: GoogleFonts.poppins(fontSize: 15, color: Colors.black54),
            ),
            const Spacer(),
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.1,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(31, 145, 144, 144),
                  borderRadius: BorderRadius.circular(30)),
              child: const Icon(
                Icons.document_scanner,
                color: Colors.black54,
                size: 20,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
