import 'package:flutter/material.dart';
import 'package:flutterapp/auth.dart';
import 'package:flutterapp/routes.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Edison App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
    );
  }


}