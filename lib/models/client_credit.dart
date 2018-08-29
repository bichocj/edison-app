class ClientCredits {
  int _id;
  String _type_of_code;
  String _code;
  String _frecuency;
  int _time;
  int _rate;
  String _amount;
  String _start_at;
  String _description;
  String _amount_total;
  String _created_at;
  String _updated_at;
  int _client;

  ClientCredits(
      this._id,
      this._type_of_code,
      this._code,
      this._frecuency,
      this._time,
      this._rate,
      this._amount,
      this._start_at,
      this._description,
      this._amount_total,
      this._created_at,
      this._updated_at,
      this._client);

  ClientCredits.map(dynamic obj) {
    this._id = obj["id"];
    this._type_of_code = obj["type_of_code"];
    this._code = obj["code"];
    this._frecuency = obj["frecuency"];
    this._time = obj["time"];
    this._rate = obj["rate"];
    this._amount = obj["amount"];
    this._start_at = obj["start_at"];
    this._description = obj["description"];
    this._amount_total = obj["amount_total"];
    this._created_at = obj["created_at"];
    this._updated_at = obj["updated_at"];
    this._client = obj["client"];
  }

  int get id => _id;
  String get type_of_code => _type_of_code;
  String get code => _code;
  String get frecuency => _frecuency;
  int get time => _time;
  int get rate => _rate;
  String get amount => _amount;
  String get start_at => _start_at;
  String get description => _description;
  String get amount_total => _amount_total;
  String get created_at => _created_at;
  String get updated_at => _updated_at;
  int get client => _client;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["type_of_code"] = _type_of_code;
    map["code"] = _code;
    map["frecuency"] = _frecuency;
    map["time"] = _time;
    map["rate"] = _rate;
    map["amount"] = _amount;
    map["start_at"] = _start_at;
    map["description"] = _description;
    map["amount_total"] = _amount_total;
    map["created_at"] = _created_at;
    map["updated_at"] = _updated_at;
    map["client"] = _client;
    return map;
  }
}
