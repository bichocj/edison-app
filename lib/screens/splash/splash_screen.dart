import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed("/login");
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.primaryColorDark,
      body: new Center(
        child: new CircleAvatar(
          radius: 40.0,
          backgroundColor: Colors.white,
          child: new Icon(Icons.monetization_on,
              color: themeData.primaryColorDark, size: 80.0),
        ),
      ),
    );
  }
}
