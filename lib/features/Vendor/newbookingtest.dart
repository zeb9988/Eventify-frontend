import 'package:dotted_border/dotted_border.dart';
import 'package:eventify/common/widgets/Loader.dart';
import 'package:eventify/common/widgets/customSnackbar.dart';
import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/features/Booking/Booking_services.dart';
import 'package:eventify/features/Booking/TrackBooking.dart';
import 'package:eventify/features/Vendor/trackmybooking.dart';
import 'package:flutter/material.dart';
import '../../models/order.dart';
import '../cart/cartlist.dart';

class NewBookingTest extends StatefulWidget {
  static const String id = '/NewBooking';

  const NewBookingTest({Key? key}) : super(key: key);

  @override
  State<NewBookingTest> createState() => _NewBookingTestState();
}

class _NewBookingTestState extends State<NewBookingTest> {
  List<Order> orders = [];
  final Orderservices orderservices = Orderservices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await orderservices.fetchMyVendorOrders(context: context);
    setState(() {});
  }

  // void deleteOrder(Order order, int index) {
  //   orderservices.deleteOrder(
  //     context: context,
  //     order: order,
  //     onsuccess: () {
  //       orders.removeAt(index);
  //       showCustomSnackBar(
  //           context: context,
  //           text: 'Order has beed deleted successfully',
  //           label: 'ok',
  //           onPressed: () {});

  //       setState(() {});
  //     },
  //   );
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
          'New Bookings',
          style: TextStyle(
            fontFamily: 'Merriweather',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: orders.isEmpty
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
                          "No Bookings",
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
              itemCount: orders.length,
              itemBuilder: (context, orderIndex) {
                final order = orders[orderIndex];
                return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, TrackMyOrder.id,
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
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              // existing container code
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Order ${orderIndex + 1} - ',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: COLOR_ACCENT,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.info,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              getStatusText(order.status),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Expanded(child: Container()),
                                      // if (order.status == 0)
                                      //   Column(
                                      //     children: [
                                      //       IconButton(
                                      //           onPressed: () {
                                      //             deleteOrder(
                                      //                 order, orderIndex);
                                      //           },
                                      //           icon: const Icon(Icons.delete)),
                                      //     ],
                                      //   )
                                    ],
                                  ),
                                  ListView.builder(
                                    itemCount: order.products.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, productIndex) {
                                      final product =
                                          order.products[productIndex];
                                      return Column(
                                        children: [
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 15),
                                                    Text(
                                                      '\$${product.price}',
                                                      // Replace with your product price
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors
                                                            .grey.shade800,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )));
              },
            ),
    );
  }
}

String getStatusText(int status) {
  if (status == 0) {
    return 'Pending';
  } else if (status == 1) {
    return 'Completed';
  } else if (status == 1) {
    return 'Received';
  } else {
    return 'Dilivered';
  }
}
