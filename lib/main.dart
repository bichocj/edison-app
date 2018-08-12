import 'package:flutter/material.dart';

import 'Login/login.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Edison App',
      theme: new ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: new LoginPage()
    );
  }
}