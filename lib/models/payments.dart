// Created by AMIT JANGID on 08/01/21.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housing_society_app/utils/constants.dart';

class Payments {
  int amount;
  String billMonth;
  String description;
  bool paid;
  Timestamp paidOn;

  Payments({this.amount, this.billMonth, this.description, this.paid, this.paidOn});

  factory Payments.fromJson(Map<String, dynamic> _paymentsJson) => Payments(
        amount: _paymentsJson[kFieldAmount],
        billMonth: _paymentsJson[kFieldBillMonth],
        description: _paymentsJson[kFieldDescription],
        paid: _paymentsJson[kFieldPaid],
        paidOn: _paymentsJson[kFieldPaidOn],
      );
}
