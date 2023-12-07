import 'package:eventify/common/widgets/Loader.dart';
import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';

import '../../../models/order.dart';
import '../../Booking/TrackBooking.dart';

class AdminBookingScreen extends StatefulWidget {
  static const String id = '/AdminOrderScreen';
  const AdminBookingScreen({Key? key}) : super(key: key);

  @override
  State<AdminBookingScreen> createState() => _AdminBookingScreenState();
}

class _AdminBookingScreenState extends State<AdminBookingScreen> {
  List<Order>? orders;
  final AdminServices orderservices = AdminServices();
  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await orderservices.fetchMAllOrders(context: context);
    setState(() {});
    print(orders);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_PRIMARY,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: COLOR_PRIMARY,
        centerTitle: true,
        title: Text(
          ' Current Bookings ',
          style: TextStyle(
            fontFamily: 'Merriweather',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: orders == null
          ? Loader()
          :
          // : Padding(
          //     padding: const EdgeInsets.all(16.0),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: <Widget>[
          //         Text(
          //           'Order Summary',
          //           style: TextStyle(
          //             fontSize: 24,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //         SizedBox(height: 20),
          // Expanded(
          // child:
          ListView.builder(
              itemCount: orders!.length,
              itemBuilder: (context, orderIndex) {
                final order = orders![orderIndex];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, TrackUserOrder.id,
                        arguments: order);
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
                    child: Column(
                      children: [
                        Text('Order $orderIndex'),
                        ListView.builder(
                          itemCount: order.products.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, productIndex) {
                            final product = order.products[productIndex];
                            return Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 10),
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
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        product
                                            .category, // Replace with your product category
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        '\$${product.price}', // Replace with your product price
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                      SizedBox(height: 10),
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
                );
              },
            ),
      //       ),
      //       SizedBox(height: 20),
      //     ],
      //   ),
      // ),
    );
  }
}
