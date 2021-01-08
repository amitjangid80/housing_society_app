// Created by AMIT JANGID on 08/01/21.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housing_society_app/main.dart';
import 'package:housing_society_app/utils/constants.dart';

class PaymentsMethod {
  static final CollectionReference _usersCollection = fireStore.collection(kUsersCollection);

  static Stream<QuerySnapshot> getPaymentDetails({@required String userId}) =>
      _usersCollection.doc(userId).collection(kPaymentsCollection).snapshots();
}
