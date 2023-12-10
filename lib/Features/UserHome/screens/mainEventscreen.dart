// ignore: file_names
import 'package:eventify/Constant/Theme_constant.dart';
import 'package:eventify/common/widgets/SearchBar.dart';
import 'package:eventify/features/product_details/Vendor_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constant/constant.dart';
import '../../../prooviders/provider.dart';
import '../widgets/finalcategorycard.dart';

class MainEvent extends StatefulWidget {
  final String category;
  static const String id = '/Maincategory';

  const MainEvent({Key? key, required this.category}) : super(key: key);

  @override
  State<MainEvent> createState() => _MainEventState();
}

class _MainEventState extends State<MainEvent> {
  List<Map<String, dynamic>> finalList = [];
  List<Map<String, dynamic>> filteredEvents = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.category == 'Wedding') {
      finalList = Wedding;
    } else if (widget.category == 'Birthday Party') {
      finalList = Birthdayparty;
    } else if (widget.category == 'Corporate Event') {
      finalList = CorporateEvent;
    } else if (widget.category == 'Concert') {
      finalList = Concert;
    } else if (widget.category == 'Private Party') {
      finalList = PrivateParty;
    } else if (widget.category == 'Eid Celebration') {
      finalList = EidCelebration;
    } else if (widget.category == 'Cultural Festival') {
      finalList = CulturalFestival;
    } else {
      finalList = Wedding; // Default case
    }

    filteredEvents = finalList;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterEvents(String query) {
    setState(() {
      filteredEvents = finalList
          .where((event) =>
              event['text']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartlen = context.watch<UserProvider>().user.cart.length;

    String pic = '';
    if (widget.category == 'Wedding') {
      finalList = Wedding;
      pic = 'assets/images/wedding.jpg';
    } else if (widget.category == 'Birthday Party') {
      finalList = Birthdayparty;
      pic = 'assets/images/party.jpg';
    } else if (widget.category == 'Corporate Event') {
      finalList = CorporateEvent;
      pic = 'assets/images/corevent.jpg';
    } else if (widget.category == 'Concert') {
      finalList = Concert;
      pic = 'assets/images/concert1.jpg';
    } else if (widget.category == 'Private Party') {
      finalList = PrivateParty;
      pic = 'assets/images/party.jpg';
    } else if (widget.category == 'Eid Celebration') {
      finalList = EidCelebration;
      pic = 'assets/images/eidcele.jpeg';
    } else if (widget.category == 'Cultural Festival') {
      finalList = CulturalFestival;
      pic = 'assets/images/culture.jpg';
    } else {
      // Default case: Set finalcard to a default list (you can adjust this based on your requirements)
      finalList = Wedding;
      pic = 'assets/images/wedding.jpg';
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: COLOR_PRIMARY,
        body: Column(
          children: [
            Material(
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(pic),
                  fit: BoxFit.cover,
                )),
                child: Container(
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(begin: Alignment.bottomRight, colors: [
                    Colors.black.withOpacity(.8),
                    Colors.black.withOpacity(.4),
                  ])),
                  child: Column(children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        buildCustomBackButton(context),
                        CartButton(context, cartlen, Colors.white),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white, // Border color
                          width: 1.0, // Border width
                        ),
                        borderRadius:
                            BorderRadius.circular(5.0), // Border radius
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Text(
                        widget.category,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomSearchBar(
                      onChanged: filterEvents,
                      hintText: 'Search...',
                      controller: searchController,
                    )
                  ]),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of items in each row
                crossAxisSpacing: 10, // Horizontal spacing between items
                mainAxisSpacing: 5, // Vertical spacing between items
                childAspectRatio:
                    0.75, // Adjust this value to maintain the height of Finalcat
              ),
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) {
                final item = filteredEvents[index];

                return Container(
                  margin: EdgeInsets.only(
                    right: index % 2 == 0
                        ? 5
                        : 15, // Add right margin for every second item in the row
                    bottom: 15,
                    left: index % 2 == 0
                        ? 15
                        : 5, // Add left margin for every second item in the row
                  ),
                  child: Finalcat(
                    description: item['description'],
                    image: item['image'],
                    name: item['text'],
                    press: () {
                      Navigator.pushNamed(context, Vendor_Screen.id,
                          arguments: item['text']);
                    },
                  ),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
