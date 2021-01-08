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

      case visitorsRoute:
        return MaterialPageRoute(builder: (_) => VisitorsScreen());

      case addVisitorRoute:
        return MaterialPageRoute(builder: (_) => AddVisitorScreen());

      case paymentsRoute:
        return MaterialPageRoute(builder: (_) => PaymentsScreen());

      case facilitiesRoute:
        return MaterialPageRoute(builder: (_) => FacilitiesScreen());

      default:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}
