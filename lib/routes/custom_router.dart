// Created by AMIT JANGID on 07/01/21.

import 'package:flutter/material.dart';
import 'package:housing_society_app/routes/routes.dart';
import 'package:housing_society_app/screens/screens.dart';

class CustomRouter {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case dashboardRoute:
        return MaterialPageRoute(builder: (_) => DashboardScreen());

      default:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}
