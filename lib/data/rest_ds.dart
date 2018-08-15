import 'dart:async';

import 'package:flutterapp/utils/network_util.dart';
import 'package:flutterapp/models/user.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "https://edison-prod.herokuapp.com";
  static final LOGIN_URL = BASE_URL + "/accounts/api/login/";
  static final _API_KEY = "somerandomkey";

  Future<String> login(String username, String password) {
    return _netUtil.post(LOGIN_URL, body: {
      "token": _API_KEY,
      "username": username,
      "password": password
    }).then((dynamic res) {
      print(res.toString());
      if(res["non_field_errors"] != null ) {
        throw new Exception(res["non_field_errors"][0]);
      }
      return res["key"];
    });
  }
}