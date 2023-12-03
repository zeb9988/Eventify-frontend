import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/features/product_details/Product_detail_screen.dart';
import 'package:eventify/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Cardss extends StatelessWidget {
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
  Widget build(BuildContext context) {
    void press() {
      Navigator.pushNamed(context, ProductDetailsScreen.id, arguments: product);
      print(product.address);
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
                        image,
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
              name,
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
                  '\Rs ${price}',
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            RatingBar.builder(
              itemSize: 18,
              initialRating: 4,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                // Handle rating updates
              },
            ),
            // Edit and Delete Icons
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                onDelete();
              },
            ),
          ],
        ),
      ),
    );
  }
}
