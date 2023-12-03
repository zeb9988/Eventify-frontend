// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'dart:developer';
// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:eventify/features/home/screens/registratinverndor.dart';
import 'package:eventify/features/home/screens/Favourite.dart';
import 'package:eventify/features/Booking/BookingHistory.dart';

import 'package:eventify/features/home/screens/vendor_register.dart';
// import 'package:eventify/widgets/card.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eventify/msgservicee.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:user_panel/home_screen/card.dart';
// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import '../../../constant/Theme_constant.dart';
import '../../admin/screens/adminOrderPage.dart';
import 'DashPage.dart';
import 'MenuScreen.dart';

class Homepage extends StatefulWidget {
  static const String id = '/Dashboard2';
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int maxCount = 3;
  int _page = 0;
  final List pages = [
    // SafeArea(child: DashPage()),
    DashPage(),
    OrderHistory(),
    Favourite(),
    MenuScreen(),
  ];

  void Updatepage(int page) {
    setState(() {
      _page = page;
    });
  }

  MessagingService msgservice = MessagingService();
  @override
  void initState() {
    msgservice.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: pages[_page],
          bottomNavigationBar: CurvedNavigationBar(
            buttonBackgroundColor: Colors.white,
            color: Colors.white,
            animationCurve: Curves.easeInOut,
            backgroundColor: COLOR_PRIMARY, // Set to transparent

            items: <Widget>[
              Image.asset(
                'assets/images/home.png',
                height: 30,
                color: COLOR_ACCENT,
              ),
              Image.asset(
                'assets/images/checklist.png',
                height: 30,
                color: COLOR_ACCENT,
              ),
              Image.asset(
                'assets/images/hearttt.png',
                height: 30,
                color: COLOR_ACCENT,
              ),
              Icon(
                FontAwesomeIcons.user,
                size: 25,
                color: COLOR_ACCENT,
              ),
            ],
            onTap: Updatepage,
          )),
    );
  }
}
