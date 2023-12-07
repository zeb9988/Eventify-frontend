import 'package:eventify/features/checklist/Checklist.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../constant/Theme_constant.dart';
import '../../Notification/msgservicee.dart';
import 'DashPage.dart';
import '../../Favroute/Favourite.dart';
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
    ChecklistScreen(),
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
