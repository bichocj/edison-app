class ClientDetail {
  int _id;
  String _name;
  String _lastname;
  String _dni;
  //Class Bussiness
  String _address;
  int _cellphone;
  String _phone;
  String _address_of_payment;
  String _reference;

  ClientDetail(this._id, this._name, this._lastname, this._dni, this._address,
      this._cellphone, this._phone, this._address_of_payment, this._reference);

  ClientDetail.map(dynamic obj) {
    this._id = obj["id"];
    this._name = obj["name"];
    this._lastname = obj["lastname"];
    this._dni = obj["dni"];
    this._address = obj["address"];
    this._cellphone = obj["cellphone"];
    this._phone = obj["phone"];
    this._address_of_payment = obj["address_of_payment"];
    this._reference = obj["reference"];
  }

  int get id => _id;
  String get name => _name;
  String get lastname => _lastname;
  String get dni => _dni;
  String get address => _address;
  int get cellphone => _cellphone;
  String get phone => _phone;
  String get address_of_payment => _address_of_payment;
  String get reference => _reference;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["name"] = _name;
    map["lastname"] = _lastname;
    map["dni"] = _dni;
    map["address"] = _address;
    map["cellphone"] = _cellphone;
    map["phone"] = _phone;
    map["address_of_payment"] = _address_of_payment;
    map["reference"] = _reference;
    return map;
  }
}
