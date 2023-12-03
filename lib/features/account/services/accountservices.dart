import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/snackbar.dart';
import '../../authentication/screens/Login.dart';

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
    showSnackBar(context, e.toString());
  }
}
