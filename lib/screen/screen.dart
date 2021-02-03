import 'package:flutter/material.dart';
import 'package:networkJsonAPp/service/jsonServices.dart';
import 'package:networkJsonAPp/model/jsonModel.dart';

class JSONListView extends StatefulWidget {
  CustomJSONListView createState() => CustomJSONListView();
}

class CustomJSONListView extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JSON'),
      ),
      body: FutureBuilder<List<GetUsers>>(
        future: fetchJSONData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          return ListView(
            children: snapshot.data
                .map(
                  (user) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        title: Text(user.name),
                        onTap: () {
                          print(user.name);
                        },
                        trailing: Text(user.email),
                        subtitle: Text(user.address.street +
                            '\n' +
                            user.address.city +
                            '\n' +
                            user.address.zipcode),
                        leading: Text(user.id.toString()),
                      ),
                    ],
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
