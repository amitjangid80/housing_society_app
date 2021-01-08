// Created by AMIT JANGID on 08/01/21.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:housing_society_app/firebase/auth_methods.dart';

class AuthBloc extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future<bool> performLogin() async {
    isLoading = true;

    // calling google sign in method
    User _user = await AuthMethods.googleSignIn();

    if (_user != null) {
      // calling authenticate user
      bool _isNewUser = await AuthMethods.authenticateUser(_user);
      debugPrint('is new user value is: $_isNewUser');

      if (_isNewUser) {
        // calling add data to db method
        await AuthMethods.addDataToDb(_user);
      }

      isLoading = false;
      return true;
    } else {
      isLoading = false;
      debugPrint('error while signing with google');
    }

    return false;
  }
}
