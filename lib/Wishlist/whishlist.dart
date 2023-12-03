import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        // final item = products[index];
        return Dismissible(
          // Each Dismissible must contain a Key. Keys allow Flutter to
          // uniquely identify widgets.
          key: Key(UniqueKey().toString()),
          // Provide a function that tells the app
          // what to do after an item has been swiped away.
          onDismissed: (direction) {
            if(direction == DismissDirection.endToStart) {
              // Then show a snackbar.
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text( " dismissed"), duration: Duration(seconds: 1)));
            } else {
              // Then show a snackbar.
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(" added to carts"), duration: Duration(seconds: 1)));
            }
            // Remove the item from the data source.
            setState(() {
              // products.removeAt(index);
            });
          },
          // Show a red background as the item is swiped away.
          background: Container(
            decoration: BoxDecoration(color: Colors.green),
            padding: EdgeInsets.all(5.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Icon(Icons.add_shopping_cart, color: Colors.white),
                ),

              ],
            ),
          ),
          secondaryBackground: Container(
            decoration: BoxDecoration(color: Colors.red),
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Icon(Icons.delete, color: Colors.white),
                ),

              ],
            ),
          ),
          child: InkWell(
            onTap: () {
              print('Card tapped.');
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Divider(
                  height: 0,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: ListTile(
                    trailing: Icon(Icons.swap_horiz),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue
                        ),
                        child: Image.asset(
                            "assets/images/cat.jpg"

                        ),
                      ),
                    ),
                    title: Text(
                      'rana',
                      style: TextStyle(
                          fontSize: 14
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0, bottom: 1),
                              child: Text('\$200', style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w700,
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 6.0),
                              child: Text('(\$400)', style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough
                              )),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            RatingBar.builder(
                              itemSize: 24,
                              // Increased text size
                              initialRating: 4,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: EdgeInsets.symmetric(
                                  horizontal: 2.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                // Handle rating updates
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
