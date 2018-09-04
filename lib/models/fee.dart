class Fee {
  int _id;
  int _quote;
  String _amount_received;
  String _arrears;
  String _created_at;

  Fee(
      this._id,
      this._quote,
      this._amount_received,
      this._arrears,
      this._created_at,
      );

  Fee.map(dynamic obj) {
    this._id = obj["id"];
    this._quote = obj["quote"];
    this._amount_received = obj["amount_received"];
    this._arrears = obj["arrears"];
    this._created_at = obj["created_at"];
  }

  int get id => _id;
  dynamic get quote => _quote;
  String get amount_received => _amount_received;
  String get arrears => _arrears;
  String get created_at => _created_at;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["quote"] = _quote;
    map["amount_received"] = _amount_received;
    map["arrears"] = _arrears;
    map["created_at"] = _created_at;
    return map;
  }
}
