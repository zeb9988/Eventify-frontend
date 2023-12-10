import 'package:carousel_slider/carousel_slider.dart';
import 'package:eventify/common/widgets/SearchBar.dart';
import 'package:eventify/features/product_details/Vendor_Screen.dart';
import 'package:eventify/prooviders/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constant/Theme_constant.dart';
import '../../../constant/constant.dart';
import '../widgets/finalcategorycard.dart';

class AllCatagory extends StatefulWidget {
  static const String id = '/Allcatagory';

  const AllCatagory({Key? key}) : super(key: key);

  @override
  State<AllCatagory> createState() => _AllCatagoryState();
}

class _AllCatagoryState extends State<AllCatagory> {
  List filteredCategories = [];

  @override
  void initState() {
    super.initState();
    filteredCategories = AllCategoryList;
  }

  void filterCategories(String query) {
    setState(() {
      filteredCategories = AllCategoryList.where((category) =>
              category['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: COLOR_PRIMARY,
        body: Column(children: [
          Stack(
            children: [
              CarouselSlider(
                items: AllCategoryList.map((item) {
                  return Container(
                    height: 200,
                    width: 400,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(item['image']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors: [
                            Colors.black.withOpacity(.8),
                            Colors.black.withOpacity(.5),
                          ],
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 50),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: Text(
                              item['name']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 200,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  enlargeCenterPage: true,
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {
                    setState(() {});
                  },
                ),
              ),
              Positioned(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    buildCustomBackButton(context),
                    CartButton(context, cartlen, Colors.white),
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: CustomSearchBar(
                  hintText: 'Search...',
                  controller: searchController,
                  onChanged: (query) {
                    filterCategories(query);
                  },
                ),
              ),
            ],
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
              itemCount: filteredCategories.length,
              itemBuilder: (context, index) {
                final item = filteredCategories[index];

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
                    name: item['name'],
                    press: () {
                      Navigator.pushNamed(
                        context,
                        Vendor_Screen.id,
                        arguments: item['name'],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
