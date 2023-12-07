import 'dart:convert';

import 'package:eventify/common/widgets/customSnackbar.dart';
import 'package:eventify/prooviders/provider.dart';
import 'package:eventify/utils/error.dart';
import 'package:eventify/utils/ip_adress.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../UserHome/screens/home_screen.dart';

class TodoServices {
  void todolist(
      {required BuildContext context,
      required String title,
      required String desc}) async {
    final userProvider = Provider.of<UserProvider>(context,
        listen: false); // catch token from here
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/Todo'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'title': title, 'desc': desc}),
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

  Future<List<Map<String, dynamic>>> fetchTodoList(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final response = await http.get(
        Uri.parse('$uri/api/todofetch'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      final responseBody = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(responseBody);
    } catch (e) {
      print('Error fetching todo list: $e');
      throw e;
    }
  }
}
