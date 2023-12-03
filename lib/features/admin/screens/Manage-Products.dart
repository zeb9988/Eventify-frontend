import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/features/admin/All-Products/Branding_marketing.dart';
import 'package:eventify/features/admin/All-Products/Decorator.dart';
import 'package:eventify/features/admin/All-Products/Entertainer.dart';
import 'package:eventify/features/admin/All-Products/Florist.dart';
import 'package:eventify/features/admin/All-Products/Invitation_print.dart';
import 'package:eventify/features/admin/All-Products/Jewelry_store.dart';
import 'package:eventify/features/admin/All-Products/Makeup_Salon.dart';
import 'package:eventify/features/admin/All-Products/Mehndi.dart';
import 'package:eventify/features/admin/All-Products/Security_Service.dart';
import 'package:eventify/features/admin/All-Products/Sound_light.dart';
import 'package:eventify/features/admin/All-Products/Ticketing.dart';
import 'package:eventify/features/admin/All-Products/Transport.dart';
import 'package:eventify/features/admin/All-Products/Videographer.dart';
import 'package:eventify/features/admin/All-Products/WeddingCar_Decorator.dart';
import 'package:eventify/features/admin/All-Products/Wedding_Dress.dart';
import 'package:eventify/msgservicee.dart';
import 'package:flutter/material.dart';
import '../All-Products/Catering.dart';
import '../All-Products/Event_Planner.dart';
import '../All-Products/Party_Planner.dart';
import '../All-Products/Venues.dart';
import '../All-Products/Wedding_Planner.dart';
import '../All-Products/Photographer.dart';

class Manage_Product extends StatefulWidget {
  static const String id = '/ManageProduct';

  const Manage_Product({Key? key}) : super(key: key);

  @override
  State<Manage_Product> createState() => _Manage_ProductState();
}

