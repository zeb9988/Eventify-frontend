// ignore_for_file: use_build_context_synchronously, duplicate_ignore, non_constant_identifier_names

import 'dart:convert';

import 'package:eventify/common/widgets/customSnackbar.dart';
import 'package:eventify/prooviders/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../utils/ip_adress.dart';
import '../../../utils/error.dart';
import 'package:provider/provider.dart';
import '../../../models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../UserHome/screens/home_screen.dart';
import '../../admin/screens/Home-Screen.dart';

class AuthService {
  // sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    // required String password,
    required String name,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? fcm = prefs.getString('fcmToken');
    try {
      User user = User(
          id: '',
          name: name,
          password: '',
          email: email,
          address: '',
          type: '',
          token: '',
          fcm_token: fcm!,
          cart: [],
          favorites: []);

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showCustomSnackBar(
              context: context,
              text:
                  'Account created! We send your password on your typed email',
              label: 'ok',
              onPressed: () {});
          // showSnackBar(
          //   context,
          //   'Account created! Login with the same credentials!',
          // );
        },
      );
    } catch (e) {
      showCustomSnackBar(
          context: context, text: e.toString(), label: 'ok', onPressed: () {});
      // showSnackBar(context, e.toString());
    }
  }

  void Forgetpassword(
      {required BuildContext context, required String email}) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/reset'),
        body: jsonEncode({'email': email}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            showCustomSnackBar(
                context: context,
                text: "Password is sent to email successfully!",
                label: 'ok',
                onPressed: () {});
          });
    } catch (e) {
      showCustomSnackBar(
          context: context, text: e.toString(), label: 'ok', onPressed: () {});
    }
  }

  // sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? updatedfcm = prefs.getString('fcmToken');
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode(
            {'email': email, 'password': password, 'fcmtoken': updatedfcm}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);

            if (Provider.of<UserProvider>(context, listen: false).user.type ==
                'user') {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Homepage.id,
                (route) => false,
              );
            } else {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AdminHomeScreen.id,
                (route) => false,
              );
            }
          });
    } catch (e) {
      showCustomSnackBar(
          context: context, text: e.toString(), label: 'ok', onPressed: () {});
    }
  }

  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      // showSnackBar(context, e.toString());
    }
  }
}
