import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutterapp/screens/client_detail/client_detail_screen_presenter.dart';
import 'package:flutterapp/models/client_detail.dart';
import 'package:flutterapp/screens/custom_widgets/info_item.dart';

class ClientDetail extends StatefulWidget {
  static String tag = 'client_detail';
  String clientId;
  ClientDetail({
    Key key,
    this.clientId
  }) : super(key: key);
  @override
  _ClientDetailState createState() => _ClientDetailState();
}

class _ClientDetailState extends State<ClientDetail>
    implements ClientDetailScreenContract {
  ClientDetailModel _client_detail;
  bool _success;

  ClientDetailScreenPresenter _presenter;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences _sharedPreferences;

  _fetchSessionAndNavigate() async {
    _sharedPreferences = await _prefs;
    String authToken = _sharedPreferences.getString('auth_token');
    print(authToken);
    _presenter = new ClientDetailScreenPresenter(this, authToken);
    _presenter.requestClientDetails(widget.clientId);
  }

  @override
  void initState() {
    super.initState();
    _success = false;
    _fetchSessionAndNavigate();
  }

  @override
  void onClientDetailSuccess(ClientDetailModel client_detail) {
    print("success");
    print(client_detail);
    setState(() {
      _success = true;
      _client_detail = client_detail;
    });
  }
  @override
  void onClientDetailError(String errorTxt) {
    print("error detail");
    print(errorTxt);
  }
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final double _heightImage = 240.0;
    return new Scaffold(
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/credits');
        },
        backgroundColor: themeData.primaryColorDark,
        child: new Icon(
          Icons.content_paste,
          semanticLabel: 'Add',
        ),
      ),
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
            pinned: true,
            expandedHeight: _heightImage,
            flexibleSpace: new FlexibleSpaceBar(
              title: new Text(
                this._client_detail.lastname,
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
                        colors: <Color>[Color(0x60000000), Color(0x00000000)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          new SliverList(
              delegate: new SliverChildListDelegate(<Widget>[
            new InfoItem(
              icon: Icons.person,
              title: 'Nombre Completo',
              text: "${this._client_detail.lastname}, ${this._client_detail.name}",
              primaryColor: themeData.primaryColorDark,
              textColor: themeData.hintColor,
            ),
            new Divider(),
            new InfoItem(
              icon: Icons.contacts,
              title: 'DNI',
              text: this._client_detail.dni,
              primaryColor: themeData.primaryColorDark,
              textColor: themeData.hintColor,
            ),
            new Divider(),
            new InfoItem(
              icon: Icons.home,
              title: 'Domicilio',
              text: this._client_detail.address,
              primaryColor: themeData.primaryColorDark,
              textColor: themeData.hintColor,
            ),
            new Divider(),
            new InfoItem(
              icon: Icons.phone_android,
              title: 'Celular',
              text: "${this._client_detail.cellphone}",
              primaryColor: themeData.primaryColorDark,
              textColor: themeData.hintColor,
            ),
            new Divider(),
            new InfoItem(
              icon: Icons.phone,
              title: 'Teléfono Fijo',
              text: "${this._client_detail.phone}",
              primaryColor: themeData.primaryColorDark,
              textColor: themeData.hintColor,
            ),
            new Divider(),
            new InfoItem(
              icon: Icons.business,
              title: 'Dirección del Negocio',
              text: this._client_detail.address_of_payment,
              primaryColor: themeData.primaryColorDark,
              textColor: themeData.hintColor,
            ),
            new Divider(),
            new InfoItem(
              icon: Icons.location_on,
              title: 'Referencia',
              text: this._client_detail.reference,
              primaryColor: themeData.primaryColorDark,
              textColor: themeData.hintColor,
            ),
            new Container(
              margin: new EdgeInsets.symmetric(vertical: 32.0, horizontal: 92.0),
              child: new RaisedButton(
                elevation: 4.0,
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                textColor: themeData.cardColor,
                color: themeData.primaryColor,
                splashColor: themeData.canvasColor,
                padding: new EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: new Row (
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Text('Estado de Cuenta'),
                    new Icon(Icons.content_paste, size: 16.0)
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/credits');
                },
              ),
            ),
          ])),
        ],
      ),
    );
  }
}

/*class _InfoItem extends StatelessWidget {
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
    final ThemeData themeData = Theme.of(context);
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
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins')),
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
}*/
