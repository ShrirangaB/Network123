// import 'dart:html';
import 'dart:io';

import 'package:networkJsonAPp/model/empmodel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProviderForJSON {
  final cityname = 'Mumbai';
  static Database _database;
  static final DBProviderForJSON db = DBProviderForJSON._();
  DBProviderForJSON._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'employee_manager.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Employee('
          'id INTEGER PRIMARY KEY,'
          'email TEXT,'
          'username TEXT,'
          'name TEXT'
          ')');
      await db.execute('CREATE TABLE Adress('
          'id INTEGER,'
          'street TEXT,'
          'suite TEXT,'
          'city TEXT,'
          'zipcode TEXT,'
          'FOREIGN KEY (id) REFERENCES Employee(id)'
          ')');
    });
  }

  createEmployee(Employee newEmployee) async {
    await deleteAllEmployees();
    // final db = await database;
    // final res = await db.insert('Employee', newEmployee.toJson());

    //  return res;

    final db = await database;
    final res = await db.insert('Employee', {
      'id': newEmployee.id,
      'email': newEmployee.email,
      'username': newEmployee.username,
      'name': newEmployee.name,
      // 'phone':newEmployee.phone,
    });

    Address newAddress = newEmployee.address;
    final addressResult = await db.insert('Adress', {
      'city': newAddress.city,
      'street': newAddress.street,
      'suite': newAddress.suite,
      'zipcode': newAddress.zipcode,
      'id': newEmployee.id,
    });
    return res;

    //return addressResult;
  }

  Future<int> deleteAllEmployees() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Employee');

    return res;
  }

  Future<int> updateData() async {
    final db = await database;
    final res = await db
        .rawUpdate("UPDATE Employee SET name = 'ABCDBCDBCD' WHERE id = 2");
    print(res);
    return res;
  }

  Future<List<Employee>> getAllEmployees() async {
    final db = await database;
    final res = await db.rawQuery
        //("SELECT * FROM EMPLOYEE");
        ("SELECT Employee.id,Employee.email,Employee.username,Employee.name,Adress.street,Adress.suite,Adress.city,Adress.zipcode FROM Employee INNER JOIN Adress ON Employee.id=Adress.id");

    List<Employee> list = res.isNotEmpty
        ? res.map((c) {
            print('res.map $c');

            final employee = Employee.fromJson(c);
            employee.address = Address.fromJson(c);

            return employee;
          }).toList()
        : [];

    print(list);

    return list;
  }
}
