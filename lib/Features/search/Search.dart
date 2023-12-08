import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/features/cart/cart_screen.dart';
import 'package:eventify/features/search/Searchservices.dart';
import 'package:eventify/features/product_details/Product_detail_screen.dart';
import 'package:flutter/material.dart';
import '../../common/widgets/Loader.dart';
import '../../common/widgets/MainSearchBar.dart';
import '../../models/Product.dart';
import '../UserHome/widgets/AppbarClipper.dart';
import 'SearchedProduct.dart';

class Search extends StatefulWidget {
  static const String id = '/search';
  final String Searchquery;
  const Search({required this.Searchquery});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Product> prod = [];
  Searchservices search = Searchservices();
  @override
  void initState() {
    super.initState();
    fetchsearchedprod();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void fetchsearchedprod() async {
    prod = await search.fetchsearchproduct(
        context: context, Searchquery: widget.Searchquery);
    setState(() {});
  }

  void Navigatetosearchscreen(String query) {
    Navigator.pushNamed(context, Search.id, arguments: query);
    searchController.clear();
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: COLOR_PRIMARY,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(140),
          child: ClipPath(
            clipper: CustomAppBarClipper(),
            child: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: COLOR_ACCENT,
              elevation: 0,
              centerTitle: true, // Center the title and widgets
              title: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: SearchBarWidget(
                      hintText: "| Search...",
                      controller: searchController,
                    ),
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, top: 15),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, CartScreen.id);
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/cart.png'),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red, // Customize the cart dot color
                            ),
                            child: Center(
                              child: Text(
                                '2',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10, // Customize the font size
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: prod == null
            ? Loader()
            : Column(
                children: [
                  // Adressbox(),

                  Expanded(
                    child: ListView.builder(
                        itemCount: prod.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, ProductDetailsScreen.id,
                                      arguments: prod[index]);
                                },
                                child: searchedproduct(product: prod[index])),
                          );
                        }),
                  ),
                ],
              ),
      ),
    );
  }
}
