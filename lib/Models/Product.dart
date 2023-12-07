// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:eventify/models/rating.dart';
// import 'dart:io';

// import 'package:amazon/models/ratring.dart';

class Product {
  final String businessName;
  final String address;
  final String city;
  final String state;
  final double zipcode;
  final List<String> images;
  final String country;
  final double phonenumber;
  final String email;
  final String generalDetail;
  final String insureValue;
  final String licensedValue;
  final String bankName;
  final String benificiaryName;
  final double accountNumber;
  final double price;
  final String priceDescription;
  final String category;
  final String? id;
  final List<Rating>? rating;
  bool isfav;
  Product(
      {required this.businessName,
      required this.address,
      required this.city,
      required this.state,
      required this.zipcode,
      required this.images,
      required this.country,
      required this.phonenumber,
      required this.email,
      required this.generalDetail,
      required this.insureValue,
      required this.licensedValue,
      required this.bankName,
      required this.benificiaryName,
      required this.accountNumber,
      required this.price,
      required this.priceDescription,
      required this.category,
      this.id,
      this.rating,
      this.isfav = false});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'businessName': businessName,
      'address': address,
      'city': city,
      'state': state,
      'zipcode': zipcode,
      'images': images,
      'country': country,
      'phonenumber': phonenumber,
      'email': email,
      'generalDetail': generalDetail,
      'insureValue': insureValue,
      'licensedValue': licensedValue,
      'bankName': bankName,
      'benificiaryName': benificiaryName,
      'accountNumber': accountNumber,
      'price': price,
      'priceDescription': priceDescription,
      'category': category,
      'id': id,
      'rating': rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      images: List<String>.from(map['images']),
      businessName: map['businessName'] ?? '',
      address: map['address'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      zipcode: map['zipcode']?.toDouble() ?? 0.0,
      country: map['country'] ?? '',
      phonenumber: map['phonenumber']?.toDouble() ?? 0.0,
      email: map['email'] ?? '',
      generalDetail: map['generalDetail'] ?? '',
      insureValue: map['insureValue'] ?? '',
      licensedValue: map['licensedValue'] ?? '',
      bankName: map['bankName'] ?? '',
      benificiaryName: map['benificiaryName'] ?? '',
      accountNumber: map['accountNumber']?.toDouble() ?? 0.0,
      price: map['price']?.toDouble() ?? 0.0,
      priceDescription: map['priceDescription'] ?? '',
      category: map['category'] ?? '',
      id: map['_id'],
      rating: map['rating'] != null
          ? List<Rating>.from(map['rating']?.map(
              (x) => Rating.fromMap(x),
            ))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
