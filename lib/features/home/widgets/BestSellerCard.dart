import 'package:eventify/common/widgets/star.dart';
import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/features/home/services/favoriteServices.dart';
import 'package:eventify/models/Product.dart';
import 'package:eventify/prooviders/provider.dart';
import 'package:eventify/utils/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../product_details/Product_detail_screen.dart';

class BestSellerCard extends StatefulWidget {
  final Product Data;
  // final Product favprod;
  BestSellerCard(
    this.Data,
    // this.favprod,
  );

  @override
  State<BestSellerCard> createState() => _BestSellerCardState();
}

FavoriteServices _favoriteServices = FavoriteServices();

class _BestSellerCardState extends State<BestSellerCard> {
  late bool isFavorite;

  void toggleFavorite() {
    try {
      if (isFavorite) {
        _favoriteServices.removeFav(context: context, product: widget.Data);
      } else {
        _favoriteServices.addToFav(context: context, product: widget.Data);
      }
      // Update the UI after adding/removing from favorites
      setState(() {
        isFavorite = !isFavorite;
      });
    } catch (e) {
      print('Error toggling favorite: $e');
    }
  }

  double avgRating = 0;
  double myRating = 0;
  @override
  void initState() {
    super.initState();
    // isFavorite = Provider.of<UserProvider>(context, listen: false)
    //     .isFavorite(widget.Data);
    // print(isFavorite);
    // toggleFavorite();
    double totalRating = 0;
    for (int i = 0; i < widget.Data.rating!.length; i++) {
      // print(widget.Data.rating![i].rating);
      totalRating += widget.Data.rating![i].rating;
      if (widget.Data.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.Data.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.Data.rating!.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    isFavorite = Provider.of<UserProvider>(context, listen: false)
        .isFavorite(widget.Data);
    print(isFavorite);
    void press() {
      Navigator.pushNamed(context, ProductDetailsScreen.id,
          arguments: widget.Data);
      // print(widget.Data.address);
    }

    return AspectRatio(
      aspectRatio: 1 / 1,
      child: GestureDetector(
        onTap: () {
          press();
        },
        child: Container(
          height: 100, // Adjust the height of the parent container
          margin: const EdgeInsets.only(right: 20, bottom: 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(5, 10),
                // blurRadius: 15,
                color: COLOR_ACCENT,
              ),
            ],
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          widget.Data.images[0],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Add to cart button
                    Positioned(
                      right: 5,
                      bottom: 5,
                      child: MaterialButton(
                        color: isFavorite ? Colors.red : Colors.black,
                        minWidth: 30,
                        height: 30,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        onPressed: () {
                          toggleFavorite();
                          print('done');
                        },
                        padding: const EdgeInsets.all(5),
                        child: const Center(
                          child: Icon(
                            Icons.favorite, // Toggle the icon
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.Data.businessName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.Data.category,
                    style: TextStyle(
                      color: Colors.orange.shade400,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    "\Rs ${widget.Data.price.toStringAsFixed(0)}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              Expanded(child: Star(rating: avgRating))
            ],
          ),
        ),
      ),
    );
  }
}
