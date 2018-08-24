import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutterapp/screens/client_detail/client_detail_screen_presenter.dart';
import 'package:flutterapp/models/client_detail.dart';

class ClientDetail extends StatefulWidget {
  static String tag = 'client_detail';
  ClientDetail({Key key}) : super(key: key);
  @override
  _ClientDetailState createState() => _ClientDetailState();
}

class _ClientDetailState extends State<ClientDetail> {
  //To Do, make works implement
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
                    client_detail["lastname"],
                    style: new TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  background: new Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      new Image.asset(
                        'assets/bg.jpeg',
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
                  icon: Icons.person,
                  title: 'Nombre Completo',
                  text:
                      client_detail["lastname"] + ', ' + client_detail["name"],
                  primaryColor: themeData.primaryColorDark,
                  textColor: themeData.hintColor,
                ),
                new Divider(),
                new _InfoItem(
                  icon: Icons.contacts,
                  title: 'DNI',
                  text: client_detail["dni"],
                  primaryColor: themeData.primaryColorDark,
                  textColor: themeData.hintColor,
                ),
                new Divider(),
                new _InfoItem(
                  icon: Icons.home,
                  title: 'Domicilio',
                  text: client_detail["address"],
                  primaryColor: themeData.primaryColorDark,
                  textColor: themeData.hintColor,
                ),
                new Divider(),
                new _InfoItem(
                  icon: Icons.phone_android,
                  title: 'Celular',
                  text: client_detail["cellphone"],
                  primaryColor: themeData.primaryColorDark,
                  textColor: themeData.hintColor,
                ),
                new Divider(),
                new _InfoItem(
                  icon: Icons.phone,
                  title: 'Teléfono Fijo',
                  text: client_detail["phone"],
                  primaryColor: themeData.primaryColorDark,
                  textColor: themeData.hintColor,
                ),
                new Divider(),
                new _InfoItem(
                  icon: Icons.business,
                  title: 'Dirección del Negocio',
                  text: client_detail["address_of_payment"],
                  primaryColor: themeData.primaryColorDark,
                  textColor: themeData.hintColor,
                ),
                new Divider(),
                new _InfoItem(
                  icon: Icons.location_on,
                  title: 'Referencia',
                  text: client_detail["reference"],
                  primaryColor: themeData.primaryColorDark,
                  textColor: themeData.hintColor,
                ),
                new Container(
                  margin: new EdgeInsets.symmetric(
                      vertical: 32.0, horizontal: 72.0),
                  child: new RaisedButton(
                    padding: new EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8.0),
                    child: new Text(
                      'Estado de cuentas',
                      style: new TextStyle(color: themeData.cardColor),
                    ),
                    color: themeData.accentColor,
                    elevation: 4.0,
                    splashColor: themeData.buttonColor,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/credits');
                    },
                  ),
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
      this.text,
      this.textColor})
      : super(key: key);
  final IconData icon;
  final String title;
  final Color primaryColor;
  final String text;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Row(
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  width: 72.0,
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
                    new Text(
                      text,
                      style: new TextStyle(color: textColor, fontSize: 15.0),
                    )
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
