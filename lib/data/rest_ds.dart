import 'dart:async';

import 'package:flutterapp/utils/network_util.dart';
import 'package:flutterapp/models/user.dart';
import 'package:flutterapp/models/client.dart';
import 'package:flutterapp/models/client_detail.dart';
import 'package:flutterapp/models/client_credit.dart';
import 'package:flutterapp/models/profile.dart';
import 'dart:io';
import 'dart:convert';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "https://edison-prod.herokuapp.com";
  //static final BASE_URL = "http://172.20.10.2:8000";
  static final LOGIN_URL = BASE_URL + "/accounts/api/login/";
  static final PROFILE_URL = BASE_URL + "/accounts/api/users/me/";
  static final CLIENTS_URL = BASE_URL + "/clients/api/clients/?zone_from=";
  static final CLIENT_DETAIL_URL = BASE_URL + "/clients/api/clients/";
  static final CLIENT_CREDIT_URL = BASE_URL + "/credits/api/credit/";
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

  Future<Profile> getProfile(String token){
    return _netUtil.get(PROFILE_URL , token).then((dynamic res) {
      print("Res getProfileasdasdasdasd");
      print(res);
      return new Profile(res["username"], res["email"], res["first_name"], res["last_name"], res["profile"]);
    });
  }

  Future<List<Client>> getClients(String token, String zone){
    return _netUtil.get(CLIENTS_URL + zone, token).then((dynamic res) {
      print(CLIENTS_URL + zone);
      final itemsTmp = res.map((i) => new Client.map(i));      
      final items = itemsTmp.cast<Client>();
      return items.toList();
    });
  }

  Future<ClientDetailModel> getClientDetail(String token, String clientId){
    return _netUtil.get(CLIENT_DETAIL_URL + clientId + '/', token).then((dynamic res) {
      print(CLIENT_DETAIL_URL + clientId);
      print("Res getClientDetail");
      print(res);
      return new ClientDetailModel(res["id"], res["name"], res["lastname"], res["dni"], res["address"], res["cellphone"], res["phone"], res["address_of_payment"], res["reference"]);
      //final detailsTmp = res.map((obj) => new ClientDetailModel.map(obj));
      //final details = detailsTmp.cast<ClientDetailModel>();
      //return details.toList();
    });
  }

  Future<List<ClientCredits>> getClientCredit(String token){
    return _netUtil.get(CLIENT_CREDIT_URL, token).then((dynamic res) {
      print("aqui es res");
      print(res);
      return res;
      //final creditTmp = res.map((obj) => new ClientCredits.map(obj));
      //final credit = creditTmp.cast<ClientCredits>();
      //return credit.toList();
    });
  }
}