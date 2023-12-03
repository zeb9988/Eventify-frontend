import 'dart:convert';
import 'package:eventify/models/Product.dart';
import 'package:eventify/models/user.dart';
import 'package:eventify/prooviders/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../utils/error.dart';
import '../../../utils/ip_adress.dart';
import '../../../utils/snackbar.dart';

class FavoriteServices {
  void addToFav({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-favorites'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user
              .copyWith(favorites: jsonDecode(res.body)['favorites']);
          userProvider.setUserFromModel(user);
          showCustomDialog(
              context, 'Product Added To Favorites', Icons.heart_broken);
          // showSnackBar(context,
          //     'Product Added Successfully if u have previous product it will be removed');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
  // Future addToFav(
  //     {required BuildContext context, required String productid}) async {
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);

  //   try {
  //     http.Response res = await http.post(
  //       Uri.parse('$uri/api/add-to-favorites'),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'x-auth-token': userProvider.user.token,
  //       },
  //       body: jsonEncode({
  //         'id': productid,
  //       }),
  //     );

  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () {
  //         User user =
  //             userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
  //         userProvider.setUserFromModel(user);
  //         showCustomDialog(
  //             context, 'Product Added To Favorites', Icons.heart_broken);
  //         // showSnackBar(context,
  //         //     'Product Added Successfully if u have previous product it will be removed');
  //       },
  //     );
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  // }
  void removeFav(
      {required BuildContext context, required Product product}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res =
          await http.delete(Uri.parse('$uri/api/remove-favorites'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              body: jsonEncode({"id": product.id}));

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user
              .copyWith(favorites: jsonDecode(res.body)['favorites']);
          userProvider.setUserFromModel(user);

          // showSnackBar(context,
          //     'Product Added Successfully if u have previous product it will be removed');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Future getFav({required BuildContext context}) async {
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);

  //   try {
  //     http.Response res = await http.get(
  //       Uri.parse('$uri/api/get-favorites'),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'x-auth-token': userProvider.user.token,
  //       },
  //     );

  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () {
  //         // User user =
  //         //     userProvider.user.copyWith(favorites: jsonDecode(res.body)['favorites']);
  //         // userProvider.setUserFromModel(user);
  //         showCustomDialog(context, 'Product fetched', Icons.heart_broken);
  //         // showSnackBar(context,
  //         //     'Product Added Successfully if u have previous product it will be removed');
  //       },
  //     );
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  // }
}
