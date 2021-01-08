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
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(button: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
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
