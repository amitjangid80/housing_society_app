// Created by AMIT JANGID on 08/01/21.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

DateTime _currentBackPressesTime;

String getUserName(String email) {
  return "${email.split('@')[0]}";
}

Future<bool> onWillPop() {
  DateTime _currentDate = DateTime.now();

  if (_currentBackPressesTime == null || _currentDate.difference(_currentBackPressesTime) > Duration(seconds: 2)) {
    _currentBackPressesTime = _currentDate;

    Fluttertoast.showToast(
      textColor: Colors.white,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.black,
      msg: 'Tap Back Button again to Exit the App.',
    );

    return Future.value(false);
  }

  exit(0);
}
