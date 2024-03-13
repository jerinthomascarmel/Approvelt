// ignore_for_file: deprecated_member_use, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const defaultLightColor = Colors.deepOrange;
const defaultDarkColor = Colors.white;
const defaultWidgetColor = Colors.deepOrange;
const darkmodeColor = Color(0xFF121212);

class Themes {
  static ThemeData darkThem = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkmodeColor,
    primaryColor: defaultDarkColor,
    primarySwatch: defaultLightColor,
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: darkmodeColor,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: darkmodeColor,
          statusBarIconBrightness: Brightness.light,
        )),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: defaultDarkColor),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: darkmodeColor.withOpacity(0.8),
        selectedItemColor: defaultDarkColor,
        unselectedItemColor: Colors.grey.withOpacity(0.6)),

    //NOTE : set default bodytext1
    // ignore: duplicate_ignore
    textTheme: const TextTheme(
      // ignore: deprecated_member_use
      bodyText1: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      subtitle1: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      // ignore: deprecated_member_use
      bodyText2: TextStyle(
        color: Colors.white,
      ),
      // ignore: deprecated_member_use
      headline5:
          TextStyle(color: defaultDarkColor, fontWeight: FontWeight.bold),
    ),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: defaultLightColor,
    primarySwatch: defaultLightColor,
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        )),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(elevation: 10),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: defaultLightColor),

    //NOTE : set default bodytext1
    textTheme: const TextTheme(
        // ignore: deprecated_member_use
        bodyText1: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        // ignore: deprecated_member_use
        bodyText2: TextStyle(
          color: Colors.black,
        ),
        // ignore: deprecated_member_use
        subtitle1: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        // ignore: deprecated_member_use
        headline5:
            TextStyle(color: defaultLightColor, fontWeight: FontWeight.bold)),
  );
}
