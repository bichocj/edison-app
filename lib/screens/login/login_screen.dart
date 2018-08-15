import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterapp/auth.dart';
import 'package:flutterapp/data/database_helper.dart';
import 'package:flutterapp/models/user.dart';
import 'package:flutterapp/screens/login/login_screen_presenter.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen>
    implements LoginScreenContract, AuthStateListener {
  BuildContext _ctx;

  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _password, _username;

  LoginScreenPresenter _presenter;

  LoginScreenState() {
    _presenter = new LoginScreenPresenter(this);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.subscribe(this);
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() => _isLoading = true);
      form.save();
      _presenter.doLogin(_username, _password);
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  onAuthStateChanged(AuthState state) {
   
    if(state == AuthState.LOGGED_IN)
      Navigator.of(_ctx).pushReplacementNamed("/home");
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;

    final screenSize = MediaQuery.of(context).size;

    var brandImage =
            new Container(
              child: new Image.asset('assets/login.png',width: 150.0,height: 150.0),
              margin: new EdgeInsets.only(bottom: 25.0),
            );
            
    var usernameField =
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new TextFormField(
              onSaved: (val) => _username = val,
              validator: (val) {
                return val.length < 1
                    ? "Por favor, ingrese un usuario"
                    : null;
              },
              decoration: new InputDecoration(labelText: "Ingrese su usuario"),
            ),
          );

    var passwordField = 
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new TextFormField(
              onSaved: (val) => _password = val,
              decoration: new InputDecoration(labelText: "Ingrese su contraseña"),
              validator: (val){
                return val.length < 6
                    ? "La contraseña debe tener por lo menos 6 caractéres"
                    : null;
                    },
            ),
          );

    var loginBtn = 
        new Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: new ButtonTheme(
            minWidth: screenSize.width,        
            child: new RaisedButton(
              onPressed: _submit,
              child: new Text('Ingresar', style: TextStyle(color: Colors.white),),
              color: Colors.lightBlue,          
            )
          )
        );

    var loginForm = new Column(
      children: <Widget>[
        new Form(
          key: formKey,
          child: new Column(          
            children: <Widget>[
              brandImage,
              usernameField,
              passwordField
            ],
          ),
        ),
        //loginBtn
        _isLoading ? new CircularProgressIndicator() : loginBtn
      ],
      // crossAxisAlignment: CrossAxisAlignment.center,
    );

    return new Scaffold(
      appBar: null,
      key: scaffoldKey,
      body: new Container(
        padding: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
        child: loginForm
      ),
    );
  }

  @override
  void onLoginError(String errorTxt) {
    _showSnackBar(errorTxt);
    setState(() => _isLoading = false);
  }

  @override
  void onLoginSuccess(String token) async {
    // _showSnackBar(user.toString());
    setState(() => _isLoading = false);
    // var db = new DatabaseHelper();
    // await db.saveUser(user);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.notify(AuthState.LOGGED_IN);
  }
}