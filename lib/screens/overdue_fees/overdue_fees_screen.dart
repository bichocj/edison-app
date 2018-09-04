import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutterapp/models/quote.dart';
import 'package:flutterapp/screens/overdue_fees/overdue_fees_screen_presenter.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OverdueFeeds extends StatefulWidget {
  @override
  _OverdueFeedsState createState() => _OverdueFeedsState();
}

class _OverdueFeedsState extends State<OverdueFeeds>
    implements OverdueFeesContract {
  List<Quote> _quotes;
  bool _success;

  OverdueFeesScreenPresenter _presenter;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences _sharedPreferences;

  _fetchSessionAndNavigate() async {
    _sharedPreferences = await _prefs;
    String authToken = _sharedPreferences.getString('auth_token');
    _presenter = new OverdueFeesScreenPresenter(this, authToken);
    _presenter.requestOverdueFees();
  }

  @override
  void onOverdueFeesSuccess(List<Quote> quote) {
    setState(() {
      _success = true;
      _quotes = quote;
    });
  }

  @override
  void onOverdueFeesError(String errorTxt) {
    print(errorTxt);
  }

  @override
  void initState() {
    super.initState();
    _success = false;
    _fetchSessionAndNavigate();
  }

  List<OverdueFee>_buildList() {
    var _filterList = _quotes.where((quote) => quote.is_beaten == true);
    return _filterList.map((quote) => new OverdueFee(quote, this._presenter)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      _success ?
      new ListView(
        children: _buildList(),
      ): new Center(
        child: new CircularProgressIndicator(),
      )
    );
  }
}

class OverdueFee extends StatelessWidget {
  final Quote _quote;
  final OverdueFeesScreenPresenter _presenter;
  const OverdueFee(this._quote, this._presenter);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
        title: new Text(this._quote.client_name),
        trailing: new Text("${this._quote.charge_at}"));
  }
}
