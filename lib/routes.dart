import 'package:flutter/material.dart';
import 'package:flutterapp/screens/client_list/client_list_screen.dart';
import 'package:flutterapp/screens/client_detail/client_detail_screen.dart';
import 'package:flutterapp/screens/client_credit/client_credits_screen.dart';
import 'package:flutterapp/screens/client_credit_detail/client_credit_detail_screen.dart';
import 'package:flutterapp/screens/total_charge/total_charge_screen.dart';
import 'package:flutterapp/screens/login/login_screen.dart';
import 'package:flutterapp/screens/profile/profile_screen.dart';
import 'package:flutterapp/screens/splash/splash_screen.dart';
import 'package:flutterapp/screens/other_lists/other_lists_screen.dart';
import 'package:flutterapp/screens/client_quotes/client_quotes_screen.dart';

final routes = {
  '/login':         (BuildContext context) => new LoginScreen(),
  '/profile':         (BuildContext context) => new ProfileScreen(),
  '/home':         (BuildContext context) => new SearchList(),
  '/detail':       (BuildContext context) => new ClientDetail(),
  '/credits':       (BuildContext context) => new ClientCredits(),
  '/creditDetail':       (BuildContext context) => new ClientCreditDetail(),
  '/accountReport':       (BuildContext context) => new AccountReport(),
  '/other_list':     (BuildContext context) => new OtherLists(),
  '/quotes':     (BuildContext context) => new ClientQuotes(),
  '/' :          (BuildContext context) => new SplashScreen(),
};