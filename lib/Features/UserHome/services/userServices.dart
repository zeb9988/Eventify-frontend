import 'dart:convert';
// import 'dart:html';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:eventify/common/widgets/customSnackbar.dart';
import 'package:eventify/features/home/screens/edit.dart';
import 'package:eventify/models/producted.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../models/Product.dart';
import '../../../models/user.dart';
import '../../../prooviders/provider.dart';
import '../../../utils/error.dart';
import '../../../utils/ip_adress.dart';

class UserServices {
  void editProducts(
      {required BuildContext context,
      required String businessName,
      required String? id,
      required String address,
      required String city,
      required String state,
      required double zipcode,
      required List<String> images,
      required String country,
      required double phonenumber,
      required String email,
      required String generalDetail,
      required String bankName,
      required String benificiaryName,
      required double accountNumber,
      required double price,
      required String priceDescription,
      required String category,
      required String insuredValue,
      required String licenseHolder,
      required VoidCallback onsuccess}) async {
    try {
      Product prod = Product(
          id: id,
          images: images,
          businessName: businessName,
          address: address,
          city: city,
          priceDescription: priceDescription,
          state: state,
          zipcode: zipcode,
          country: country,
          phonenumber: phonenumber,
          email: email,
          generalDetail: generalDetail,
          insureValue: insuredValue,
          licensedValue: licenseHolder,
          bankName: bankName,
          benificiaryName: benificiaryName,
          accountNumber: accountNumber,
          price: price,
          category: category);
      http.Response response = await http.patch(
        Uri.parse('$uri/api/editProducts'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token':
              Provider.of<UserProvider>(context, listen: false).user.token
        },
        body: prod.toJson(),
      );
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            onsuccess();
          });
    } catch (e) {
      showCustomSnackBar(context: context, text: e.toString(), label: 'ok', onPressed: (){});
    }
  }

  void editUser(
      {required BuildContext context,
      required String name,
      required String address}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final String authToken = userProvider.user.token;

      http.Response response = await http.patch(
        Uri.parse('$uri/api/editUser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': authToken,
        },
        body: jsonEncode({"name": name, "address": address}),
      );

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            // Update the UserProvider with the updated user data and token
            User user = userProvider.user.copyWith(
              name: jsonDecode(response.body)['name'],
              address: jsonDecode(response.body)['address'],
            );
            userProvider.setUserFromModel(user);
            showCustomSnackBar(context: context, text: "User name added successfully!", label: 'ok', onPressed: (){});
          });
    } catch (e) {
      showCustomSnackBar(context: context, text: e.toString(), label: 'ok', onPressed: (){});
    }
  }

  void deleteVendor(
      {required BuildContext context,
      required Product product,
      required VoidCallback onsuccess}) async {
    try {
      http.Response response = await http.delete(
        Uri.parse('$uri/api/delete-User-As-Vendor'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token':
              Provider.of<UserProvider>(context, listen: false).user.token
        },
        body: jsonEncode({
          "id": product.id,
        }),
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: response, context: context, onSuccess: onsuccess);
    } catch (e) {
      showCustomSnackBar(context: context, text: e.toString(), label: 'ok', onPressed: (){});
    }
  }
}
