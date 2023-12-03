import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesWidget extends StatelessWidget {
  final String CategorieName;
  final String image;

  CategoriesWidget({required this.CategorieName, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Text(
            CategorieName,
            style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight:
                    FontWeight.w600), // You can adjust the text style as needed
          ),
          const SizedBox(
            width: 2,
          ),
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(image),
                    filterQuality: FilterQuality.high)),
          ),
          Spacer(),
          Text(
            "View All",
            style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight:
                    FontWeight.w500), // You can adjust the text style as needed
          ),
          const SizedBox(
            width: 5,
          ),
          Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black45,
                ),
                shape: BoxShape.circle),
            child: const Icon(
              Icons.arrow_forward_ios,
              size: 8,
            ),
          )
        ],
      ),
    );
  }
}
