// Created by AMIT JANGID on 07/01/21.

import 'package:flutter/material.dart';
import 'package:housing_society_app/firebase/auth_methods.dart';
import 'package:housing_society_app/models/users.dart';

class UsersBloc extends ChangeNotifier {
  Users _users;
  bool _isLoading = true;

  Users get users => _users;

  bool get isLoading => _isLoading;

  set users(Users users) {
    _users = users;
    notifyListeners();
  }

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  getCurrentUserDetails() async {
    // calling get user details method
    users = await AuthMethods.getUserDetails();
    isLoading = false;
  }
}
