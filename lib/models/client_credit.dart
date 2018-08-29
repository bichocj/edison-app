class ClientCreditModel {
  int _id;
  String _frequency;
  int _time;
  int _rate;
  String _amount;
  String _start_at;
  int _client;
  int _quotes_quantity;
  int _quotes_payed;

  ClientCreditModel(this._id, this._frequency, this._time, this._rate, this._amount, this._start_at, this._client, this._quotes_quantity, this._quotes_payed);

  ClientCreditModel.map(dynamic obj) {
    this._id = obj["id"];
    this._frequency = obj["frequency"];
    this._time = obj["time"];
    this._rate = obj["rate"];
    this._amount = obj["amount"];
    this._start_at = obj["start_at"];
    this._client = obj["client"];
    this._quotes_quantity = obj["quotes_quantity"];
    this._quotes_payed = obj["quotes_payed"];
  }

  int get id => _id;
  String get frequency => _frequency;
  int get time => _time;
  int get rate => _rate;
  String get amount => _amount;
  String get start_at => _start_at;
  int get client => _client;
  int get quotes_quantity => _quotes_quantity;
  int get quotes_payed => _quotes_payed;

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