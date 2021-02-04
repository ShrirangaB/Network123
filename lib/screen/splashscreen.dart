import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Image.network(
                'https://cdn3.iconfinder.com/data/icons/flat-office-icons-1/140/Artboard_1-11-512.png'),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
