import 'dart:convert';
import 'dart:io';

// import 'package:amazon/provider/userprovider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:eventify/common/widgets/customSnackbar.dart';
import 'package:eventify/features/admin/model/feedback.dart';
import 'package:eventify/features/admin/model/sales.dart';
import 'package:eventify/features/admin/screens/Admin-Dashboard.dart';
import 'package:eventify/features/admin/screens/Users.dart';
import 'package:eventify/models/order.dart';
import 'package:eventify/prooviders/provider.dart';
import 'package:eventify/utils/error.dart';
import 'package:eventify/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../models/Product.dart';
import '../../../models/user.dart';
import '../../../utils/ip_adress.dart';

class AdminServices {
  Future<List<Product>> fetchcatagory(
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

  Future<List<Product>> fetchApprovedVendors(
      {required BuildContext context}) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    print(userprovider.user.token);
    List<Product>? product = [];
    try {
      http.Response res =
          await http.get(Uri.parse("$uri/admin/approved-vendors"), headers: {
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

  Future<List<Product>> fetchPendingVendors(
      {required BuildContext context}) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    print(userprovider.user.token);
    List<Product>? product = [];
    try {
      http.Response res =
          await http.get(Uri.parse("$uri/admin/pending-vendors"), headers: {
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

  Future<List<User>> fetchUsers({required BuildContext context}) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    print(userprovider.user.token);
    List<User> users = [];
    try {
      http.Response res =
          await http.get(Uri.parse("$uri/admin/get-all-users"), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userprovider.user.token
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            users.add(
              User.fromJson(
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
    print(users);
    return users;
  }

  Future<List<Order>> fetchSoldOrders({required BuildContext context}) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    print(userprovider.user.token);
    List<Order> soldOrders = [];
    try {
      http.Response res =
          await http.get(Uri.parse("$uri/admin/sold-orders"), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userprovider.user.token
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            soldOrders.add(
              Order.fromJson(
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
    print(soldOrders);
    return soldOrders;
  }

  void deleteUsers(
      {required BuildContext context,
      required User user,
      required VoidCallback onsuccess}) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    print(userprovider.user.token);
    // List<User> users = [];
    try {
      http.Response res = await http.delete(
        Uri.parse("$uri/admin/delete-users"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userprovider.user.token
        },
        body: jsonEncode({
          "id": user.id,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onsuccess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    // print(users);
    // return users;
  }

  void register(
      {required BuildContext context,
      required String email,
      required String password,
      required String name,
      required String type}) async {
    try {
      User user = User(
          id: '',
          name: name,
          password: password,
          email: email,
          address: '',
          type: type,
          token: '',
          fcm_token: '',
          cart: [],
          favorites: []);

      http.Response res = await http.post(
        Uri.parse('$uri/admin/register'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created!!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void deleteproduct(
      {required BuildContext context,
      required Product product,
      required VoidCallback onsuccess}) async {
    try {
      http.Response response = await http.delete(
        Uri.parse('$uri/admin/deleteproduct'),
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
          response: response,
          context: context,
          onSuccess: () {
            onsuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Order>> fetchMAllOrders({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-orders'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            print('asdas');
            orderList.add(
              Order.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
            print(orderList);
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orderList;
  }

  void sellproduct(
      {required BuildContext context,
      required String businessName,
      required String address,
      required String city,
      required String state,
      required double zipcode,
      required List<File> images,
      required String country,
      required double phonenumber,
      required String email,
      required String generalDetail,
      required String bankName,
      required String benificiaryName,
      required double accountNumber,
      required double price,
      required String category,
      required String insuredValue,
      required String licenseHolder}) async {
    try {
      final cloudinary = CloudinaryPublic('deprueuwl', 'bnq90myj');

      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(images[i].path, folder: businessName));
        imageUrls.add(res.secureUrl);
      }

      Product prod = Product(
          images: imageUrls,
          businessName: businessName,
          address: address,
          city: city,
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
          category: category,
          price: price);

      http.Response response = await http.post(
        Uri.parse('$uri/admin/addproduct'),
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
            showSnackBar(context, " product added success");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void changeOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': order.id,
          'status': status,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: onSuccess,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void sendNotification({
    required BuildContext context,
    required String title,
    required String body,
    required User user,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/send-notification'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'title': title, 'body': body, "userId": user.email}),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showCustomSnackBar(
            context: context,
            text: 'Successfully sent',
            label: 'ok',
            onPressed: () {},
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    double totalEarning = 0.0;
    double totalCommission = 0.0;
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/analytics'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          var response = jsonDecode(res.body);
          totalEarning = response['totalEarnings'];
          totalCommission = response['commission'];
          sales = [
            Sales('Photographer', response['PhotographerEarnings']),
            Sales('Videographer', response['VideographerEarnings']),
            Sales('Catering', response['CateringEarnings']),
            Sales('Florists', response['FloristsEarnings']),
            Sales('Entertainer', response['EntertainerEarnings']),
            Sales('Transportation Service',
                response['TransportationServiceEarnings']),
            Sales('Sound & Lighting', response['SoundLightingEarnings']),
            Sales('Security Service', response['SecurityServiceEarnings']),
            Sales('Event Invitations and Printing',
                response['EventInvitationsandPrintingEarnings']),
            Sales('Ticketing and Promotion',
                response['TicketingandPromotionEarnings']),
            Sales(
                'Branding & Marketing', response['BrandingMarketingEarnings']),
            Sales('Party Planner', response['PartyPlannerEarnings']),
            Sales('Event Planner', response['EventPlannerEarnings']),
            Sales('Venues', response['VenuesEarnings']),
            Sales('Wedding Planner', response['WeddingPlannerEarnings']),
            Sales(
                'Makeup Artist & Salon', response['MakeupArtistSalonEarnings']),
            Sales('Mehndi Artist', response['MehndiArtistEarnings']),
            Sales('Decorator', response['DecoratorEarnings']),
            Sales('Jewelry Store', response['JewelryStoreEarnings']),
            Sales('Wedding Car Decorators',
                response['WeddingCarDecoratorsEarnings']),
            Sales('Wedding Dress Boutique',
                response['WeddingDressBoutiqueEarnings']),
          ];
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return {
      'sales': sales,
      'totalEarnings': totalEarning,
      'commission': totalCommission
    };
  }

  Future<List<Feedbacks>> getFeedbacks(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Feedbacks> feedback = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/fetch-feedbacks'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            feedback.add(
              Feedbacks.fromJson(
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
    print(feedback);
    return feedback;
  }
}
