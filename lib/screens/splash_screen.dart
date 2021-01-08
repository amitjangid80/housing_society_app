// Created by AMIT JANGID on 29/08/20.

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:housing_society_app/app_theme.dart';
import 'package:housing_society_app/firebase/auth_methods.dart';
import 'package:housing_society_app/routes/routes.dart';
import 'package:housing_society_app/utils/constants.dart';
import 'package:package_info/package_info.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _appVersion = '', _navigationRoute = loginRoute;

  @override
  void initState() {
    super.initState();

    // calling get app version method
    _getAppVersion();

    // calling check if logged in method
    _checkIfLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage(kIconHome), color: kPrimaryColor, width: _width * 0.20),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Text(
                    kAppName,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5.copyWith(color: kPrimaryColor),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                child: Text(
                  '$kVersion: $_appVersion',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6.copyWith(color: kPrimaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _checkIfLoggedIn() async {
    // calling get current user method
    User _user = await AuthMethods.getCurrentUser();

    if (_user != null) {
      _navigationRoute = dashboardRoute;
    }

    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushNamedAndRemoveUntil(context, _navigationRoute, (route) => false);
  }

  _getAppVersion() async {
    PackageInfo _packageInfo = await PackageInfo.fromPlatform();

    if (mounted) {
      setState(() => _appVersion = _packageInfo.version);
    }
  }
}
