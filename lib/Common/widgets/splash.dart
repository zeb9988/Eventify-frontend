import 'dart:async';

import 'package:eventify/common/widgets/Loader.dart';
import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/prooviders/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Features/authentication/screens/Landing_page.dart';
import '../../Features/UserHome/screens/home_screen.dart';
import '../../features/Notification/msgservicee.dart';
import '../../features/admin/screens/Home-Screen.dart';
import '../../features/authentication/screens/IntroScreen.dart';
import '../../features/authentication/services/authservices.dart';

class SplashScreen extends StatefulWidget {
  static const String id = '/splash';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService auth = AuthService();
  MessagingService messagingService = MessagingService();
  @override
  void initState() {
    super.initState();
    messagingService.init(context);
    auth.getUserData(context);
    Timer(const Duration(seconds: 5), () {
      Provider.of<UserProvider>(context, listen: false).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context, listen: false).user.type ==
                  "admin"
              ? Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AdminHomeScreen()))
              : checkScreen()
          : Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LandingPage()));
    });
  }

  void checkScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasSeenIntro = prefs.getBool('hasSeenIntro') ?? false;
    if (!hasSeenIntro) {
      // User hasn't seen the intro screen yet
      prefs.setBool('hasSeenIntro', true);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => IntroScreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Homepage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [COLOR_ACCENT, Colors.black],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/logo2.png',
                width: 150,
                height: 150,
              ),
              SizedBox(height: 20),
              Loader(), // Optional: Add a progress indicator
            ],
          ),
        ),
      ),
    );
  }
}
