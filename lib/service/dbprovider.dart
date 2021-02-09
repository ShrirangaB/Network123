import 'dart:io';
import 'package:path/path.dart';
import 'package:networkJsonAPp/model/empmodel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  String tableName = 'Details';
  String colId = 'id';
  String colName = 'name';
  String colUserName = 'username';
  String colEmail = 'email';
  String colPhone = 'phone';

  String tableAddress = 'address';
  String colId1 = 'id1';
  String street = 'street';
  String suite = 'suite';
  String city = 'city';
  String zip = 'ZipCode';

  String tableGeo = 'geoTable';
  String colId2 = 'id2';
  String lat = 'lattitude';
  String lng = 'longitude';

  String tableCompany = 'userCompany';
  String colId3 = 'id3';
  String cName = 'Company Name';
  String cPhrase = 'Catch Phrase';
  String bs = 'bs';

  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Employee table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'userdetails.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE $tableName($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colName TEXT, '
          '$colUserName TEXT,'
          '$colEmail TEXT,'
          '$colPhone INTEGER)');

      await db
          .execute('CREATE TABLE $tableAddress($colId1 INTEGER,$street TEXT, '
              '$suite TEXT,'
              '$city TEXT,'
              '$zip INTEGER)');
    });
  }

  // Insert employee on database
  createUserDetailsList(Employee userDetail) async {
    final db = await database;
    final res = await db.insert('Details', userDetail.toJson());

    return res;
  }

  Future<List<Employee>> getAllDetails() async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT $colId, $colUserName,$colPhone FROM $tableName INNER JOIN $tableAddress ON $tableName.$colId = $tableAddress.$colId1");

    List<Employee> list =
        res.isNotEmpty ? res.map((c) => Employee.fromJson(c)).toList() : [];

    return list;
  }
}
