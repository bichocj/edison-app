import 'package:flutter/material.dart';
import 'package:flutterapp/screens/charge/charge_loading_screen.dart';
import 'package:flutterapp/models/quote.dart';
import 'package:flutterapp/models/client_detail.dart';

class Charge extends StatefulWidget {
  final Quote quote;
  final ClientDetailModel client;
  final String total;
  Charge({Key key, this.quote, this.client, this.total}) : super(key: key);
  @override
  _ChargeState createState() => _ChargeState();
}

class _ChargeState extends State<Charge> {
  String _charge;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      final _sendCharge = double.parse(_charge) - widget.quote.current_arrear;
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          settings: const RouteSettings(name: '/chargeLoading'),
          builder: (context) => new ChargeLoading(
            quote: widget.quote,
            client: widget.client,
            charge: _sendCharge,
            arrear: widget.quote.current_arrear,
            totalCharge: _charge
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Pago de Cuota"),
        centerTitle: true,
      ),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Form(
                key: formKey,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            margin: new EdgeInsets.symmetric(vertical: 32.0),
                            padding: new EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 16.0),
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
                            child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  new Text(
                                    'Monto Total',
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: themeData.primaryColorDark),
                                  ),
                                  new Text(
                                    'S/.${widget.total}',
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24.0),
                                  ),
                                  new Container(
                                    width: 280.0,
                                    padding: const EdgeInsets.all(8.0),
                                    child: new TextFormField(
                                      style: new TextStyle(
                                          fontSize: 32.0,
                                          color: themeData.hintColor),
                                      onSaved: (val) => _charge = val,
                                      keyboardType: TextInputType.number,
                                      validator: (val) {
                                        if (val.length < 1) {
                                          return "Por favor, ingrese monto.";
                                        } else {
                                          if (double.parse(val) >
                                              double.parse(widget.total)) {
                                            return "Este monto excede del total.";
                                          } else if (double.parse(val) <
                                              widget.quote.current_arrear) {
                                            return "Debe pagar por lo menos el monto total de la mora ${widget.quote.current_arrear}";
                                          }
                                        }
                                      },
                                      decoration: new InputDecoration(
                                        labelText: "Monto Recibido",
                                        labelStyle:
                                            new TextStyle(fontSize: 12.0),
                                        counterStyle:
                                            new TextStyle(fontSize: 20.0),
                                        icon: new Icon(Icons.attach_money),
                                      ),
                                    ),
                                  ),
                                  new Container(
                                    width: 100.0,
                                    child: new RaisedButton(
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0)),
                                      textColor: themeData.cardColor,
                                      color: themeData.primaryColor,
                                      splashColor: themeData.canvasColor,
                                      elevation: 4.0,
                                      padding: new EdgeInsets.symmetric(
                                          vertical: 16.0, horizontal: 16.0),
                                      child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          new Text('Cobrar'),
                                        ],
                                      ),
                                      onPressed: () {
                                        _submit();
                                      },
                                    ),
                                  )
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 48.0),
              child: new Text(
                "(*) Recuerda que el pago mínimo de la cuota; corresponde a la mora acumulada hasta este momento.",
                style: new TextStyle(color: themeData.hintColor),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}