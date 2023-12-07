import 'dart:convert';

import 'package:eventify/common/widgets/customSnackbar.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// void httpErrorHandle({
//   required http.Response response,
//   required BuildContext context,
//   required VoidCallback onSuccess,
// }) {
//   switch (response.statusCode) {
//     case 200:
//       onSuccess();
//       break;
//     case 400:
//       showCustomSnackBar(context: context, text: jsonDecode(response.body)['msg'], label: 'ok', onPressed: (){});
//       break;
//     case 500:
//       showCustomSnackBar(context: context, text: jsonDecode(response.body)['error'], label: 'ok', onPressed: (){});
//       // showSnackBar(context, jsonDecode(response.body)['error']);
//       break;
//     default:
//       showSnackBar(context, response.body);
//   }
// }
void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 201:
      // Handle successful creation
      onSuccess();
      break;
    case 204:
      // Handle successful but no content
      onSuccess();
      break;
    case 400:
      showCustomSnackBar(
          context: context,
          text: jsonDecode(response.body)['msg'] ?? 'Bad Request',
          label: 'OK',
          onPressed: () {});
      break;
    case 401:
      // Handle unauthorized
      showCustomSnackBar(
          context: context,
          text: 'Unauthorized: Please login',
          label: 'OK',
          onPressed: () {});
      break;
    case 403:
      // Handle forbidden
      showCustomSnackBar(
          context: context,
          text: 'Forbidden: You do not have permission',
          label: 'OK',
          onPressed: () {});
      break;
    case 404:
      // Handle not found
      showCustomSnackBar(
          context: context,
          text: 'Not Found: Resource not available',
          label: 'OK',
          onPressed: () {});
      break;
    case 500:
      showCustomSnackBar(
          context: context,
          text: jsonDecode(response.body)['error'] ?? 'Internal Server Error',
          label: 'OK',
          onPressed: () {});
      break;
    case 503:
      // Handle service unavailable
      showCustomSnackBar(
          context: context,
          text: 'Service Unavailable: Please try again later',
          label: 'OK',
          onPressed: () {});
      break;
    default:
      showCustomSnackBar(text: 'Unexpected Error: ${response.statusCode}', label: "ok",onPressed: (){}, context: context);
  }
}
