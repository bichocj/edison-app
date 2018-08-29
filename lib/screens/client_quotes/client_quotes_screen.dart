import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterapp/screens/client_detail/client_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutterapp/screens/client_list/client_list_screen_presenter.dart';
import 'package:flutterapp/models/client.dart';

class ClientQuotes extends StatefulWidget {
  @override
  _ClientQuotesState createState() => _ClientQuotesState();
}

class _ClientQuotesState extends State<ClientQuotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Coutas'),
        centerTitle: true,
      ),

    );
  }
}
