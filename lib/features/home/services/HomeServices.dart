import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../models/Product.dart';
import '../../../prooviders/provider.dart';
import '../../../utils/error.dart';
import '../../../utils/ip_adress.dart';
import '../../../utils/snackbar.dart';
// import '../widgets/sales.dart';

class HomeServices {
  Future<List<Product>> bestSeller({required BuildContext context}) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    print(userprovider.user.token);
    List<Product> products = [];
    //  Product(
    //         businessName: '',
    //         address: '',
    //         city: '',
    //         state: '',
    //         zipcode: 0,
    //         images: [],
    //         country: '',
    //         phonenumber: 0,
    //         email: '',
    //         generalDetail: '',
    //         insureValue: '',
    //         licensedValue: '',
    //         bankName: '',
    //         benificiaryName: '',
    //         accountNumber: 0,
    //         price: 0,
    //         category: '');
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
            print('asdas');
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    print(products);
    return products;
  }

  Future<List<Product>> fetchsearchproduct(
      {required BuildContext context, required String catagory}) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    print(userprovider.user.token);
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
      showSnackBar(context, e.toString());
    }
    print(product);
    return product;
  }

  Future<List<Product>> fetchproduct({required BuildContext context}) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    print(userprovider.user.token);
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
      showSnackBar(context, e.toString());
    }
    print(product);
    return product;
  }

  // Future<Map<String, dynamic>> fetchFilterVendor(
  //     {required BuildContext context, required String catagory}) async {
  //   final userprovider = Provider.of<UserProvider>(context, listen: false);
  //   print(userprovider.user.token);
  //
  //   // List product = [];
  //   List photo = [];
  //   int rent = 7;
  //   // List<Product> rent = [];
  //   try {
  //     http.Response res = await http
  //         .get(Uri.parse("$uri/api/filter?catagory=$catagory"), headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'x-auth-token': userprovider.user.token
  //     });
  //
  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () {
  //         var response = jsonDecode(res.body);
  //         // print(response['photographer']);
  //
  //         // rent = response['rentCar'];
  //         // print(response['rentCar']);
  //         // print(photo);
  //         // print(rent);
  //         // sales = [
  //         //   Sales('Mobiles', response['mobileEarnings']),
  //         //   Sales('Essentials', response['essentialEarnings']),
  //         //   Sales('Books', response['booksEarnings']),
  //         //   Sales('Appliances', response['applianceEarnings']),
  //         //   Sales('Fashion', response['fashionEarnings']),
  //         // ];
  //
  //         for (int i = 0; i < response.length; i++) {
  //           photo.add(response['photographer']);
  //           // ven.add(
  //           //   Product.fromJson(
  //           //     jsonEncode(
  //           //       jsonDecode(res.body)[0],
  //           //     ),
  //           //   ),
  //           // );
  //         }
  //       },
  //     );
  //
  //     // print(photo);
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  //   // print(ven);
  //   return {'photo': photo};
  // }

  Future<Map<String, dynamic>> fetchFilterVendor(
      {required BuildContext context, required String catagory}) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    print(userprovider.user.token);

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
          print(response);
          for (int i = 0; i < response['photographer'].length; i++) {
            photog.add([response['photographer'][i]]);
            print(response['photographer'][i]);
          }

          for (int i = 0; i < response['venues'].length; i++) {
            print('asdas');
            venu.add([response['venues'][i]]);
            print(response['venues'][i]);
          }

          for (int i = 0; i < response['Videographer'].length; i++) {
            print('asdas');
            Videographer.add([response['Videographer'][i]]);
            print(response['Videographer'][i]);
          }
          for (int i = 0; i < response['Catering'].length; i++) {
            print('asdas');
            catering.add([response['Catering'][i]]);
            print(response['Catering'][i]);
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
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
