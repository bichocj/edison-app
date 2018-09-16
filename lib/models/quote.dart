import 'package:date_format/date_format.dart';

class Quote {
  int _id;
  dynamic _credit;
  String _charge_at;
  String _capital;
  String _interest;
  String _amount;
  bool _has_complete;
  dynamic _amount_debt;
  List _fees;
  bool _is_beaten;
  String _client_name;

  Quote(
      this._id,
      this._credit,
      this._charge_at,
      this._capital,
      this._interest,
      this._amount,
      this._has_complete,
      this._amount_debt,
      this._fees,
      this._is_beaten,
      this._client_name,
      );

  Quote.map(dynamic obj) {
    this._id = obj["id"];
    this._credit = obj["credit"];
    this._charge_at = formatDate(DateTime.parse(obj["charge_at"]), [dd, ' ', M, ', del ', yyyy ] );
    this._capital = obj["capital"];
    this._interest = obj["interest"];
    this._amount = obj["amount"];
    this._has_complete = obj["has_complete"];
    this._amount_debt = obj["amount_debt"];
    this._fees = obj["fees"];
    this._is_beaten = obj["is_beaten"];
    this._client_name = obj["client_name"];
  }

  int get id => _id;
  dynamic get credit => _credit;
  String get charge_at => _charge_at;
  String get capital => _capital;
  String get interest => _interest;
  String get amount => _amount;
  bool get has_complete => _has_complete;
  dynamic get amount_debt => _amount_debt;
  List get fees => _fees;
  bool get is_beaten => _is_beaten;
  String get client_name => _client_name;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["credit"] = _credit;
    map["charge_at"] = formatDate(DateTime.parse(_charge_at), [dd, ' ', M, ', del ', yyyy ] );
    map["capital"] = _capital;
    map["interest"] = _interest;
    map["amount"] = _amount;
    map["has_complete"] = _has_complete;
    map["fees"] = _fees;
    map["is_beaten"] = _is_beaten;
    map["client_name"] = _client_name;
    return map;
  }
}
