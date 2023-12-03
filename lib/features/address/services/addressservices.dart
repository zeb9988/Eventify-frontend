// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:eventify/features/home/screens/home_screen.dart';
import 'package:eventify/prooviders/provider.dart';
import 'package:eventify/utils/ip_adress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../common/widgets/customSnackbar.dart';
import '../../../models/user.dart';
import '../../../utils/error.dart';
import '../../../utils/snackbar.dart';

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final users = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/save-user-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': users.user.token,
        },
        body: jsonEncode({
          'address': address,
        }),
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user =
              users.user.copyWith(address: jsonDecode(res.body)['address']);
          //  userProvider.user.copyWith(
          //   address: jsonDecode(res.body)['address'],
          // );

          users.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get all the products
  void placeOrder({
    required BuildContext context,
    required String address,
    required String totalSum,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(Uri.parse('$uri/api/order'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'cart': userProvider.user.cart,
            'address': address,
            'totalPrice': totalSum,
          }));

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            cart: [],
          );
          userProvider.setUserFromModel(user);
          Navigator.pushNamedAndRemoveUntil(
            context,
            Homepage.id,
            (route) => false,
          );
          showCustomSnackBar(
              context: context,
              label: 'Ok',
              onPressed: () {},
              text: 'Congratulations🎉🎉🎉 Your order has been placed!');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
