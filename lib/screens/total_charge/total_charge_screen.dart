import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterapp/models/fee.dart';
import 'package:flutterapp/screens/total_charge/total_charge_screen_presenter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TotalCharge extends StatefulWidget {
  @override
  _TotalChargeState createState() => _TotalChargeState();
}

class _TotalChargeState extends State<TotalCharge>
    implements FeesScreenContract {
  List<Fee> _fees;
  bool _success;
  double _sum;
  FeesScreenPresenter _presenter;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences _sharedPreferences;

  _fetchSessionAndNavigate() async {
    _sharedPreferences = await _prefs;
    String authToken = _sharedPreferences.getString('auth_token');
    _presenter = new FeesScreenPresenter(this, authToken);
    _presenter.requestFees('2018-09-01');
  }

  @override
  void initState() {
    super.initState();
    _success = false;
    _fetchSessionAndNavigate();
  }

  /*_sum(){
    return _fees.reduce((a, b) => (int.parse(a.amount_received) + int.parse(b.amount_received)));
  }*/

  @override
  void onFeesSuccess(List<Fee> fee) {
    setState(() {
      _success = true;
      _fees = fee;
      //_sum = _sum();
    });
  }

  @override
  void onFeesError(String errorTxt) {
    print(errorTxt);
  }

  List<ChargeItem> _buildList() {
    return _fees.map((fee) => new ChargeItem(fee, this._presenter)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
        child: _success
            ? new ListView(
                children: _buildList(),
              )
            : new Center(
                child: new CircularProgressIndicator(),
              ));
  }
}

class ChargeItem extends StatelessWidget {
  final Fee _fee;
  final FeesScreenPresenter _presenter;
  const ChargeItem(this._fee, this._presenter);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
        title: new Text(this._fee.owner),
        trailing: new Text("S/. ${double.parse(this._fee.amount_received)}"));
  }
}
