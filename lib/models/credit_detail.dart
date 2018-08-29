class CreditDetailModel {
  int _id;
  String _frequency;
  int _time;
  int _rate;
  String _amount;
  String _start_at;
  int _client;
  int _quotes_quantity;
  int _quotes_payed;

  CreditDetailModel(this._id, this._frequency, this._time, this._rate, this._amount, this._start_at, this._client, this._quotes_quantity, this._quotes_payed);

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["frequency"] = _frequency;
    map["time"] = _time;
    map["rate"] = _rate;
    map["amount"] = _amount;
    map["start_at"] = _start_at;
    map["client"] = _client;
    map["quotes_quantity"] = _quotes_quantity;
    map["quotes_payed"] = _quotes_payed;
    return map;
  }
}
