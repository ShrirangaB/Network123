import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://i.pinimg.com/originals/f7/f6/8f/f7f68f4ef9e52fea71f91547c99e2431.jpg"),
                    fit: BoxFit.cover)),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 3,
            child: Image.network(
              'https://www.eatlogos.com/art_logos/png/vector_art_logo_colourful_lotus.png',
              height: 250,
              width: 250,
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height / 1.4,
              left: MediaQuery.of(context).size.width / 3,
              child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
