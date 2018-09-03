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
      );

  Quote.map(dynamic obj) {
    this._id = obj["id"];
    this._credit = obj["credit"];
    this._charge_at = obj["charge_at"];
    this._capital = obj["capital"];
    this._interest = obj["interest"];
    this._amount = obj["amount"];
    this._has_complete = obj["has_complete"];
    this._amount_debt = obj["amount_debt"];
    this._fees = obj["fees"];
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

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["credit"] = _credit;
    map["charge_at"] = _charge_at;
    map["capital"] = _capital;
    map["interest"] = _interest;
    map["amount"] = _amount;
    map["has_complete"] = _has_complete;
    map["fees"] = _fees;
    return map;
  }
}
