import 'package:flutter/material.dart';

// ignore: constant_identifier_names
// const COLOR_PRIMARY = Color(0xff3B3B3B);
const COLOR_PRIMARY = Color(0xffECECEC);
// ignore: constant_identifier_names
const COLOR_ACCENT = Color(0xffD6A95C);

ThemeData lightTheme = ThemeData(
    // textTheme: GoogleFonts.poppinsTextTheme(
    //   Theme.of(context).textTheme,
    // ),
    iconTheme: IconThemeData(color: Colors.black),
    appBarTheme: const AppBarTheme(
      backgroundColor: COLOR_PRIMARY,
    ),
    brightness: Brightness.light,
    primaryColor: COLOR_PRIMARY,
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: COLOR_ACCENT),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
            backgroundColor: MaterialStateProperty.all<Color>(COLOR_ACCENT))),
    // inputDecorationTheme: InputDecorationTheme(
    //     border: OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(20.0),
    //         borderSide: BorderSide.none),
    //     filled: true,
    //     fillColor: Colors.grey.withOpacity(0.1)),
    scaffoldBackgroundColor: Color(0xffECECEC));

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  switchTheme: SwitchThemeData(
    trackColor: MaterialStateProperty.all<Color>(Colors.grey),
    thumbColor: MaterialStateProperty.all<Color>(Colors.white),
  ),
  inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.1)),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0))),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          overlayColor: MaterialStateProperty.all<Color>(Colors.black26))),
);
