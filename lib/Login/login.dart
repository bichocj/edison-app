import 'package:flutter/material.dart';
import 'package:validate/validate.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginData {
  String user = '';
  String password = '';
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  _LoginData _data = new _LoginData();
  //Validation
  String _validateUser(String value) {
    if (value.length < 1) {
      return 'Por favor, ingrese un usuario';
    }
    return null;
  }
  String _validatePassword(String value) {
    if (value.length < 6) {
      return 'La contraseña debe tener por lo menos 6 caractéres';
    }
    return null;
  }
  //Submit
  void submit() {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.
      print('Usuario: ${_data.user}');
      print('Contraseña: ${_data.password}');
    }
    //Aqui hacer la consulta al server
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: new AppBar(
        title: new Center (
          child: new Text(
            'Iniciar Sesión',
            textAlign: TextAlign.center,
            style: new TextStyle(
                color: Colors.white
            ),
          )
        ),
      ),
      body: new Container(
        padding: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
        child: new Form(
          key: this._formKey,
          child: new ListView(
            children: <Widget>[
              new Container(
                child: new Image.asset(
                  'assets/login.png',
                  width: 150.0,
                  height: 150.0,
                ),
                margin: new EdgeInsets.only(
                  bottom: 25.0
                ),
              ),
              new TextFormField(
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  labelText: 'Ingrese su usuario',
                ),
                  validator: this._validateUser,
                  onSaved: (String value) {
                    this._data.user = value;
                  }
              ),
              new TextFormField(
                obscureText: true,
                decoration: new InputDecoration(
                  labelText: 'Ingrese su contraseña',
                ),
                validator: this._validatePassword,
                onSaved: (String value) {
                  this._data.password = value;
                }
              ),
              new Container(
                width: screenSize.width,
                child: new Material(
                  borderRadius: BorderRadius.circular(30.0),
                  shadowColor: Colors.lightBlue.shade100,
                  elevation: 5.0,
                  child: new MaterialButton(
                    onPressed: this.submit,
                    minWidth: 200.0,
                    height: 42.0,
                    color: Colors.lightBlue,
                    child: Text(
                      'Ingresar',
                       style: TextStyle(color: Colors.white),
                    ),
                  ),
                  color: Colors.lightBlue,
                ),
                margin: new EdgeInsets.only(
                  top: 25.0
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



