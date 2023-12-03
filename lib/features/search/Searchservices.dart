import 'dart:convert';

import 'package:eventify/prooviders/provider.dart';
import 'package:eventify/utils/error.dart';
import 'package:eventify/utils/ip_adress.dart';
import 'package:eventify/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../models/Product.dart';

class Searchservices {
  Future<List<Product>> fetchsearchproduct(
      {required BuildContext context, required String Searchquery}) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    print(userprovider.user.token);
    List<Product>? product = [];
    try {
      http.Response res = await http
          .get(Uri.parse("$uri/api/product/search/$Searchquery"), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userprovider.user.token
      });
      print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            product.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    print(product);
    return product;
  }
}
