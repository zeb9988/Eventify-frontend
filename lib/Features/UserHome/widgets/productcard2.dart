// ignore_for_file: camel_case_types

import 'package:eventify/features/product_details/Product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/star.dart';
import '../../../constant/Theme_constant.dart';
import '../../../models/Product.dart';
import '../../../prooviders/provider.dart';
import '../../Favroute/Services/favoriteServices.dart';

class productCard2 extends StatefulWidget {
  final Product product;
  const productCard2({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<productCard2> createState() => _productCard2State();
}

late bool isFavorite;
FavoriteServices _favoriteServices = FavoriteServices();

class _productCard2State extends State<productCard2> {
  double avgRating = 0;
  double myRating = 0;
  late bool isFavorite;

  void toggleFavorite() {
    try {
      if (isFavorite) {
        _favoriteServices.removeFav(context: context, product: widget.product);
      } else {
        _favoriteServices.addToFav(context: context, product: widget.product);
      }
      // Update the UI after adding/removing from favorites
      setState(() {
        isFavorite = !isFavorite;
      });
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    isFavorite = Provider.of<UserProvider>(context, listen: false)
        .isFavorite(widget.product);
    void press() {
      Navigator.pushNamed(context, ProductDetailsScreen.id,
          arguments: widget.product);
    }

    return GestureDetector(
      onTap: () {
        press();
      },
      child: Container(
        height: 245, // Adjust the height of the parent container
        margin: const EdgeInsets.only(right: 15, bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: const [
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
            SizedBox(
              height: 100,
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        widget.product.images[0],
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
                      minWidth: 45,
                      height: 45,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      onPressed: () {
                        toggleFavorite();
                      },
                      padding: const EdgeInsets.all(5),
                      child: const Center(
                        child:
                            Icon(Icons.favorite, color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.product.businessName,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            // Separate category and price using Positioned
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.category,
                  style: TextStyle(
                    color: Colors.orange.shade400,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Rs ${widget.product.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
            Star(rating: avgRating),
            // RatingBar.builder(
            //   itemSize: 18,
            //   // Increased text size
            //   initialRating: 4,
            //   minRating: 1,
            //   direction: Axis.horizontal,
            //   allowHalfRating: true,
            //   itemCount: 5,
            //   itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
            //   itemBuilder: (context, _) => const Icon(
            //     Icons.star,
            //     color: Colors.amber,
            //   ),
            //   onRatingUpdate: (rating) {
            //     // Handle rating updates
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
