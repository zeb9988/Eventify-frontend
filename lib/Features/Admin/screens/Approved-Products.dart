// ignore_for_file: library_private_types_in_public_api

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '../../../constant/Theme_constant.dart';
import '../../../models/Product.dart';

class ApprovedProducts extends StatefulWidget {
  static const String id = '/allapprovedproducts';
  final List<Product> approvedRequests;
  const ApprovedProducts({Key? key, required this.approvedRequests})
      : super(key: key);

  @override
  _ApprovedProductsState createState() => _ApprovedProductsState();
}

class _ApprovedProductsState extends State<ApprovedProducts> {
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
          'Approved Products',
          style: TextStyle(
            fontFamily: 'Merriweather',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          if (widget.approvedRequests.isEmpty)
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: DottedBorder(
                color: COLOR_ACCENT,
                radius: const Radius.circular(10),
                borderType: BorderType.RRect,
                strokeCap: StrokeCap.round,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "No Approved Products",
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
              shrinkWrap: true,
              itemCount: widget.approvedRequests.length,
              itemBuilder: (context, index) {
                final request = widget.approvedRequests[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ApprovedReqCard(
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

class ApprovedReqCard extends StatelessWidget {
  final String image;
  final String name;
  final String description;
  final double price;

  const ApprovedReqCard({
    Key? key,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(0, 2),
                blurRadius: 6,
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 10),
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
                    const Row(
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons
                              .check_circle, // Use an approved icon of your choice
                          color: Colors.green, // Set the icon color
                          size: 15,
                        ),
                        Text(
                          "Approved",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Rs$price',
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
          ),
        ));
  }
}

class Productsss {
  final List<String> images;
  final String businessName;
  final String generalDetail;
  final double price;

  Productsss({
    required this.images,
    required this.businessName,
    required this.generalDetail,
    required this.price,
  });
}
