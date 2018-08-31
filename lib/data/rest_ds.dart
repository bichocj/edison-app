import 'dart:async';

import 'package:flutterapp/utils/network_util.dart';
import 'package:flutterapp/models/user.dart';
import 'package:flutterapp/models/client.dart';
import 'package:flutterapp/models/client_detail.dart';
import 'package:flutterapp/models/client_credit.dart';
import 'package:flutterapp/models/profile.dart';
import 'package:flutterapp/models/quote.dart';
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
  static final CLIENT_CREDIT_URL = BASE_URL + "/credits/api/credit/?client=";
  static final CREDIT_DETAIL_URL = BASE_URL + "/credits/api/credit/";
  static final QUOTES_URL = BASE_URL + "/credits/api/quote/?credit=";
  static final FEES_URL = BASE_URL + "/credits/api/fee/";
  static final _API_KEY = "somerandomkey";

  Future<String> login(String username, String password) {
    return _netUtil.post(LOGIN_URL, body: {
      "token": _API_KEY,
      "username": username,
      "password": password
    }).then((dynamic res) {
      if (res["non_field_errors"] != null) {
        throw new Exception(res["non_field_errors"][0]);
      }
      print('got token $res["key"]');
      return res["key"];
    });
  }

  Future<Profile> getProfile(String token) {
    return _netUtil.get(PROFILE_URL, token).then((dynamic res) {
      return new Profile(res["username"], res["email"], res["first_name"],
          res["last_name"], res["profile"]);
    });
  }

  Future<List<Client>> getClients(String token, String zone) {
    return _netUtil.get(CLIENTS_URL + zone, token).then((dynamic res) {
      final itemsTmp = res.map((i) => new Client.map(i));
      final items = itemsTmp.cast<Client>();
      return items.toList();
    });
  }

  Future<ClientDetailModel> getClientDetail(String token, String clientId) {
    return _netUtil
        .get(CLIENT_DETAIL_URL + clientId + '/', token)
        .then((dynamic res) {
      return new ClientDetailModel(
          res["id"],
          res["name"],
          res["lastname"],
          res["dni"],
          res["address"],
          res["cellphone"],
          res["phone"],
          res["address_of_payment"],
          res["reference"]);
    });
  }

  Future<List<Credit>> getCreditList(String token, int clientId) {
    return _netUtil
        .get(CLIENT_CREDIT_URL + clientId.toString(), token)
        .then((dynamic res) {
      final itemsTmp = res.map((i) => new Credit.map(i));
      final items = itemsTmp.cast<Credit>();
      return items.toList();
    });
  }

  Future<Credit> getCreditDetail(String token, String creditId) {
    return _netUtil
        .get(CREDIT_DETAIL_URL + creditId + '/', token)
        .then((dynamic res) {
      print(res.id);
    });
  }

  Future<List<Quote>> getQuotes(String token, int creditId) {
    return _netUtil
        .get(QUOTES_URL + creditId.toString(), token)
        .then((dynamic res) {
      print(QUOTES_URL + creditId.toString());
      final itemsTmp = res.map((i) => new Quote.map(i));
      final items = itemsTmp.cast<Quote>();
      return items.toList();
    });
  }

  Future<Map> postCharge(
      String token, dynamic charge, int quoteId, dynamic arrears) {
    print("Llega a url");
    return _netUtil.post(FEES_URL,
        headers: {
      "Authorization": 'token ${token}',
    }, body: {
      "quote": quoteId,
      "amount_received": charge,
      "arrears": arrears
    }).then((res) {
      print(res);
      return res;
    });
  }
}
