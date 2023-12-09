import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/features/address/screens/adress_screen.dart';
import 'package:eventify/features/cart/cartservices.dart';
import 'package:eventify/features/search/Search.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../models/Product.dart';
import '../../prooviders/provider.dart';

class CartScreen extends StatefulWidget {
  static const String id = '/Cart';
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartServices cartServices = CartServices();
  double sum = 0;
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, Search.id, arguments: query);
  }

  void decreaseQuantity(Product product) {
    cartServices.removeFromCart(
      context: context,
      product: product,
    );
  }

  Future<void> showAddressBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AddressScreen(
          totalAmount: sum.toStringAsFixed(0),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    print(user.email);

    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return SafeArea(
      child: Scaffold(
        backgroundColor: COLOR_PRIMARY,
        appBar: AppBar(
          iconTheme: IconThemeData(color: COLOR_ACCENT),
          toolbarHeight: 50,
          elevation: 0,
          backgroundColor: COLOR_PRIMARY,
          title: Text('My Cart', style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (user.cart.isEmpty)
              Padding(
                padding: const EdgeInsets.all(70.0),
                child: DottedBorder(
                  color: COLOR_ACCENT,
                  radius: const Radius.circular(10),
                  borderType: BorderType.RRect,
                  strokeCap: StrokeCap.round,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        LoadingAnimationWidget.bouncingBall(
                          color: COLOR_ACCENT,
                          size: 50,
                        ),
                        Icon(
                          Icons.shopping_cart,
                          color: COLOR_ACCENT,
                          size: 50,
                        ),
                        Center(
                          child: Text(
                            "Cart is empty",
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
              ),
            SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.builder(
                  itemCount: user.cart.length,
                  itemBuilder: (context, index) {
                    // final item = cartt[index];
                    final productCart =
                        context.watch<UserProvider>().user.cart[index];
                    final product = Product.fromMap(productCart['product']);
                    final quantity = productCart['quantity'];
                    return GestureDetector(
                      onTap: () {
                        // makePayment();
                      },
                      child: Container(
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
                                  Text(product.businessName,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18)),
                                  SizedBox(height: 5),
                                  Text(
                                    product.category,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    '\Rs ${product.price.toStringAsFixed(0)}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey.shade800),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('remove',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14)),
                                IconButton(
                                  onPressed: () {
                                    decreaseQuantity(product);
                                  },
                                  icon: Icon(Icons.delete,
                                      color:
                                          COLOR_ACCENT), // Replace with your delete icon
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Total', style: TextStyle(fontSize: 20)),
                  Text('\Rs $sum',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(height: 10),
            sum != 0
                ? Padding(
                    padding: EdgeInsets.all(20.0),
                    child: MaterialButton(
                      onPressed: () {
                        // makePayment();
                        showAddressBottomSheet(context);
                      },
                      height: 50,
                      elevation: 0,
                      splashColor: Colors.yellow[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: COLOR_ACCENT,
                      child: Center(
                        child: Text("Checkout",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 50,
                  )
          ],
        ),
      ),
    );
  }
}
