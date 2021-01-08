// Created by AMIT JANGID on 07/01/21.

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:housing_society_app/main.dart';
import 'package:housing_society_app/models/users.dart';
import 'package:housing_society_app/utils/constants.dart';
import 'package:housing_society_app/utils/utils.dart';

class AuthMethods {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static final CollectionReference _usersCollection = fireStore.collection(kUsersCollection);

  static Future<User> googleSignIn() async {
    try {
      GoogleSignInAccount _googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication _googleSignInAuthentication = await _googleSignInAccount.authentication;

      final AuthCredential _authCredential = GoogleAuthProvider.credential(
        idToken: _googleSignInAuthentication.idToken,
        accessToken: _googleSignInAuthentication.accessToken,
      );

      UserCredential _userCredentials = await _firebaseAuth.signInWithCredential(_authCredential);
      User _user = _userCredentials.user;

      return _user;
    } catch (e, s) {
      debugPrint('exception while performing login: ${e.toString()} \n$s');

      return null;
    }
  }

  static Future<bool> authenticateUser(User user) async {
    QuerySnapshot _querySnapshot =
        await fireStore.collection(kUsersCollection).where(kFieldEmail, isEqualTo: user.email).get();

    final List<DocumentSnapshot> _documentSnapshot = _querySnapshot.docs;

    // if user is registered then length of list > 0 or else less than 0
    return _documentSnapshot.length == 0 ? false : true;
  }

  static Future<void> addDataToDb(User _user) async {
    String _userName = getUserName(_user.email);

    Users _users = Users(
      uid: _user.uid,
      email: _user.email,
      username: _userName,
      name: _user.displayName,
      profilePhoto: _user.photoURL,
    );

    fireStore.collection(kUsersCollection).doc(_user.uid).set(_users.toMap());
  }

  static Future<User> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  static Future<Users> getUserDetails() async {
    User _currentUser = await getCurrentUser();
    DocumentSnapshot _documentSnapshot = await _usersCollection.doc(_currentUser.uid).get();

    return Users.fromJson(_documentSnapshot.data());
  }

  static Future<bool> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();

      return true;
    } catch (e, s) {
      debugPrint("exception while signing out: $e\n$s");

      return false;
    }
  }
}
