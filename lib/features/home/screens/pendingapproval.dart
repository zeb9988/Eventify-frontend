import 'package:dotted_border/dotted_border.dart';
import 'package:eventify/constant/Theme_constant.dart';
import 'package:flutter/material.dart';

import '../../../models/Product.dart';
import '../services/vendor_services.dart';

class PendingRequest extends StatefulWidget {
  static const String id = '/pendingapproval';
  @override
  State<PendingRequest> createState() => _PendingRequestState();
}

class _PendingRequestState extends State<PendingRequest> {
  List<Product> pending_request = [];

  VendorServices vendorServices = VendorServices();

  @override
  void initState() {
    fetchVendorsofUser();
    super.initState();
  }

  void fetchVendorsofUser() async {
    pending_request =
        await vendorServices.fetchpendingVendors(context: context);
    print(pending_request);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: COLOR_PRIMARY,
        centerTitle: true,
        title: Text(
          'Pending Products',
          style: TextStyle(
            fontFamily: 'Merriweather',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: COLOR_PRIMARY,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          if (pending_request.isEmpty)
            Padding(
              padding: const EdgeInsets.all(50.0),
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
                  child: Center(
                    child: Text(
                      "No Pending Requests",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              shrinkWrap:
                  true, // Ensure the ListView takes only the required height
              itemCount: pending_request.length,
              itemBuilder: (context, index) {
                final request = pending_request[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PendingReqCard(
                    image: request.images[0],
                    name: request.businessName,
                    description: request.generalDetail,
                    price: request.price,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PendingReqCard extends StatelessWidget {
  final String image;
  final String name;
  final String description;
  final double price;

  PendingReqCard({
    required this.image,
    required this.name,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
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
                  child: Container(
                    color: Colors.grey.shade200,
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Status",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.pending,
                          color: COLOR_ACCENT,
                          size: 15,
                        ),
                        Text(
                          "Pending",
                          style: TextStyle(
                            color: COLOR_ACCENT,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      description,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      '\Rs$price',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              // Icon(Icons.edit)
            ],
          ),
        ));
  }
}
