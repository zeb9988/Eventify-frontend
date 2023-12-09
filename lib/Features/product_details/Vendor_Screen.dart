// ignore_for_file: camel_case_types, non_constant_identifier_names, file_names
import 'package:eventify/common/widgets/Loader.dart';
import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/widgets/SearchBar.dart';
import '../../constant/constant.dart';
import '../../prooviders/provider.dart';
import '../UserHome/services/HomeServices.dart';
import '../UserHome/widgets/productcard2.dart';

class Vendor_Screen extends StatefulWidget {
  final String product;
  static const String id = '/Product_detail';

  const Vendor_Screen({Key? key, required this.product}) : super(key: key);

  @override
  State<Vendor_Screen> createState() => _Vendor_ScreenState();
}

class _Vendor_ScreenState extends State<Vendor_Screen> {
  // final List<ListItemData> dataList = [
  List<Product> Productlist = [];
  HomeServices home = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchcatagory();
  }

  void fetchcatagory() async {
    Productlist = await home.fetchsearchproduct(
        context: context, catagory: widget.product);
    setState(() {});
  }

  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartlen = context.watch<UserProvider>().user.cart.length;
    String pic = '';

    if (widget.product == 'Photographer') {
      pic = 'assets/images/photo.jpg';
    } else if (widget.product == 'Videographer') {
      pic = 'assets/images/Video.jpg';
    } else if (widget.product == 'Catering') {
      pic = 'assets/images/cat.jpg';
    } else if (widget.product == 'Florists') {
      pic = 'assets/images/flower.jpg';
    } else if (widget.product == 'Transportation Service') {
      pic = 'assets/images/car.jpg';
    } else if (widget.product == 'Sound & Lighting') {
      pic = 'assets/images/light.jpg';
    } else if (widget.product == 'Security Service') {
      pic = 'assets/images/security.jpg';
    } else if (widget.product == 'Event Invitations and Printing') {
      pic = 'assets/images/printing.jpg';
    } else if (widget.product == 'Wedding Planner') {
      pic = 'assets/images/wedding.jpg';
    } else if (widget.product == 'Makeup Artist & Salon') {
      pic = 'assets/images/makeup.jpg';
    } else if (widget.product == 'Mehndi Artist') {
      pic = 'assets/images/mehndi.jpg';
    } else if (widget.product == 'Decorator') {
      pic = 'assets/images/decore.jpg';
    } else if (widget.product == 'Jewelry Store') {
      pic = 'assets/images/jewelry.jpg';
    } else if (widget.product == 'Wedding Car Decorators') {
      pic = 'assets/images/design_car.jpg';
    } else if (widget.product == 'Wedding Dress Boutique') {
      pic = 'assets/images/dress.jpg';
    } else if (widget.product == 'Entertainer') {
      pic = 'assets/images/entertainment.jpg';
    } else if (widget.product == 'Ticketing and Promotion') {
      pic = 'assets/images/ticketing.jpg';
    } else if (widget.product == 'Branding & Marketing') {
      pic = 'assets/images/branding.jpg';
    } else if (widget.product == 'Party Planner') {
      pic = 'assets/images/party.jpg';
    } else if (widget.product == 'Event Planner') {
      pic = 'assets/images/corevent.jpg';
    } else if (widget.product == 'Venues') {
      pic = 'assets/images/venuepic.jpg';
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: COLOR_PRIMARY,
        body: SafeArea(
          child: Column(
            children: [
              Material(
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(pic), fit: BoxFit.cover)),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            colors: [
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
                          widget.product,
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
                        hintText: 'Search...',
                        controller: searchController,
                      ),
                    ]),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Productlist.isEmpty
                  ? const Loader()
                  : Expanded(
                      child: GridView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Two items per row
                          crossAxisSpacing: 12, // Adjust the spacing as needed
                          mainAxisExtent: 245, // Adjust the height as needed
                        ),
                        itemCount: Productlist.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: productCard2(
                              product: Productlist[index],
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
