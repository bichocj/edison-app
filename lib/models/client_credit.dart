import 'package:date_format/date_format.dart';

class Credit {
  int _id;
  String _frequency;
  int _time;
  dynamic _rate;
  String _amount;
  String _start_at;
  String _deliver_at;
  String _due_date;
  int _client;
  dynamic _quotes_quantity;
  // dynamic _amount_payed;
  // String _amount_total;
  int _days_late;
  dynamic _current_arrear;

  double _amount_payed;
  double _amount_total;
  // int _days_late;
  // double _current_arrear;

  Credit(
      this._id,
      this._frequency,
      this._time,
      this._rate,
      this._amount,
      this._start_at,
      this._client,
      this._quotes_quantity,
      this._amount_payed,
      this._amount_total,
      this._days_late,
      this._current_arrear);

  Credit.map(dynamic obj) {
    this._id = obj["id"];
    this._frequency = obj["frequency"];
    this._time = obj["time"];
    this._rate = obj["rate"];
    this._amount = obj["amount"];
    this._start_at = formatDate(DateTime.parse(obj["start_at"]), [dd, ' ', M, ', del ', yyyy ] );
    this._deliver_at = formatDate(DateTime.parse(obj["deliver_at"]), [dd, ' ', M, ', del ', yyyy ] );
    this._due_date = formatDate(DateTime.parse(obj["due_date"]), [dd, ' ', M, ', del ', yyyy ] );
    this._client = obj["client"];
    this._quotes_quantity = obj["quotes_quantity"];
    //this._amount_payed = obj["amount_payed"];
    // this._amount_total = obj["amount_total"];
    this._days_late = obj["days_late"];
    this._current_arrear = obj["current_arrear"];

    this._amount_payed = double.parse(obj["amount_payed"] ?? "0");
    this._amount_total = double.parse(obj["amount_total"] ?? "0");
    // this._days_late = obj["days_late"];
    // this._current_arrear = double.parse(obj["current_arrear"] ?? "0");

  }

  int get id => _id;
  String get frequency => _frequency;
  int get time => _time;
  dynamic get rate => _rate;
  String get amount => _amount;
  String get start_at => _start_at;
  String get deliver_at => _deliver_at;
  String get due_date => _due_date;
  int get client => _client;
  dynamic get quotes_quantity => _quotes_quantity;
  double get amount_payed => _amount_payed;
  double get amount_total => _amount_total;
  int get days_late => _days_late;
  double get current_arrear => _current_arrear;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["frequency"] = _frequency;
    map["time"] = _time;
    map["rate"] = _rate;
    map["amount"] = _amount;
    map["start_at"] = _start_at;
    map["deliver_at"] = _deliver_at;
    map["due_date"] = _due_date;
    map["client"] = _client;
    map["quotes_quantity"] = _quotes_quantity;
    map["amount_payed"] = _amount_payed;
    map["amount_total"] = _amount_total;
    map["days_late"] = _days_late;
    map["current_arrear"] = _current_arrear;
    return map;
  }
}
