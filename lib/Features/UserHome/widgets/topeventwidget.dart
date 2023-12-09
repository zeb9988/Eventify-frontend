import 'package:eventify/Features/UserHome/screens/mainEventscreen.dart';
import 'package:eventify/Language/language_constants.dart';
import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'TopEventCard.dart';

class topeventcards extends StatelessWidget {
  const topeventcards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 20),
      height: 200,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                translation(context).topevent,
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight
                        .w600), // You can adjust the text style as needed
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width:
                MediaQuery.of(context).size.width, // Adjust the width as needed
            height: 140,
            decoration: BoxDecoration(
              color: COLOR_PRIMARY,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: TopEventList.length,
              itemBuilder: (context, index) {
                final cardData = TopEventList[index];
                return TopEventCard(
                    onTap: () {
                      Navigator.pushNamed(context, MainEvent.id,
                          arguments: cardData['text']);
                    },
                    title: cardData['text'],
                    color: cardData['color'],
                    image: cardData['image']);
              },
            ),
          ),
        ],
      ),
    );
  }
}
