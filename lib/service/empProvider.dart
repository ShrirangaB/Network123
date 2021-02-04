import 'package:dio/dio.dart';
import 'package:networkJsonAPp/model/empmodel.dart';
import 'package:networkJsonAPp/service/empdbprovider.dart';

class EmployeeApiProvider {
  Future<List<Employee>> getAllEmployees() async {
    var url = "https://jsonplaceholder.typicode.com/users";
    Response response = await Dio().get(url);

    return (response.data as List).map((employee) {
      print('Inserting $employee');
      DBProviderForJSON.db.createEmployee(Employee.fromJson(employee));
    }).toList();
  }
}
