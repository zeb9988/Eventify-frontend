import 'package:eventify/Features/Booking/BookingScreen.dart';
import 'package:eventify/Language/language_constants.dart';
import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/features/Feedback/Feedback.dart';
import 'package:eventify/features/checklist/Checklist.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../screens/About.dart';
import '../screens/Allcatagory.dart';
import '../../Favroute/Favourite.dart';
import 'DashboardSubcard.dart';

class dashcard extends StatelessWidget {
  const dashcard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
            ),
          ],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.menu, color: COLOR_ACCENT), // Menu icon
                  const SizedBox(width: 8), // Add spacing between icon and text
                  Text(
                    AppLocalizations.of(context)!.dashboard,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              const Divider(thickness: 1, color: Colors.black), // Add a Divider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SubCard(
                    onPressed: () {
                      Navigator.pushNamed(context, OrderScreen.id);
                    },
                    image: 'assets/images/booking.png',
                    text: translation(context).booking,
                  ),
                  SubCard(
                    onPressed: () {
                      Navigator.pushNamed(context, AllCatagory.id);
                    },
                    image: 'assets/images/vendor1.png',
                    text: translation(context).vendor,
                  ),
                  SubCard(
                    onPressed: () {
                      Navigator.pushNamed(context, ChecklistScreen.id);
                    },
                    image: 'assets/images/checklist.png',
                    text: translation(context).checklist,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SubCard(
                    onPressed: () {
                      Navigator.pushNamed(context, Favourite.id);
                    },
                    image: 'assets/images/hearttt.png',
                    text: translation(context).favorite,
                  ),
                  SubCard(
                    onPressed: () {
                      Navigator.pushNamed(context, FeedbackScreen.id);
                    },
                    image: 'assets/images/feedback.png',
                    text: translation(context).feedback,
                  ),
                  SubCard(
                    onPressed: () {
                      Navigator.pushNamed(context, PolicyScreen.id);
                    },
                    image: 'assets/images/about.png',
                    text: translation(context).about,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
