import 'package:flutter/material.dart';
import 'package:flutterapp/screens/custom_widgets/charge_info.dart';

class ChargeSuccess extends StatelessWidget {
  final String onCharge;
  ChargeSuccess({Key key, this.onCharge}):super(key:key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.green,
      floatingActionButton: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new FlatButton(onPressed: null, child: new Icon(Icons.home, color: themeData.cardColor,)),
          new FlatButton(onPressed: null, child: new Text("Creditos", style: new TextStyle(color: themeData.cardColor),)),
          new FlatButton(onPressed: null, child: new Text("Cuotas", style: new TextStyle(color: themeData.cardColor))),
        ],
      ),
        body: new Container(
          margin: new EdgeInsets.all(20.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Icon(Icons.check_circle,
                size: 100.0,
                color: Colors.white,
              ),
              new Container(
                  margin: new EdgeInsets.symmetric(vertical: 16.0),
                  child: new Text("Cobro exitoso",
                    style: new TextStyle(
                        color: themeData.cardColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 40.0
                    ),)
              ),
              new ChargeInfo(
                  icon: Icons.person,
                  text: "Nombre sy apellidos"
              ),
              new ChargeInfo(
                icon: Icons.chrome_reader_mode,
                text: "1991919191",
              ),
              new ChargeInfo(
                icon: Icons.content_paste,
                text: "Credito diario" ,
              ),
              new ChargeInfo(
                icon: Icons.monetization_on,
                text: "Monto Abonado" ,
              ),
            ],
          ),
        )
    );
  }
}
