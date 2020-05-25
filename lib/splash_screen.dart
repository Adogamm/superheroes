import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:superheroes/main.dart';

class Splash_Screen extends StatefulWidget {
  @override
  _Splash_ScreenState createState() => new _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SplashScreen(
        title: Text(
          "Buscando heroes cerca de ti",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        ),
        photoSize: 120,
        seconds: 5,
        backgroundColor: Colors.redAccent[400],
        image: Image.network(
            'https://i.dlpng.com/static/png/6567374_preview.png'),
        navigateAfterSeconds: HomePage());
  }
}
