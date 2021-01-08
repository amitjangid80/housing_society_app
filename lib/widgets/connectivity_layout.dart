// Created by AMIT JANGID on 07/01/21.

import 'package:flutter/material.dart';

import 'package:housing_society_app/utils/constants.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';

class ConnectivityLayout extends StatelessWidget {
  final Widget child;

  ConnectivityLayout({@required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: ConnectivityWidgetWrapper(
        child: child,
        color: Colors.red,
        disableInteraction: false,
        message: kInternetNotAvailable,
        alignment: Alignment.topCenter,
        messageStyle: const TextStyle(color: Colors.white),
      ),
    );
  }
}
