import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:eventify/models/approvedVendor.dart';

// import 'package:amazon/provider/userprovider.dart';
// import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:eventify/prooviders/provider.dart';
import 'package:eventify/utils/error.dart';
import 'package:eventify/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../common/widgets/customSnackbar.dart';
import '../../../models/Product.dart';
import '../../../utils/ip_adress.dart';

class VendorServices {
  Future<List<ApprovedVendors>> fetchVendors(
      {required BuildContext context}) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    List<ApprovedVendors>? vendor = [];

    try {
      http.Response res =
          await http.get(Uri.parse("$uri/api/fetchVendors"), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userprovider.user.token
      });

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            vendor.add(
              ApprovedVendors.fromJson(
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
    // print(vendor[1].catagory);
    return vendor;
  }

  Future<List<Product>> fetchpendingVendors(
      {required BuildContext context}) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    List<Product>? pendingVendor = [];
    try {
      http.Response res =
          await http.get(Uri.parse("$uri/api/fetchPendingVendors"), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userprovider.user.token
      });

      print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            pendingVendor.add(
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
    // print(vendor[1].catagory);
    return pendingVendor;
  }

  Future<List<Product>> fetchuserVendor({required BuildContext context}) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    List<Product>? userVendor = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/userVendor'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userprovider.user.token
      });
      print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            userVendor.add(
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
    // print(vendor[1].catagory);
    return userVendor;
  }

  void vendorRequests(
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

      // print(catagory);
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
          price: price,
          category: category);

      http.Response response = await http.post(
        Uri.parse('$uri/api/vendorReq'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token':
              Provider.of<UserProvider>(context, listen: false).user.token
        },
        body: prod.toJson(),
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showCustomSnackBar(
                text: "Your request sent to admin successfully",
                onPressed: () {},
                label: 'ok',
                context: context);
          });
    } catch (e) {
      showCustomSnackBar(
          text: e.toString(), context: context, label: 'ok', onPressed: () {});
    }
  }

  void acceptApproval(
      {required BuildContext context,
      required String businessName,
      required String address,
      required String city,
      required String state,
      required double zipcode,
      required List<String> images,
      required String country,
      required double phonenumber,
      required String category,
      required String email,
      required String generalDetail,
      required String bankName,
      required String benificiaryName,
      required double accountNumber,
      required double price,
      required String insuredValue,
      required String userId,
      required String licenseHolder}) async {
    try {
      // final cloudinary = CloudinaryPublic('deprueuwl', 'bnq90myj');

      List<String> imageUrls = images;
      // for (int i = 0; i < images.length; i++) {
      //   CloudinaryResponse res = await cloudinary
      //       .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
      //   imageUrls.add(res.secureUrl);
      // }

      ApprovedVendors prod = ApprovedVendors(
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
          price: price,
          userId: userId,
          category: category);
      // print(catagory);
      http.Response response = await http.post(
        Uri.parse('$uri/admin/addVendor'),
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
            showCustomSnackBar(
                context: context,
                text: 'Product added successfully!!',
                label: 'Ok',
                onPressed: () {});
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // void acceptApproval({

  //   required BuildContext context,
  //   required String name,
  //   required String description,
  //   required double price,
  //   required double quantity,
  //   required String catagory,
  //   required List<File> images,

  // }) async {
  //   try {
  //     // final cloudinary = CloudinaryPublic('deprueuwl', 'bnq90myj');

  //     List<String> imageUrls = [];
  //     // for (int i = 0; i < images.length; i++) {
  //     //   CloudinaryResponse res = await cloudinary
  //     //       .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
  //     //   imageUrls.add(res.secureUrl);
  //     // }

  //     Product prod = Product(
  //         name: name,
  //         description: description,
  //         quantity: quantity,
  //         images: imageUrls,
  //         catagory: catagory,
  //         price: price);

  //     http.Response response = await http.post(
  //       Uri.parse('$uri/admin/addproduct'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'x-auth-token':
  //             Provider.of<UserProvider>(context, listen: false).user.token
  //       },
  //       body: prod.toJson(),
  //     );

  //     httpErrorHandle(
  //         response: response,
  //         context: context,
  //         onSuccess: () {
  //           showSnackBar(context, " product added success");
  //         });
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  // }

  void removeApproval(
      {required BuildContext context,
      required ApprovedVendors product,
      required VoidCallback onsuccess
      // required String name,
      // required String description,
      // required double price,
      // required double quantity,
      // required String catagory,
      // required List<File> images,
      }) async {
    try {
      http.Response response = await http.delete(
        Uri.parse('$uri/admin/deleteVendor'),
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
            print('donrrr');
            onsuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
