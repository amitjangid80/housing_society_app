// Created by AMIT JANGID on 07/01/21.

import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF489C21);
const kPrimaryDarkColor = Color(0xFF4B6661);
const kPrimaryLightColor = Color(0xFF9BD179);

ThemeData themeData() {
  return ThemeData(
    cursorColor: kPrimaryColor,
    accentColor: kPrimaryColor,
    buttonTheme: _buttonTheme(),
    primaryColor: kPrimaryColor,
    primaryColorDark: kPrimaryDarkColor,
    primaryColorLight: kPrimaryLightColor,
    scaffoldBackgroundColor: Colors.grey[200],
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(button: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{TargetPlatform.iOS: CupertinoPageTransitionsBuilder()},
    ),
  );
}

ButtonThemeData _buttonTheme() {
  return ButtonThemeData(
    height: 40,
    buttonColor: kPrimaryColor,
    splashColor: Colors.white54,
    textTheme: ButtonTextTheme.primary,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
    gapPadding: 5,
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: kPrimaryColor),
  );

  return InputDecorationTheme(
    focusColor: kPrimaryColor,
    border: _outlineInputBorder,
    enabledBorder: _outlineInputBorder,
    focusedBorder: _outlineInputBorder,
    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
  );
}
