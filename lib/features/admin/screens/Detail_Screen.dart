import 'package:eventify/models/approvedVendor.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  static const String id = '/DetailScreen';
  final ApprovedVendors product;

  const DetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 32.0,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          "PRODUCT DETAIL",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildImageSlider(),
            SizedBox(height: 16.0),
            _buildProductInfo(),
            SizedBox(height: 16.0),
            _buildDetailsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSlider() {
    return Container(
      height: 250.0,
      child: DefaultTabController(
        length: product.images.length,
        child: Stack(
          children: <Widget>[
            TabBarView(
              children: product.images.map((image) {
                return Image.network(
                  image,
                  fit: BoxFit.cover,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          product.businessName,
          style: TextStyle(
              fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 12.0),
        Text(
          'Category: ${product.category}',
          style: TextStyle(fontSize: 18.0, color: Colors.grey[800]),
        ),
        SizedBox(height: 8.0),
        Text(
          'Address: ${product.address}, ${product.city}, ${product.state} - ${product.zipcode}',
          style: TextStyle(fontSize: 18.0, color: Colors.grey[800]),
        ),
        SizedBox(height: 8.0),
        Text(
          'Country: ${product.country}',
          style: TextStyle(fontSize: 18.0, color: Colors.grey[800]),
        ),
        SizedBox(height: 8.0),
        Text(
          'Phone: ${product.phonenumber.toString()}',
          style: TextStyle(fontSize: 18.0, color: Colors.grey[800]),
        ),
        SizedBox(height: 8.0),
        Text(
          'Email: ${product.email}',
          style: TextStyle(fontSize: 18.0, color: Colors.grey[800]),
        ),
      ],
    );
  }

  Widget _buildDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Divider(),
        SizedBox(height: 16.0),
        Text(
          "GENERAL DETAILS",
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 8.0),
        Text(
          product.generalDetail ?? 'Details unavailable',
          style: TextStyle(fontSize: 18.0, color: Colors.grey[800]),
        ),
        SizedBox(height: 16.0),
        Divider(),
        Divider(),
        Text(
          "BASIC PRICE",
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 8.0),
        Text(
          'Rs. ${product.price.toString()}',
          style: TextStyle(fontSize: 18.0, color: Colors.grey[800]),
        ),
        SizedBox(height: 8.0),
        Text(
          "BASIC PACKAGE DETAILS",
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Text(
          product.priceDescription ?? 'Details unavailable',
          style: TextStyle(fontSize: 18.0, color: Colors.grey[800]),
        ),
        SizedBox(height: 16.0),
        Divider(),
        SizedBox(height: 16.0),
        Text(
          "INSURANCE",
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 8.0),
        Text(
          'Insure Value: ${product.insureValue}',
          style: TextStyle(fontSize: 18.0, color: Colors.grey[800]),
        ),
        SizedBox(height: 8.0),
        Text(
          'Licensed Value: ${product.licensedValue}',
          style: TextStyle(fontSize: 18.0, color: Colors.grey[800]),
        ),
        SizedBox(height: 16.0),
        Divider(),
        SizedBox(height: 16.0),
        Text(
          "BANK INFORMATION",
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 8.0),
        Text(
          'Bank Name: ${product.bankName}',
          style: TextStyle(fontSize: 18.0, color: Colors.grey[800]),
        ),
        SizedBox(height: 8.0),
        Text(
          'Beneficiary Name: ${product.benificiaryName}',
          style: TextStyle(fontSize: 18.0, color: Colors.grey[800]),
        ),
        SizedBox(height: 8.0),
        Text(
          'Account Number: ${product.accountNumber.toString()}',
          style: TextStyle(fontSize: 18.0, color: Colors.grey[800]),
        ),
      ],
    );
  }
}
