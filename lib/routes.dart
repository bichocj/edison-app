import 'package:flutter/material.dart';
import 'package:flutterapp/screens/home/home_screen.dart';
import 'package:flutterapp/screens/login/login_screen.dart';

final routes = {
  '/login':         (BuildContext context) => new LoginScreen(),
  '/home':         (BuildContext context) => new SearchList(),
  '/' :          (BuildContext context) => new LoginScreen(),
};