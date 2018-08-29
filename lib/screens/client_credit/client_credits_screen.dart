import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterapp/screens/client_credit_detail/client_credit_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutterapp/screens/client_credit/client_credits_screen_presenter.dart';
import 'package:flutterapp/models/client_credit.dart';
import 'package:flutterapp/models/client_detail.dart';

class ClientCredits extends StatefulWidget {
  static String tag = 'client_credits';
  final ClientDetailModel client;
  ClientCredits({Key key, this.client }) : super(key: key);
  @override
  _ClientCreditsState createState() => _ClientCreditsState();
}

class _ClientCreditsState extends State<ClientCredits>
implements ClientCreditsScreenContract{
  List<ClientCreditModel> _credits;
  bool _success;

  ClientCreditsScreenPresenter _presenter;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences _sharedPreferences;

  _fetchSessionAndNavigate() async {
    _sharedPreferences = await _prefs;
    String authToken = _sharedPreferences.getString('auth_token');
    _presenter = new ClientCreditsScreenPresenter(this, authToken);
    _presenter.requestClientCredit(widget.client.id);
  }

  @override
  void initState() {
    super.initState();
    _success = false;
    _fetchSessionAndNavigate();
  }

  @override
  void onClientCreditsSuccess(List<ClientCreditModel> client_credits) {
    _credits = client_credits;
    setState(() {
      _success = true;
    });
  }

  @override
  void onClientCreditsError(String errorTxt) {
    print("error detail");
    print(errorTxt);
  }

  List<ListItem> _buildList() {
    return _credits
        .map((credit) => new ListItem(widget.client, credit, this._presenter))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final double _heightCard = 124.0;
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Estado de Cuenta'),
          centerTitle: true,
        ),
        body: new Container(
            margin: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ),
            child: new Column(
          children: <Widget>[
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
              text: "Estado de cuenta",
              background: themeData.primaryColor,
              color: themeData.cardColor,
            ),
            new Container(
              margin: new EdgeInsets.only(top: 00.0, bottom: 20.0),
              padding: new EdgeInsets.symmetric(vertical: 10.0),
              decoration: new BoxDecoration(
                color: themeData.cardColor,
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.circular(8.0),
              ),
              child: new Column(
                children: _buildList()
              ),
            )
          ],
        )));
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
  const Subtitle(
      {Key key,
        this.text,
        this.background,
        this.color,
        })
      : super(key: key);
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
        borderRadius: new BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
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

class ListItem extends StatelessWidget {
  final ClientCreditModel _credit;
  final ClientDetailModel _client;
  final ClientCreditsScreenPresenter _presenter;
  const ListItem (this._client, this._credit, this._presenter);

  @override
  Widget build(BuildContext context) {
    String _creditName;
    switch (this._credit.frequency) {
      case  "D": {
        _creditName = "Diario";
      }
      break;
      case "P": {
        _creditName = "Paralelo";
      }
      break;
      case "S": {
        _creditName = "Semanal";
      }
      break;
      case "Q": {
        _creditName = "Quincenal";
      }
      break;
      case "M": {
        _creditName = "Mensual";
      }
      break;
    }
    return new ListTile(
        title: new Text('Crédito ${_creditName}'),
        trailing: const Icon(Icons.arrow_right),
        onTap: () {
          //Navigator.of(context).pushNamed('/quotes');
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) =>
                  new ClientCreditDetail()));
        }
    );
  }
}

