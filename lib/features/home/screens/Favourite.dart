import 'package:dotted_border/dotted_border.dart';
import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/features/cart/cartlist.dart';
import 'package:eventify/features/home/services/favoriteServices.dart';
import 'package:eventify/features/product_details/Product_detail_screen.dart';
import 'package:eventify/prooviders/provider.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../../models/Product.dart';

class Favourite extends StatefulWidget {
  static const String id = '/FavoriteScreen';

  @override
  State<Favourite> createState() => _FavouriteState();
}

FavoriteServices _favoriteServices = FavoriteServices();

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    final favorite = Provider.of<UserProvider>(context).user.favorites;

    return Scaffold(
      backgroundColor: COLOR_PRIMARY,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: COLOR_PRIMARY,
        centerTitle: true,
        title: Text(
          'My Favorites',
          style: TextStyle(
            fontFamily: 'Merriweather',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: favorite.isEmpty
          ? Center(
              child: DottedBorder(
                color: COLOR_ACCENT,
                radius: const Radius.circular(10),
                borderType: BorderType.RRect,
                strokeCap: StrokeCap.round,
                child: Container(
                  height: 150,
                  width: 200,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: COLOR_ACCENT,
                        size: 50,
                      ),
                      Center(
                        child: Text(
                          "Favorite is empty",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView.builder(
                        itemCount: favorite
                            .length, // Replace with your list of favorite products
                        itemBuilder: (context, index) {
                          final item = context
                              .watch<UserProvider>()
                              .user
                              .favorites[index];
                          final product = Product.fromMap(item['product']);
                          // final quantity = productCart['quantity'];// Replace with your favorite product model
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, ProductDetailsScreen.id,
                                  arguments: product);
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    offset: Offset(0, 2),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        product.images[0],
                                        fit: BoxFit.cover,
                                        height: 100,
                                        width: 100,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          product.businessName,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          product.category,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        Text(
                                          '\Rs ${product.price}',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey.shade800,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    //   onTap: () {
                                    onTap: () {
                                      FavoriteServices favoriteServices =
                                          FavoriteServices();
                                      favoriteServices.removeFav(
                                          context: context, product: product);
                                    },

                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      // color: isFavoriteList[index]
                                      //     ? Colors.red
                                      //     : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
