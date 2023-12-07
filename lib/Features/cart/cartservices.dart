// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:eventify/prooviders/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../common/widgets/customSnackbar.dart';
import '../../models/Product.dart';
import '../../models/user.dart';
import '../../utils/error.dart';
import '../../utils/ip_adress.dart';
import 'cart_screen.dart';

class CartServices {
  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-cart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user =
              userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
          userProvider.setUserFromModel(user);

          showCustomSnackBar(
            text:
                'Product Added Successfully. If you have a previous product, it will be deleted',
            context: context,
            label: 'Check',
            onPressed: () {
              Navigator.pushNamed(context, CartScreen.id);
            },
          );
        },
      );
    } catch (e) {
      showCustomSnackBar(context: context, text: e.toString(), label: 'ok', onPressed: (){});
    }
  }

  void removeFromCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/remove-from-cart/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user =
              userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showCustomSnackBar(context: context, text: e.toString(), label: 'ok', onPressed: (){});
    }
  }
}
