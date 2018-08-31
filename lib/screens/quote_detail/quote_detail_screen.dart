import 'package:flutter/material.dart';
import 'package:flutterapp/models/client_detail.dart';
import 'package:flutterapp/screens/custom_widgets/custom_card.dart';
import 'package:flutterapp/screens/custom_widgets/info_item.dart';
import 'package:flutterapp/models/quote.dart';
import 'package:flutterapp/screens/charge/charge_screen.dart';

class QuoteDetail extends StatefulWidget {
  final Quote quote;
  final ClientDetailModel client;

  QuoteDetail({Key key, this.quote, this.client}) : super(key: key);
  @override
  _QuoteDetailState createState() => _QuoteDetailState();
}

class _QuoteDetailState extends State<QuoteDetail> {
  Quote _quote;
  String _total;

  @override
  void initState() {
    super.initState();
    _quote = widget.quote;
    _total = _calcTotal();
  }

  String _calcTotal() {
    double total = _quote.amount_debt + _quote.current_arrear;
    return total.toStringAsFixed(2);
  }

  void _navigate() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) => new Charge(
          quote: this._quote, client: widget.client, total: _total,
        )));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text('Detalle de cuota'),
        ),
        body: new Container(
          child: new CustomScrollView(
            slivers: <Widget>[
              new SliverList(
                  delegate: new SliverChildListDelegate(<Widget>[
                /*new CustomCart(
                  image: 'assets/img/account.png',
                  height: 250.0,
                  background: Colors.white,
                  icon: Icons.account_balance_wallet,
                  name: widget.client.name,
                  lastname: widget.client.lastname,
                  dni: widget.client.dni,
                ),*/
                new Container(
                  margin: new EdgeInsets.all(16.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        height: 50.0,
                        width: 200.0,
                        padding: new EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: new BoxDecoration(
                          color: themeData.cardColor,
                          shape: BoxShape.rectangle,
                          borderRadius: new BorderRadius.circular(30.0),
                          boxShadow: <BoxShadow>[
                            new BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10.0,
                              offset: new Offset(0.0, 4.0),
                            ),
                          ],
                        ),
                        child: new Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Text('Total:', style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                color: themeData.primaryColorDark
                              ),),
                              new Text(
                                'S/.${this._total}',
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0),
                              )
                            ]),
                      ),
                      new Container(
                        child: new RaisedButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          textColor: themeData.cardColor,
                          color: double.parse(this._total) > 0 ? themeData.primaryColor : Color.fromRGBO(210, 210, 210, 1.0),
                          splashColor: themeData.canvasColor,
                          elevation: 4.0,
                          padding: new EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              new Text('Cobrar'),
                            ],
                          ),
                          onPressed: () {
                            if (double.parse(this._total) > 0) {
                              _navigate();
                            } else {
                             return null;
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
                new InfoItem(
                  icon: Icons.monetization_on,
                  primaryColor: Colors.indigo,
                  title: 'Deuda',
                  text: 'S/. ${this._quote.amount_debt.toStringAsFixed(2)}',
                  textColor: Colors.black87,
                ),
                new InfoItem(
                  icon: Icons.details,
                  primaryColor: Colors.indigo,
                  title: 'Mora',
                  text: "S/. ${this._quote.current_arrear.toStringAsFixed(2)}",
                  textColor: Colors.black87,
                ),
                new Divider(),
                new InfoItem(
                  icon: Icons.date_range,
                  primaryColor: Colors.indigo,
                  title: 'Fecha de Crédito',
                  text: this._quote.charge_at,
                  textColor: Colors.black87,
                ),
                new InfoItem(
                  icon: Icons.account_balance,
                  primaryColor: Colors.indigo,
                  title: 'Capital',
                  text: "S/. ${this._quote.capital}",
                  textColor: Colors.black87,
                ),
                new InfoItem(
                  icon: Icons.call_missed_outgoing,
                  primaryColor: Colors.indigo,
                  title: 'Interés',
                  text: 'S/. ${this._quote.interest}',
                  textColor: Colors.black87,
                ),
                new InfoItem(
                  icon: Icons.monetization_on,
                  primaryColor: Colors.indigo,
                  title: 'Total de Cuota',
                  text: "S/. ${this._quote.amount}",
                  textColor: Colors.black87,
                ),
                new Divider(),
                new InfoItem(
                  icon: Icons.today,
                  primaryColor: Colors.indigo,
                  title: 'Día(s) de atraso',
                  text: '${this._quote.days_late.toString()} día(s)',
                  textColor: Colors.black87,
                ),
                new Divider()
              ]))
            ],
          ),
        ));
  }
}
