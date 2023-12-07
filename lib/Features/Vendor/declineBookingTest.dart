import 'package:dotted_border/dotted_border.dart';
import 'package:eventify/Features/Booking/Services/Booking_services.dart';
import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/features/Booking/TrackBooking.dart';
import 'package:flutter/material.dart';

import '../../models/order.dart';

class DeclineBookingTest extends StatefulWidget {
  static const String id = '/declinebooking';

  const DeclineBookingTest({Key? key}) : super(key: key);

  @override
  State<DeclineBookingTest> createState() => _DeclineBookingTestState();
}

class _DeclineBookingTestState extends State<DeclineBookingTest> {
  List<Order> orderHistory = [];
  final BookingServices orderservices = BookingServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orderHistory = await orderservices.fetchDeclineOrder(context: context);
    setState(() {});
    print(orderHistory.length);
  }

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
          'Booking History',
          style: TextStyle(
            fontFamily: 'Merriweather',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: orderHistory.isEmpty
          ? Center(
              child: DottedBorder(
                color: COLOR_ACCENT,
                radius: const Radius.circular(10),
                borderType: BorderType.RRect,
                strokeCap: StrokeCap.round,
                child: Container(
                  height: 150,
                  width: 215,
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
                          "No Booking History",
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
              itemCount: orderHistory.length,
              itemBuilder: (context, orderIndex) {
                final order = orderHistory[orderIndex];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, TrackUserOrder.id,
                        arguments: order);
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
                          Text('Order ${order.totalPrice}'),
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
                                          product.businessName,
                                          // Replace with your product name
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          product.category,
                                          // Replace with your product category
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Text(
                                          '\$${product.price}',
                                          // Replace with your product price
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
