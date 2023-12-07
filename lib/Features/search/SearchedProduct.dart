import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/common/widgets/star.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../models/Product.dart';

class searchedproduct extends StatelessWidget {
  final Product product;
  const searchedproduct({required this.product});

  @override
  Widget build(BuildContext context) {
    double avgrating = 0;
    double totalrating = 0;
    // for (int i = 0; i < product.rating!.length; i++) {
    //   totalrating += product.rating![i].rating;
    // }

    // if (totalrating != 0) {
    //   avgrating = totalrating / product.rating!.length;
    // }

    // ignore: unnecessary_null_comparison
    return product == null
        ? Text('no')
        : Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.symmetric(horizontal: 10),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            product.businessName,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              overflow: TextOverflow
                                  .ellipsis, // Prevent text from breaking into multiple lines
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            product.category,
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '\$${product.price}',
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey.shade800),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RatingBar.builder(
                          itemSize: 18,
                          // Increased text size
                          initialRating: 4,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            // Handle rating updates
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
