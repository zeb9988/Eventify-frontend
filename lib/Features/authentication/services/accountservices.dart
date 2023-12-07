// ignore_for_file: use_build_context_synchronously

import 'package:eventify/common/widgets/customSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/Login.dart';

void logOut(BuildContext context) async {
  try {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('x-auth-token', '');
    Navigator.pushNamedAndRemoveUntil(
      context,
      Login.id,
      (route) => false,
    );
  } catch (e) {
    showCustomSnackBar(context: context, text: e.toString(), label: 'Ok', onPressed: (){});
  }
}
