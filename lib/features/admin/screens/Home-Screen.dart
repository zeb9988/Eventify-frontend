import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eventify/features/account/services/accountservices.dart';
import 'package:eventify/features/admin/screens/Admin-Dashboard.dart';
import 'package:eventify/features/admin/screens/analyticsScreen.dart';
import 'package:eventify/features/admin/screens/sendNotfication.dart';
import 'package:eventify/prooviders/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constant/Theme_constant.dart';
import 'adminOrderPage.dart';
// import '../../home/screens/DashPage.dart';

class Adminscreen extends StatefulWidget {
  static const String id = '/Admin';

  const Adminscreen({Key? key}) : super(key: key);

  @override
  State<Adminscreen> createState() => _AdminscreenState();
}

class _AdminscreenState extends State<Adminscreen> {
  @override
  void initState() {
    super.initState();
  }

  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  int _page = 0;
  final List pages = [
    // SafeArea(child: DashPage()),
    const Admin_Dashboard(),
    const AdminOrderScreen(),
    const AnalyticsScreen(),
    const SendNotifications(),
  ];

  void Updatepage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        backgroundColor: COLOR_ACCENT,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () => logOut(context),
                    child: const Icon(
                      Icons.logout,
                      size: 30,
                    )),
              )
            ],
            title: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Image.asset('assets/images/logo.png', height: 100),
            )
            // width: 70, // Adjust the width as needed
            // height: 70, // Adjust the height as needed
            ,
            centerTitle: true,
          ),
        ),
        body: pages[_page],
        bottomNavigationBar: CurvedNavigationBar(
          color: COLOR_PRIMARY,
          buttonBackgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          backgroundColor: COLOR_PRIMARY,
          // Set to transparent
          items: const <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.pending_actions_sharp, size: 30),
            Icon(
              Icons.analytics,
              size: 30,
            ),
            Icon(Icons.notification_add, size: 30),
          ],
          onTap: Updatepage,
        ));
  }
}
