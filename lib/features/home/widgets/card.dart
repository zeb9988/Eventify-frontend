import 'package:eventify/common/widgets/star.dart';
import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/features/product_details/Product_detail_screen.dart';
import 'package:eventify/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../prooviders/provider.dart';

class Cardss extends StatefulWidget {
  final String image;
  final String name;
  final double price;
  final VoidCallback onDelete;
  final Product product;

  const Cardss({
    required this.image,
    required this.name,
    required this.price,
    required this.onDelete,
    required this.product,
  });

  @override
  State<Cardss> createState() => _CardssState();
}

class _CardssState extends State<Cardss> {
  double avgRating = 0;
  double myRating = 0;
  @override
  void initState() {
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      print(widget.product.rating![i].rating);
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void press() {
      Navigator.pushNamed(context, ProductDetailsScreen.id,
          arguments: widget.product);
      print(widget.product.address);
    }

    return GestureDetector(
      onTap: () {
        press();
      },
      child: Container(
        height: 250, // Adjust the height of the parent container
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            const BoxShadow(
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
                        widget.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Add to cart button
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.name,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\Rs ${widget.price}',
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            Star(rating: avgRating),
            // Edit and Delete Icons
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                widget.onDelete();
              },
            ),
          ],
        ),
      ),
    );
  }
}
