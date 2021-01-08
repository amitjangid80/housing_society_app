// Created by AMIT JANGID on 07/01/21.

import 'package:housing_society_app/utils/constants.dart';

class Users {
  String uid;
  String name;
  String email;
  String username;
  String status;
  int state;
  String profilePhoto;

  Users({
    this.uid,
    this.name,
    this.email,
    this.username,
    this.status,
    this.state,
    this.profilePhoto,
  });

  factory Users.fromJson(Map<String, dynamic> _userJson) => Users(
        uid: _userJson[kFieldUid],
        name: _userJson[kFieldName],
        email: _userJson[kFieldEmail],
        username: _userJson[kFieldUserName],
        status: _userJson[kFieldStatus],
        state: _userJson[kFieldState],
        profilePhoto: _userJson[kFieldProfilePhoto],
      );

  Map<String, dynamic> toMap() => {
        kFieldUid: uid,
        kFieldName: name,
        kFieldEmail: email,
        kFieldUserName: username,
        kFieldStatus: status,
        kFieldState: state,
        kFieldProfilePhoto: profilePhoto,
      };
}
