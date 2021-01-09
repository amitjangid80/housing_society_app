// Created by AMIT JANGID on 09/01/21.

import 'package:flutter/material.dart';
import 'package:housing_society_app/db/housing_society_db.dart';
import 'package:housing_society_app/main.dart';
import 'package:housing_society_app/utils/constants.dart';

class Facility {
  int code;
  String facilityName;
  String facilityImage;
  int facilityAvailable;
  double facilityCharges;

  Facility({this.code, this.facilityName, this.facilityImage, this.facilityAvailable, this.facilityCharges});

  factory Facility.fromJson(Map<String, dynamic> _facilityJson) => Facility(
        code: _facilityJson[kColumnCode],
        facilityName: _facilityJson[kColumnFacilityName],
        facilityImage: _facilityJson[kColumnFacilityImage],
        facilityCharges: _facilityJson[kColumnFacilityCharges],
        facilityAvailable: _facilityJson[kColumnFacilityAvailable],
      );

  Map<String, dynamic> toMap() => {
        kColumnCode: code,
        kColumnFacilityName: facilityName,
        kColumnFacilityImage: facilityImage,
        kColumnFacilityCharges: facilityCharges,
        kColumnFacilityAvailable: facilityAvailable,
      };
}

class FacilityDb {
  static final String _tag = 'FacilityDb';

  static Future<int> insertIntoFacilityTable({@required Facility facility}) async {
    try {
      final _db = await DbProvider.db.database;
      var _result = await _db.insert(kTableFacility, facility.toMap());

      return _result;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: "exception while inserting records into facility table",
      );

      return -1;
    }
  }

  static Future<List<Facility>> getFacilitiesList() async {
    try {
      final _db = await DbProvider.db.database;

      var _query = "SELECT * FROM $kTableFacility";
      var _result = await _db.rawQuery(_query);

      List<Facility> _facilitiesList = (_result != null && _result.isNotEmpty)
          ? _result.map((_facilityJson) => Facility.fromJson(_facilityJson)).toList()
          : [];

      return _facilitiesList;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: "exception while getting list of facilities from db",
      );

      return [];
    }
  }
}

List<Facility> facilitiesList = [
  Facility(
    code: 1,
    facilityAvailable: 1,
    facilityCharges: 5000,
    facilityName: 'Club House',
    facilityImage: "https://cdn.pixabay.com/photo/2013/11/26/20/21/thorpeness-218936_960_720.jpg",
  ),
  Facility(
    code: 2,
    facilityAvailable: 0,
    facilityCharges: 2000,
    facilityName: 'Swimming Pool',
    facilityImage: "https://cdn.pixabay.com/photo/2018/01/29/05/14/luxury-3115234_960_720.jpg",
  ),
];
