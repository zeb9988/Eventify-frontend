import 'dart:convert';

import 'package:eventify/common/widgets/customSnackbar.dart';
import 'package:eventify/prooviders/provider.dart';
import 'package:eventify/utils/error.dart';
import 'package:eventify/utils/ip_adress.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../UserHome/screens/home_screen.dart';

class FeedbackServices {
  void feedback(
      {required BuildContext context,
      required double rating,
      required String feedback}) async {
    final userProvider = Provider.of<UserProvider>(context,
        listen: false); // catch token from here
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/Feedback'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'rating': rating, 'feedback': feedback}),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Homepage.id,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showCustomSnackBar(
          context: context, text: e.toString(), label: 'Ok', onPressed: () {});
    }
  }

  // Future<bool> getFeedback({required BuildContext context}) async {
  //   final userProvider = Provider.of<UserProvider>(context,
  //       listen: false); // catch token from here
  //   try {
  //     http.Response res = await http.post(
  //       Uri.parse('$uri/api/get-feedback'),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'x-auth-token': userProvider.user.token,
  //       },
  //     );
  //     Map<String, dynamic> responseData = json.decode(res.body);
  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () {
  //         showCustomSnackBar(
  //             context: context,
  //             text: 'Get Successfully',
  //             label: 'Ok',
  //             onPressed: () {});
  //       },
  //     );
  //     return responseData[]
  //   } catch (e) {
  //     showCustomSnackBar(
  //         context: context, text: e.toString(), label: 'Ok', onPressed: () {});
  //   }

  // }
}
