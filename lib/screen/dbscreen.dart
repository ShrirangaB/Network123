import 'package:flutter/material.dart';
import 'package:networkJsonAPp/model/empmodel.dart';

import 'package:networkJsonAPp/service/empProvider.dart';
import 'package:networkJsonAPp/service/empdbprovider.dart';

class Employeee extends StatefulWidget {
  const Employeee({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Employeee> {
  final nameController = TextEditingController();
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api to sqlite'),
        centerTitle: true,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(Icons.cloud_download_outlined),
              onPressed: () async {
                await _loadFromApi();
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(Icons.update),
              onPressed: () async {
                await _updateData();
              },
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _buildEmployeeListView(),
    );
  }

  _updateData() async {
    setState(() {
      isLoading = true;
    });

    await DBProviderForJSON.db.updateData();
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });
  }

  _loadFromApi() async {
    setState(() {
      isLoading = true;
    });

    var apiProvider = EmployeeApiProvider();
    await apiProvider.getAllEmployees();

    // wait for 2 seconds to simulate loading of data
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  _buildEmployeeListView() {
    return FutureBuilder(
      future: DBProviderForJSON.db.getAllEmployees(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.data != null) {
            List<Employee> list = snapshot.data;
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.black12,
              ),
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Text(
                    "${list[index].id}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  title: Text(
                      "Name: ${list[index].name}\nUserName: ${list[index].username}\nEmail: ${list[index].email}\nStreet: ${list[index].address.street}\nSuite :${list[index].address.suite}\nCity :${list[index].address.city}\nZip: ${list[index].address.zipcode}"),
                  // subtitle: Text(
                  //     'Street: ${list[index].address.street}\nSuite :${list[index].address.suite}\nCity :${list[index].address.city}\nZip: ${list[index].address.zipcode}'),
                );
              },
            );
          }
        }
      },
    );
  }
}
// return ListView.separated(
//   separatorBuilder: (context, index) => Divider(
//     color: Colors.black12,
//   ),
//   itemCount: snapshot.data.length,
//   itemBuilder: (BuildContext context, int index) {
//     return ListTile(
//       leading: Text(
//         "${index + 1}",
//         style: TextStyle(fontSize: 20.0),
//       ),
//       title: Text(
//           "Name: ${snapshot.data[index].name}\nUsername: ${snapshot.data[index].username} "),
//       subtitle: Text(
//           'EMAIL: ${snapshot.data[index].email}\nCity: ${snapshot.data[index].city}'),
//       // \nStreet: ${snapshot.data[index].street}\nCity: ${snapshot.data[index].city}'),
//     );
//   },
// );
