import 'package:eventify/constant/Theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../UserHome/screens/home_screen.dart';

class IntroScreen extends StatelessWidget {
  IntroScreen({Key? key}) : super(key: key);

  final List<PageViewModel> pages = [
    PageViewModel(
      title: 'Discover Exciting Events',
      body:
          'Explore and connect with a world of exciting events and people who share your passions.',
      image: Center(
        child: Image.asset('assets/images/img1.jpg'),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
        ),
        bodyTextStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.grey,
        ),
      ),
    ),
    PageViewModel(
      title: 'Have Access Everywhere!',
      body: 'Access your events and activities from anywhere, anytime.',
      image: Center(
        child: Image.asset('assets/images/img2.jpg'),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
        ),
        bodyTextStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.grey,
        ),
      ),
    ),
    PageViewModel(
      title: 'Get Started Now!',
      body: 'Start exploring and enjoying Eventify today!',
      image: Center(
        child: Image.asset('assets/images/img3.jpg'),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
        ),
        bodyTextStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.grey,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        pages: pages,
        dotsDecorator: DotsDecorator(
          size: const Size.square(10),
          color: Colors.black26,
          activeSize: const Size(20, 10),
          activeColor: COLOR_ACCENT,
          spacing: const EdgeInsets.symmetric(horizontal: 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        showDoneButton: true,
        done: const Text(
          'Done',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: COLOR_ACCENT),
        ),
        showSkipButton: true,
        skip: const Text(
          'Skip',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: COLOR_ACCENT),
        ),
        showNextButton: true,
        next: const Icon(
          Icons.arrow_forward,
          size: 25,
          color: COLOR_ACCENT,
        ),
        onDone: () => onDone(context),
        curve: Curves.easeInOut,
      ),
    );
  }

  void onDone(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ON_BOARDING', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Homepage()),
    );
  }
}
