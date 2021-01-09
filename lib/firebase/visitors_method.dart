// Created by AMIT JANGID on 08/01/21.

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housing_society_app/main.dart';
import 'package:housing_society_app/models/users.dart';
import 'package:housing_society_app/models/visitor.dart';
import 'package:housing_society_app/utils/constants.dart';

class VisitorsMethod {
  static final CollectionReference _usersCollection = fireStore.collection(kUsersCollection);

  static Stream<QuerySnapshot> getVisitorsDetails({@required String userId}) =>
      _usersCollection.doc(userId).collection(kVisitorsCollection).snapshots();

  static Future<bool> addDataToVisitorsCollection({@required Users users, @required Visitor visitor}) async {
    try {
      return await fireStore
          .collection(kUsersCollection)
          .doc(users.uid)
          .collection(kVisitorsCollection)
          .doc()
          .set(visitor.toMap())
          .then((value) => true)
          .catchError((error) {
        debugPrint('error while adding visitor data to firebase: ${error.toString()}');
        return false;
      });
    } catch (e, s) {
      debugPrint('error while adding visitor data to firebase: ${e.toString()} $s');

      return false;
    }
  }
}
