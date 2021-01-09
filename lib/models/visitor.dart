// Created by AMIT JANGID on 08/01/21.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housing_society_app/utils/constants.dart';

class Visitor {
  bool approved;
  bool dailyVisitor;
  String visitorName;
  String visitorType;
  String visitorPhoto;
  Timestamp visitingDate;

  Visitor({this.approved, this.dailyVisitor, this.visitorName, this.visitorType, this.visitorPhoto, this.visitingDate});

  factory Visitor.fromJson(Map<String, dynamic> _visitorJson) => Visitor(
        approved: _visitorJson[kFieldApproved],
        visitorName: _visitorJson[kFieldVisitorName],
        visitorType: _visitorJson[kFieldVisitorType],
        dailyVisitor: _visitorJson[kFieldDailyVisitor],
        visitorPhoto: _visitorJson[kFieldVisitorPhoto],
        visitingDate: _visitorJson[kFieldVisitingDate],
      );

  Map<String, dynamic> toMap() => {
        kFieldApproved: approved,
        kFieldVisitorName: visitorName,
        kFieldVisitorType: visitorType,
        kFieldDailyVisitor: dailyVisitor,
        kFieldVisitorPhoto: visitorPhoto,
        kFieldVisitingDate: visitingDate,
      };
}
