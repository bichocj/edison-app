import 'dart:ui';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterapp/auth.dart';
import 'package:flutterapp/screens/login/login_screen_presenter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountReport extends StatefulWidget {
  @override
  _TotalChargeState createState() => _TotalChargeState();
}

class _TotalChargeState extends State<AccountReport> {
  var client_detail = {
    "name": "Jorge",
    "lastname": "Chavez Manrique",
    "dni": "75446329",
    "address": "Av. Peru 502",
    "cellphone": "945612530", //CELLPHONE NUMBER
    "phone": "054589645",
    "address_of_payment": "Feria el Altiplano E-25",
    "reference": "Puesto de verdurS",
  };
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final double _heightImage = 240.0;
    return new Theme(
        data: new ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          platform: Theme.of(context).platform,
        ),
        child: new Scaffold(
          body: new CustomScrollView(
            slivers: <Widget>[
              new SliverAppBar(
                pinned: true,
                expandedHeight: _heightImage,
                flexibleSpace: new FlexibleSpaceBar(
                  title: new Text(
                    'Reporte de Cuenta',
                    style: new TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  background: new Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      new Image.asset(
                        'assets/img/bg.jpeg',
                        fit: BoxFit.cover,
                        height: _heightImage,
                      ),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.0, -1.0),
                            end: Alignment(0.0, -0.4),
                            colors: <Color>[
                              Color(0x60000000),
                              Color(0x00000000)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              new SliverList(
                  delegate: new SliverChildListDelegate(<Widget>[
                new _InfoItem(
                  icon: Icons.date_range,
                  title: 'Del 9 Junio 2018',
                  primaryColor: themeData.primaryColorDark,
                  textColor: themeData.hintColor,
                ),
                new _InfoTableHeader(
                  textLeft: "Apellidos y Nombres",
                  textRight: "Fecha de Vencimiento",
                  borderColor: themeData.dividerColor,
                  color: themeData.primaryColorDark,
                ),
                new _InfoTable(
                  textLeft: "Gonzales Cáceres, Luisa",
                  textRight: "07/08/18",
                  borderColor: themeData.dividerColor,
                ),
                new _InfoTable(
                  textLeft: "Fernandez Khaasasd, Kateryn",
                  textRight: "09/08/2018",
                  borderColor: themeData.dividerColor,
                ),
              ]))
            ],
          ),
        ));
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem(
      {Key key,
      this.icon,
      this.primaryColor,
      this.title,
      this.textColor})
      : super(key: key);
  final IconData icon;
  final String title;
  final Color primaryColor;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  width: 50.0,
                  child: new Icon(icon, color: primaryColor),
                ),
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(title,
                        style: new TextStyle(
                            color: primaryColor,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _InfoTable extends StatelessWidget {
  const _InfoTable({
    Key key,
    this.borderColor,
    this.textLeft,
    this.textRight,
  }) : super(key: key);
  final Color borderColor;
  final String textLeft;
  final String textRight;
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.symmetric(vertical: 8.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: borderColor, width: 1.0)),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Container(
            width: 130.0,
            child: new Text(textLeft),
          ),
          new Container(
            width: 100.0,
            child: new Text(textRight),
          )
        ],
      ),
    );
  }
}

class _InfoTableHeader extends StatelessWidget {
  const _InfoTableHeader({
    Key key,
    this.borderColor,
    this.color,
    this.textLeft,
    this.textRight,
  }) : super(key: key);
  final Color borderColor;
  final Color color;
  final String textLeft;
  final String textRight;
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.symmetric(vertical: 8.0),
      margin: new EdgeInsets.only(top: 16.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: borderColor, width: 1.0)),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Container(
            child: new Text(textLeft,
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: color, fontSize: 16.0)),
          ),
          new Container(
            child: new Text(textRight,
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: color, fontSize: 16.0)),
          )
        ],
      ),
    );
  }
}
