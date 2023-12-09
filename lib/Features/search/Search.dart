import 'package:eventify/Constant/constant.dart';
import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/features/cart/cart_screen.dart';
import 'package:eventify/features/search/Searchservices.dart';
import 'package:eventify/features/product_details/Product_detail_screen.dart';
import 'package:eventify/prooviders/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    final usercartLen = context.watch<UserProvider>().user.cart.length;
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
                CartButton(context, usercartLen, Colors.black),
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
