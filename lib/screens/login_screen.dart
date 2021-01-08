// Created by AMIT JANGID on 08/01/21.

import 'package:flutter/material.dart';
import 'package:housing_society_app/app_theme.dart';
import 'package:housing_society_app/blocs/auth_bloc.dart';
import 'package:housing_society_app/routes/routes.dart';
import 'package:housing_society_app/utils/constants.dart';
import 'package:multiutillib/multiutillib.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;

    final AuthBloc _authBloc = Provider.of<AuthBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: AssetImage(kIconHome), color: kPrimaryColor, width: _width * 0.24),
              const SizedBox(height: 20),
              Text('Login', style: Theme.of(context).textTheme.headline4),
              const SizedBox(height: 40),
              if (_authBloc.isLoading) ...[
                CircularProgressIndicator(),
              ] else ...[
                RaisedButton.icon(
                  elevation: 4,
                  color: Colors.white,
                  label: Text(kGoogleSignIn),
                  icon: Image(image: AssetImage(kIconGoogle), width: 24),
                  onPressed: () async {
                    // calling perform login method
                    bool _isLoginSuccess = await _authBloc.performLogin();

                    if (_isLoginSuccess) {
                      Navigator.pushNamedAndRemoveUntil(context, dashboardRoute, (route) => false);
                    } else {
                      // calling show custom dialog method
                      showCustomDialog(context, title: kWarning, description: kLoginFailedMsg);
                    }
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
