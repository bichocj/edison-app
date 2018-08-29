import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutterapp/screens/client_detail/client_detail_screen_presenter.dart';
import 'package:flutterapp/models/client_detail.dart';
import 'package:flutterapp/screens/custom_widgets/info_item.dart';
import 'package:flutterapp/screens/client_credit/client_credits_screen.dart';

class ClientDetail extends StatefulWidget {
  static String tag = 'client_detail';
  final String clientId;
  ClientDetail({Key key, this.clientId}) : super(key: key);
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
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) =>
                  new ClientCredits(client: this._client_detail)));
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
              text:
                  "${this._client_detail.lastname}, ${this._client_detail.name}",
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
                new Padding(padding: new EdgeInsets.all(8.0))
          ])),
        ],
      ),
    );
  }
}
