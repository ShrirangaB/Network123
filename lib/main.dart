import 'package:flutter/material.dart';
import 'package:networkJsonAPp/screen/dbscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(child: Employ()),
    ));
  }
}
