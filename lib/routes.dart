import 'package:flutter/material.dart';
import 'package:flutterapp/screens/client_list/client_list_screen.dart';
import 'package:flutterapp/screens/client_detail/client_detail_screen.dart';
import 'package:flutterapp/screens/client_credit/client_credits_screen.dart';
import 'package:flutterapp/screens/client_credit_detail/client_credit_detail_screen.dart';
import 'package:flutterapp/screens/total_charge/total_charge_screen.dart';
import 'package:flutterapp/screens/login/login_screen.dart';

final routes = {
  '/login':         (BuildContext context) => new LoginScreen(),
  '/home':         (BuildContext context) => new SearchList(),
  '/detail':       (BuildContext context) => new ClientDetail(),
  '/credits':       (BuildContext context) => new ClientCredits(),
  '/creditDetail':       (BuildContext context) => new ClientCreditDetail(),
  '/totalCharge':       (BuildContext context) => new TotalCharge(),
  '/' :          (BuildContext context) => new LoginScreen(),
};