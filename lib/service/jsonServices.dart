import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:networkJsonAPp/model/jsonModel.dart';

final String apiURL = 'https://jsonplaceholder.typicode.com/users';

Future<List<GetUsers>> fetchJSONData() async {
  var jsonResponse = await http.get(apiURL);

  if (jsonResponse.statusCode == 200) {
    final jsonItems =
        json.decode(jsonResponse.body).cast<Map<String, dynamic>>();

    List<GetUsers> usersList = jsonItems.map<GetUsers>((json) {
      return GetUsers.fromJson(json);
    }).toList();

    return usersList;
  } else {
    throw Exception('Failed to load data from internet');
  }
}
