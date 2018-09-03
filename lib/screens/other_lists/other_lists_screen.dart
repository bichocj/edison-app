import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterapp/auth.dart';
import 'package:flutterapp/screens/login/login_screen_presenter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtherLists extends StatefulWidget {
  @override
  _OtherListsState createState() => _OtherListsState();
}

class _OtherListsState extends State<OtherLists>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text('Otras Listas'),
              pinned: true,
              floating: true,
              forceElevated: boxIsScrolled,
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    text: "Total Cobrado",
                    icon: Icon(Icons.monetization_on),
                  ),
                  Tab(
                    text: "Cuotas Vencidas",
                    icon: Icon(Icons.not_interested),
                  )
                ],
                controller: _tabController,
              ),
            )
          ];
        },
        body: TabBarView(
          children: <Widget>[
            TotalCharge(),
            OverdueFeeds(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}

class TotalCharge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text("ajam"),
          new Text("ajam"),
          new Text("ajam"),
          new Text("ajam"),
          new Text("ajam"),
          new Text("ajam"),
        ],
      ),
    );
  }
}

class OverdueFeeds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text("ajam"),
          new Text("ajam"),
          new Text("ajam"),
          new Text("ajam"),
          new Text("ajam"),
          new Text("ajam"),
        ],
      ),
    );
  }
}
