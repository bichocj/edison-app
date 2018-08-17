import 'dart:async';

import 'package:flutterapp/utils/network_util.dart';
import 'package:flutterapp/models/user.dart';
import 'package:flutterapp/models/client.dart';
import 'dart:io';
import 'dart:convert';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  //static final BASE_URL = "https://edison-prod.herokuapp.com";
  static final BASE_URL = "http://172.20.10.2:8000";
  static final LOGIN_URL = BASE_URL + "/accounts/api/login/";
  static final CLIENTS_URL = BASE_URL + "/clients/api/clients/";
  static final _API_KEY = "somerandomkey";

  Future<String> login(String username, String password) {
    print('zazaz aza azaz a');

    return _netUtil.post(LOGIN_URL, body: {
      "token": _API_KEY,
      "username": username,
      "password": password
    }).then((dynamic res) {
      if(res["non_field_errors"] != null ) {
        throw new Exception(res["non_field_errors"][0]);
      }
      print('got token $res["key"]');
      return res["key"];
    });
  }

  Future<List<Client>> getClients(String token){
    return _netUtil.get(CLIENTS_URL, token).then((dynamic res) {            
      final itemsTmp = res.map((i) => new Client.map(i));      
      final items = itemsTmp.cast<Client>();
      return items.toList();
    });
  }
}