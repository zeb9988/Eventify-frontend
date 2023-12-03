import 'package:dotted_border/dotted_border.dart';
import 'package:eventify/constant/Theme_constant.dart';
import 'package:flutter/material.dart';

import '../../../models/order.dart';

class AdminOrderHistory extends StatefulWidget {
  static const String id = '/AdminOrderHistory';
  final List<Order> orderHistory;
  AdminOrderHistory({required this.orderHistory});

  @override
  State<AdminOrderHistory> createState() => _AdminOrderHistoryState();
}

class _AdminOrderHistoryState extends State<AdminOrderHistory> {
  // List<Order> orderHistory = [];
  // final Orderservices orderservices = Orderservices();
  @override
  void initState() {
    super.initState();
    // fetchOrders();
  }

  // void fetchOrders() async {
  //   orderHistory = await orderservices.fetchOrderHistory(context: context);
  //   setState(() {});
  //   print(orderHistory.length);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_PRIMARY,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: COLOR_PRIMARY,
        centerTitle: true,
        title: const Text(
          'Sold Order',
          style: TextStyle(
            fontFamily: 'Merriweather',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: widget.orderHistory.isEmpty
          ? Center(
              child: DottedBorder(
                color: COLOR_ACCENT,
                radius: const Radius.circular(10),
                borderType: BorderType.RRect,
                strokeCap: StrokeCap.round,
                child: Container(
                  height: 150,
                  width: 200,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.book,
                        color: COLOR_ACCENT,
                        size: 50,
                      ),
                      Center(
                        child: Text(
                          "Booking is empty",
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
          : ListView.builder(
              itemCount: widget.orderHistory.length,
              itemBuilder: (context, orderIndex) {
                final order = widget.orderHistory[orderIndex];
                return GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, TrackOrder.id,
                    //     arguments: order);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            offset: const Offset(0, 2),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Order ${orderIndex + 1}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          ListView.builder(
                            itemCount: order.products.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, productIndex) {
                              final product = order.products[productIndex];
                              return Row(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        product.images[
                                            0], // Replace with your image URL
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
                                          product
                                              .businessName, // Replace with your product name
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          product
                                              .category, // Replace with your product category
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Text(
                                          '\$${product.price}', // Replace with your product price
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey.shade800,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
