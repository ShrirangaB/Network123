import 'package:flutter/material.dart';
import 'package:networkJsonAPp/screen/dbscreen.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 7),
      () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Employeee(),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Image.network(
        "https://i.pinimg.com/originals/07/24/88/0724884440e8ddd0896ff557b75a222a.gif",
      )),
    );
  }
}
