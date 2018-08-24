import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'client_detail.dart';
import 'package:flutterapp/screens/client_list/client_list_screen_presenter.dart';
import 'package:flutterapp/models/client.dart';

class ClientCreditDetail extends StatefulWidget {
  static String tag = 'client_credit_detail';
  @override
  _ClientCreditDetailState createState() => _ClientCreditDetailState();
}

class _ClientCreditDetailState extends State<ClientCreditDetail> {
  var client_basicInfo = {
    "name": "Jorge",
    "lastname": "Chavez Manrique",
    "dni": "75446329",
  };

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final double _heightCard = 124.0;
    return new Scaffold(
      appBar: new AppBar(),
      body: new Container(
        margin: new EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: new CustomScrollView(
          slivers: <Widget>[
            new SliverList(
                delegate: new SliverChildListDelegate(<Widget>[
              new ProfileCard(
                image: 'assets/profile.png',
                height: _heightCard,
                background: themeData.cardColor,
                icon: Icons.chrome_reader_mode,
                name: client_basicInfo["name"],
                lastname: client_basicInfo["lastname"] + ',',
                dni: client_basicInfo["dni"],
              ),
              new Subtitle(
                text: "Crédito Diario",
                background: themeData.primaryColor,
                color: themeData.cardColor,
              ),
              new _InfoItem(
                icon: Icons.monetization_on,
                title: 'Monto del crédito',
                text: '1600.00',
                primaryColor: themeData.primaryColorDark,
              ),
              new _InfoItem(
                icon: Icons.date_range,
                title: 'Fecha del crédito',
                text: '04/08/18',
                primaryColor: themeData.primaryColorDark,
              ),
              new _InfoItem(
                icon: Icons.timer,
                title: 'Tiempo del crédito',
                text: '30 días',
                primaryColor: themeData.primaryColorDark,
              ),
              new _InfoItem(
                icon: Icons.call_missed_outgoing,
                title: 'Taza efectiva mensual',
                text: '0.06',
                primaryColor: themeData.primaryColorDark,
              ),
              new _InfoItem(
                icon: Icons.today,
                title: 'Fecha de Vencimiento',
                text: '4/08/2018',
                primaryColor: themeData.primaryColorDark,
              ),
              new _InfoItem(
                icon: Icons.account_balance_wallet,
                title: 'Cuota',
                text: '40.00',
                primaryColor: themeData.primaryColorDark,
              ),
              new _InfoItem(
                icon: Icons.toc,
                title: 'Monto pagado',
                text: "210.0",
                primaryColor: themeData.primaryColorDark,
              ),
              new _InfoItem(
                icon: Icons.confirmation_number,
                title: 'Nro. de cuotas pagadas',
                text: '5 cuotas',
                primaryColor: themeData.primaryColorDark,
              ),
              new _InfoItem(
                icon: Icons.adjust,
                title: 'Día de cobro',
                text: '09/09/2018',
                primaryColor: themeData.primaryColorDark,
              ),
              new _InfoItem(
                icon: Icons.call_missed,
                title: 'Días de atraso',
                text: '0 días',
                primaryColor: themeData.primaryColorDark,
              ),
              new _InfoItem(
                icon: Icons.details,
                title: 'Mora',
                text: '0 soles',
                primaryColor: themeData.primaryColorDark,
              ),
              new Container(
                  margin: new EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 72.0),
                  child: new TextFormField(
                    decoration: new InputDecoration(
                        labelText: "Monto Cobrado",
                        icon: new Icon(Icons.monetization_on, color: themeData.primaryColor,),
                      labelStyle: new TextStyle(
                        color: themeData.primaryColor
                      )
                    ),
                  )),

              new Container(
                margin:
                    new EdgeInsets.symmetric(vertical: 32.0, horizontal: 72.0),
                child: new RaisedButton(
                  padding:
                      new EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                  child: new Text(
                    'Reporte de Cuenta',
                    style: new TextStyle(color: themeData.cardColor),
                  ),
                  color: themeData.accentColor,
                  elevation: 4.0,
                  splashColor: themeData.buttonColor,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/totalCharge');
                  },
                ),
              ),
            ])),
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard(
      {Key key,
      this.image,
      this.height,
      this.background,
      this.icon,
      this.iconColor,
      this.name,
      this.lastname,
      this.dni})
      : super(key: key);
  final String image;
  final double height;
  final Color background;
  final IconData icon;
  final Color iconColor;
  final String name;
  final String lastname;
  final String dni;
  @override
  Widget build(BuildContext context) {
    return new Container(
        height: 120.0,
        child: new Stack(
          children: <Widget>[
            new Container(
              height: height,
              margin: new EdgeInsets.only(left: 46.0),
              decoration: new BoxDecoration(
                color: background,
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.circular(8.0),
                boxShadow: <BoxShadow>[
                  new BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: new Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(lastname,
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0)),
                  new Text(
                    name,
                    style: new TextStyle(fontSize: 18.0),
                  ),
                  new Container(
                    margin: new EdgeInsets.fromLTRB(70.0, 20.0, 70.0, 10.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Icon(
                          icon,
                          color: iconColor,
                        ),
                        new Text(
                          dni,
                          style: new TextStyle(fontSize: 16.0),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(vertical: 16.0),
              alignment: FractionalOffset.centerLeft,
              child: new Image(
                image: new AssetImage(image),
                height: 92.0,
                width: 92.0,
              ),
            )
          ],
        ));
  }
}

class Subtitle extends StatelessWidget {
  const Subtitle({
    Key key,
    this.text,
    this.background,
    this.color,
  }) : super(key: key);
  final String text;
  final Color background;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.only(top: 20.0, bottom: 0.0),
      padding: new EdgeInsets.symmetric(vertical: 10.0),
      decoration: new BoxDecoration(
        color: background,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            text,
            style: new TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem(
      {Key key,
      this.icon,
      this.primaryColor,
      this.title,
      this.text,
      })
      : super(key: key);
  final IconData icon;
  final String title;
  final Color primaryColor;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Row(
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  width: 72.0,
                  child: new Icon(icon, color: primaryColor),
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(title,
                        style: new TextStyle(
                            color: primaryColor,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold)),
                    new Text(
                      text,
                      style: new TextStyle(color: Colors.black87, fontSize: 15.0),
                    ),
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

