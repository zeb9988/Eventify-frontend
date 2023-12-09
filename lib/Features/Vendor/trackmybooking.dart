import 'package:eventify/Features/Booking/Services/Booking_services.dart';
import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/features/admin/services/admin_services.dart';
import 'package:eventify/prooviders/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../../common/widgets/custombutton.dart';
import '../../models/order.dart';

class TrackMyOrder extends StatefulWidget {
  static const String id = '/TrackOrder';
  final Order order;
  const TrackMyOrder({Key? key, required this.order}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TrackMyOrderState createState() => _TrackMyOrderState();
}

class _TrackMyOrderState extends State<TrackMyOrder> {
  int currentStep = 0;
  double _rating = 0.0;
  final TextEditingController _feedbackController = TextEditingController();
  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    currentStep =
        widget.order.status.clamp(0, 3); // Assuming you have 4 steps (0 to 3)
  }

  BookingServices orderservices = BookingServices();
  void submitFeedback() {
    orderservices.rateProduct(
        context: context,
        order: widget.order,
        product: widget.order.products[0],
        feedback: _feedbackController.text,
        rating: _rating);
  }

  AdminServices adminServices = AdminServices();
  void changeOrderStatus(int status) {
    adminServices.changeOrderStatus(
      context: context,
      status: status + 1,
      order: widget.order,
      onSuccess: () {
        if (currentStep < 3) {
          setState(() {
            currentStep += 1;
          });
        }
      },
    );
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
          'Track User Booking',
          style: TextStyle(
            fontFamily: 'Merriweather',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16.0,
              ),
              child: Text(
                "Booking Detail",
                style: TextStyle(
                  fontSize: 22.0,
                ),
              ),
            ),
            for (int i = 0; i < widget.order.products.length; i++)
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  padding:
                      const EdgeInsets.all(5), // Adjust the padding as needed

                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 0.5,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      Image.network(
                        widget.order.products[i].images[0],
                        height: 120,
                        width: 120,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.order.products[i].businessName,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(widget.order.products[i].category),
                            Text(
                              widget.order.products[i].generalDetail,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Price: Rs ${widget.order.products[i].price.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 0.5,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Booking ID: ${widget.order.id}",
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        DateFormat().format(DateTime.fromMicrosecondsSinceEpoch(
                            widget.order.orderedAt)),
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16.0,
              ),
              child: Text(
                "Tracking",
                style: TextStyle(
                  fontSize: 22.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 0.5,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: (context, details) {
                    if (currentStep < 3) {
                      return CustomButton(
                        text: 'Done',
                        onTap: () => changeOrderStatus(details.currentStep),
                      );
                    }
                    return const SizedBox();
                  },
                  steps: [
                    Step(
                      title: const Text('Pending'),
                      content:
                          const Text('Your booking is yet to be delivered'),
                      isActive: currentStep >= 0, // Updated the condition

                      state: currentStep >= 0
                          ? StepState.complete
                          : StepState.indexed, // Updated the condition
                    ),
                    Step(
                      title: const Text('Completed'),
                      content: const Text(
                          'Your booking has been delivered, you are yet to sign.'),
                      isActive: currentStep >= 1, // Updated the condition
                      state: currentStep >= 1
                          ? StepState.complete
                          : StepState.indexed, // Updated the condition
                    ),
                    Step(
                      title: const Text('Received'),
                      content: const Text(
                          'Your booking has been delivered and signed by you.'),
                      isActive: currentStep >= 2, // Updated the condition
                      state: currentStep >= 2
                          ? StepState.complete
                          : StepState.indexed, // Updated the condition
                    ),
                    Step(
                      title: const Text('Delivered'),
                      content: const Text(
                          'Your booking has been delivered and signed by you!'),
                      isActive: currentStep >= 3,
                      state: currentStep >= 3
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                padding:
                    const EdgeInsets.only(left: 24.0, top: 16.0, bottom: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 0.5,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.home, size: 25.0, color: Colors.grey),
                    const SizedBox(width: 15.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Delivery Address",
                          style: TextStyle(fontSize: 15.0),
                        ),
                        Text(
                          "Home, Work & Other Address",
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 12.0,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.8,
                          child: Text(
                            widget.order.address,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 12.0,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