class _Manage_ProductState extends State<Manage_Product>
    with TickerProviderStateMixin {
  late TabController _tabController;
  MessagingService msgservice = MessagingService();
  @override
  void initState() {
    super.initState();
    msgservice.init(context);
    _tabController = TabController(length: 21, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_PRIMARY,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: Text(
            'All Services',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                // Adjust left padding
                child: FilterTab(
                  iconData: Icons.filter_list,
                  // Use the desired filter icon
                  onTap: () {
                    // Add your filter logic here
                  },
                ),
              ),
              Expanded(
                child: Container(
                  height: 50,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CustomTab(
                          text: 'Photographer',
                          index: 0,
                          tabController: _tabController,
                        ),
                        CustomTab(
                          text: 'Videographer',
                          index: 1,
                          tabController: _tabController,
                        ),
                        CustomTab(
                          text: 'Catering',
                          index: 2,
                          tabController: _tabController,
                        ),
                        CustomTab(
                          text: 'Florists',
                          index: 3,
                          tabController: _tabController,
                        ),
                        CustomTab(
                          text: 'Entertainer',
                          index: 4,
                          tabController: _tabController,
                        ),
                        CustomTab(
                          text: 'Transportation Service',
                          index: 5,
                          tabController: _tabController,
                        ),
                        CustomTab(
                          text: 'Sound & Lighting',
                          index: 6,
                          tabController: _tabController,
                        ),
                        CustomTab(
                          text: 'Security Service',
                          index: 7,
                          tabController: _tabController,
                        ),
                        CustomTab(
                          text: 'Event Invitations and Printing',
                          index: 8,
                          tabController: _tabController,
                        ),
                        CustomTab(
                          text: 'Ticketing and Promotion',
                          index: 9,
                          tabController: _tabController,
                        ),
                        CustomTab(
                          text: 'Branding & Marketing',
                          index: 10,
                          tabController: _tabController,
                        ),
                        CustomTab(
                          text: 'Party Planner',
                          index: 11,
                          tabController: _tabController,
                        ),
                        CustomTab(
                          text: 'Event Planner',
                          index: 12,
                          tabController: _tabController,
                        ),
                        CustomTab(
                          text: 'Venues',
                          index: 13,
                          tabController: _tabController,
                        ),
                        CustomTab(
                          text: 'Wedding Planner',
                          index: 14,
                          tabController: _tabController,
                        ),
                        CustomTab(
                          text: 'Makeup Artist & Salon',
                          index: 15,
                          tabController: _tabController,
                        ),
                        CustomTab(
                          text: 'Mehndi Artist',
                          index: 16,
                          tabController: _tabController,
                        ),
                        CustomTab(
                          text: 'Decorator',
                          index: 17,
                          tabController: _tabController,
                        ),
                        CustomTab(
                          text: 'Jewelry Store',
                          index: 18,
                          tabController: _tabController,
                        ),
                        CustomTab(
                          text: 'Wedding Car Decorators',
                          index: 19,
                          tabController: _tabController,
                        ),
                        CustomTab(
                          text: 'Wedding Dress Boutique',
                          index: 20,
                          tabController: _tabController,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: TabBarView(
                controller: _tabController,
                children: [
                  Photographer(),
                  Videographer(),
                  Cataring(),
                  Florist(),
                  Entertainer(),
                  Transport(),
                  SoundLight(),
                  Security(),
                  InvitationPrint(),
                  Ticket(),
                  Branding(),
                  PartyPlanner(),
                  EventPlanner(),
                  Venues(),
                  WeddingPlanner(),
                  Makeup(),
                  Mehndi(),
                  Decorator(),
                  Jewelry(),
                  WedCarDecore(),
                  WedDress()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FilterTab extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onTap;

  FilterTab({
    required this.iconData, // Pass the icon data
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5), // Customize the border radius
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Customize the shadow color
            spreadRadius: 2, // Customize the shadow spread radius
            blurRadius: 4, // Customize the shadow blur radius
            offset: Offset(0, 2), // Customize the shadow offset
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Icon(
              iconData, // Use the provided icon data
              size: 24, // Customize the icon size
              color: Colors.black, // Customize the icon color
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTab extends StatefulWidget {
  final String text;
  final int index;
  final TabController tabController;

  CustomTab({
    required this.text,
    required this.index,
    required this.tabController,
  });

  @override
  _CustomTabState createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab> {
  Color _backgroundColor = Colors.transparent;
  Color _textColor = Colors.black;

  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(_handleTabControllerChange);
  }

  @override
  void dispose() {
    widget.tabController.removeListener(_handleTabControllerChange);
    super.dispose();
  }

  void _handleTabControllerChange() {
    if (widget.tabController.index == widget.index) {
      setState(() {
        _backgroundColor = COLOR_ACCENT;
        _textColor = Colors.black;
      });
    } else {
      setState(() {
        _backgroundColor = Colors.transparent;
        _textColor = Colors.black;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.tabController.animateTo(widget.index);
      },
      splashColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _backgroundColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: _textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 16,
                right: 16,
                child: AnimatedContainer(
                  height: 2,
                  duration: Duration(milliseconds: 300),
                  color: _backgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// body: SingleChildScrollView(
//   child: Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Column(
//       children: [
//         Align(
//           alignment: Alignment.topLeft,
//           child: Text(
//             'Event Planning',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.deepPurple,
//               // Adjust the color as needed
//               letterSpacing: 1.2,
//               shadows: [
//                 Shadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   blurRadius: 2,
//                   offset: Offset(2, 2),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Divider(
//           color: Colors.purple,
//           thickness: 2,
//           indent: 3,
//           endIndent: 3,
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Wedding_Planner(),
//         SizedBox(
//           height: 20,
//         ),
//         Event_Planner(),
//         SizedBox(
//           height: 20,
//         ),
//         Party_Planner(),
//         SizedBox(
//           height: 20,
//         ),
//         Corpevent_planner(),
//         SizedBox(
//           height: 20,
//         ),
//
//         //Event Designing & Decor
//
//         Align(
//           alignment: Alignment.topLeft,
//           child: Text(
//             'Event Designing & Decor',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.deepPurple,
//               // Adjust the color as needed
//               letterSpacing: 1.2,
//               shadows: [
//                 Shadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   blurRadius: 2,
//                   offset: Offset(2, 2),
//                 ),
//               ],
//             ),
//           ),
//         ),
//
//         Divider(
//           color: Colors.purple,
//           thickness: 2,
//           indent: 3,
//           endIndent: 3,
//         ),
//
//         SizedBox(
//           height: 10,
//         ),
//
//         Interior_Designer(),
//         SizedBox(
//           height: 20,
//         ),
//         Wedd_Houselight(),
//         SizedBox(
//           height: 20,
//         ),
//         Wedd_Cards(),
//         SizedBox(
//           height: 20,
//         ),
//         Wedd_Car_Decor(),
//         SizedBox(
//           height: 20,
//         ),
//         // Others Services
//
//         Align(
//           alignment: Alignment.topLeft,
//           child: Text(
//             'Others',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.deepPurple,
//               // Adjust the color as needed
//               letterSpacing: 1.2,
//               shadows: [
//                 Shadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   blurRadius: 2,
//                   offset: Offset(2, 2),
//                 ),
//               ],
//             ),
//           ),
//         ),
//
//         Divider(
//           color: Colors.purple,
//           thickness: 2,
//           indent: 3,
//           endIndent: 3,
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Photographers(Productlist: Photographerlist),
//         SizedBox(
//           height: 20,
//         ),
//         Car_rent(),
//         SizedBox(
//           height: 20,
//         ),
//         Cataring(),
//         SizedBox(
//           height: 20,
//         ),
//         Multi_Media(),
//         SizedBox(
//           height: 20,
//         ),
//
//         Venues(),
//       ],
//     ),
//   ),
// ));
