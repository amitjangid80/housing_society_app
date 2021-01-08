// Created by AMIT JANGID on 08/01/21.

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:housing_society_app/utils/constants.dart';

class DbProvider {
  DbProvider._();

  Database _database;
  static final DbProvider db = DbProvider._();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDb();
    return _database;
  }

  _initDb() async {
    String _path = join(await getDatabasesPath(), kDatabaseName);

    return await openDatabase(
      _path,
      version: 4,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(_facilityTableCreateQuery);
      },
    );
  }

  String _facilityTableCreateQuery = "CREATE TABLE IF NOT EXISTS $kTableFacility "
      "($kColumnCode INTEGER AUTOINCREMENT, "
      "$kColumnFacilityName TEXT, "
      "$kColumnFacilityImage TEXT, "
      "$kColumnFacilityCharges REAL, "
      "$kColumnFacilityAvailable INTEGER)";
}
