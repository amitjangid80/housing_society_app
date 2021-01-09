// Created by AMIT JANGID on 08/01/21.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housing_society_app/main.dart';
import 'package:housing_society_app/utils/constants.dart';

class PaymentsMethod {
  static Stream<QuerySnapshot> getPaymentDetails({@required String userId}) =>
      fireStore.collection(kPaymentsCollection).snapshots();
}
