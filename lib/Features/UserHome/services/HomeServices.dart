// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../common/widgets/customSnackbar.dart';
import '../../../models/Product.dart';
import '../../../prooviders/provider.dart';
import '../../../utils/error.dart';
import '../../../utils/ip_adress.dart';
// import '../widgets/sales.dart';

class HomeServices {
  Future<List<Product>> bestSeller({required BuildContext context}) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    List<Product> products = [];

    try {
      http.Response res =
          await http.get(Uri.parse("$uri/api/deal-of-day"), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userprovider.user.token
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            products.add(
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
      showCustomSnackBar(context: context, text: e.toString(), label: 'ok', onPressed: (){});
    }
    return products;
  }

  Future<List<Product>> fetchsearchproduct(
      {required BuildContext context, required String catagory}) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    List<Product>? product = [];
    try {
      http.Response res = await http
          .get(Uri.parse("$uri/api/product?catagory=$catagory"), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userprovider.user.token
      });

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
      showCustomSnackBar(context: context, text: e.toString(), label: 'ok', onPressed: (){});
    }
    return product;
  }

  Future<List<Product>> fetchproduct({required BuildContext context}) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    List<Product>? product = [];
    try {
      http.Response res =
          await http.get(Uri.parse("$uri/api/getProduct"), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userprovider.user.token
      });

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
      showCustomSnackBar(context: context, text: e.toString(), label: 'ok', onPressed: (){});
    }
    return product;
  }



  Future<Map<String, dynamic>> fetchFilterVendor(
      {required BuildContext context, required String catagory}) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);

    List<List<Map<String, dynamic>>> photog =
        []; // Change the type to match the expected structure
    List<List<Map<String, dynamic>>> venu = [];
    List<List<Map<String, dynamic>>> Videographer = [];
    List<List<Map<String, dynamic>>> catering = [];
    try {
      http.Response res =
          await http.get(Uri.parse("$uri/api/filter"), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userprovider.user.token
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          var response = jsonDecode(res.body);
          for (int i = 0; i < response['photographer'].length; i++) {
            photog.add([response['photographer'][i]]);
          }

          for (int i = 0; i < response['venues'].length; i++) {
            venu.add([response['venues'][i]]);
          }

          for (int i = 0; i < response['Videographer'].length; i++) {
            Videographer.add([response['Videographer'][i]]);
          }
          for (int i = 0; i < response['Catering'].length; i++) {
            catering.add([response['Catering'][i]]);
          }
        },
      );
    } catch (e) {
      showCustomSnackBar(context: context, text: e.toString(), label: 'ok', onPressed: (){});
    }
    // print(venues);
    return {
      'photo': photog,
      'venues': venu,
      'Videographer': Videographer,
      'catering': catering
    };
  }
}
