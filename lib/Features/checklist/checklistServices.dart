import 'dart:convert';

import 'package:eventify/Models/todoList.dart';
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
      required String desc,
      required VoidCallback onsuccess}) async {
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

      httpErrorHandle(response: res, context: context, onSuccess: onsuccess);
    } catch (e) {
      showCustomSnackBar(
          context: context, text: e.toString(), label: 'Ok', onPressed: () {});
    }
  }

  void deleteTodoList(
      {required BuildContext context,
      required TodoList todoitem,
      required VoidCallback onsuccess}) async {
    final userProvider = Provider.of<UserProvider>(context,
        listen: false); // catch token from here
    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/delete-Todo'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': todoitem.id}),
      );

      httpErrorHandle(response: res, context: context, onSuccess: onsuccess);
    } catch (e) {
      showCustomSnackBar(
          context: context, text: e.toString(), label: 'Ok', onPressed: () {});
    }
  }

  Future<List<TodoList>> fetchTodoList(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<TodoList> todos = [];
    try {
      final res = await http.get(
        Uri.parse('$uri/api/todofetch'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            todos.add(
              TodoList.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
      return todos;
    } catch (e) {
      print('Error fetching todo list: $e');
      throw e;
    }
  }
}
