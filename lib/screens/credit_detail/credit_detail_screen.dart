import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterapp/models/client_credit.dart';
import 'package:flutterapp/models/client_detail.dart';
import 'package:flutterapp/screens/quote_list/client_quotes_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutterapp/screens/custom_widgets/subtitle.dart';

class ClientCreditDetail extends StatefulWidget {
  static String tag = 'credit';
  final Credit credit;
  final ClientDetailModel client;
  ClientCreditDetail({Key key, this.credit, this.client}) : super(key: key);
  @override
  _ClientCreditDetailState createState() => _ClientCreditDetailState();
}

class _ClientCreditDetailState extends State<ClientCreditDetail> {
  Credit _credit;
  String _creditName;
  String _rangeTime;
  String _getCreditName(frequency) {
    switch (frequency) {
      case "D":
        {
          setState(() {
            _creditName = 'Crédito Diario';
            _rangeTime = 'días';
          });
        }
        break;
      case "Paralelo":
        {
          setState(() {
            _creditName = 'Crédito Paralelo';
            _rangeTime = 'días';
          });
        }
        break;
      case "S":
        {
          setState(() {
            _creditName = 'Crédito Semanal';
            _rangeTime = 'semanas';
          });
        }
        break;
      case "Q":
        {
          setState(() {
            _creditName = 'Crédito Quincenal';
            _rangeTime = 'quincenas';
          });
        }
        break;
      case "M":
        {
          setState(() {
            _creditName = 'Crédito Mensual';
            _rangeTime = 'meses';
          });
        }
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _credit = widget.credit;
    _getCreditName(widget.credit.frequency);
    print(widget.client.id);
    print(widget.credit);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final double _heightCard = 124.0;
    return new Scaffold(
      appBar: new AppBar(),
      body: new Container(
        padding: new EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: new CustomScrollView(
          slivers: <Widget>[
            new SliverList(
                delegate: new SliverChildListDelegate(<Widget>[
              new ProfileCard(
                image: 'assets/img/profile.png',
                height: _heightCard,
                background: themeData.cardColor,
                icon: Icons.chrome_reader_mode,
                name: widget.client.name,
                lastname: widget.client.lastname + ',',
                dni: widget.client.dni,
              ),
              new Subtitle(
                text: this._creditName,
                background: themeData.primaryColor,
                color: themeData.cardColor,
              ),
              new InfoItem(
                icon: Icons.monetization_on,
                title: 'Monto del crédito',
                text: 'S/.${this._credit.amount_total}',
                primaryColor: themeData.primaryColorDark,
              ),
              new InfoItem(
                icon: Icons.date_range,
                title: 'Fecha del crédito',
                text: this._credit.start_at,
                primaryColor: themeData.primaryColorDark,
              ),
              new InfoItem(
                icon: Icons.timer,
                title: 'Tiempo del crédito',
                text: '${this._credit.time} ${this._rangeTime}',
                primaryColor: themeData.primaryColorDark,
              ),
              new InfoItem(
                icon: Icons.call_missed_outgoing,
                title: 'Taza efectiva',
                text: '${this._credit.rate}%',
                primaryColor: themeData.primaryColorDark,
              ),
              new InfoItem(
                icon: Icons.toc,
                title: 'Monto pagado',
                text: this._credit.amount_payed != null
                    ? 'S/. ${this._credit.amount_payed.toStringAsFixed(2)}'
                    : 'S/. 0.00',
                primaryColor: themeData.primaryColorDark,
              ),
              new InfoItem(
                icon: Icons.confirmation_number,
                title: 'Nro. de cuotas pagadas',
                text: '${this._credit.quotes_quantity} cuotas',
                primaryColor: themeData.primaryColorDark,
              ),
              new InfoItem(
                icon: Icons.date_range,
                title: 'Días de atraso',
                text: '${this._credit.days_late} día(s)',
                primaryColor: themeData.primaryColorDark,
              ),
              new InfoItem(
                icon: Icons.details,
                title: 'Mora',
                text: 'S/. ${this._credit.current_arrear.toStringAsFixed(2)}',
                primaryColor: themeData.primaryColorDark,
              ),
              new Container(
                margin:
                    new EdgeInsets.symmetric(horizontal: 72.0, vertical: 16.0),
                child: new RaisedButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  textColor: themeData.cardColor,
                  color: themeData.primaryColor,
                  splashColor: themeData.canvasColor,
                  elevation: 4.0,
                  padding: new EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new Text('Ver Cuotas'),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new QuotesList(
                                  credit: this._credit,
                                  client: this.widget.client,
                                )));
                  },
                ),
              )
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

class InfoItem extends StatelessWidget {
  const InfoItem({
    Key key,
    this.icon,
    this.primaryColor,
    this.title,
    this.text,
  }) : super(key: key);
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
                      style:
                          new TextStyle(color: Colors.black87, fontSize: 15.0),
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
