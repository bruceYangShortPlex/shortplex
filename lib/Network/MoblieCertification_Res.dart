/// data : {"items":[{"seq":"55","id":"VC55","user_id":"ID100","hp_country_code":"82","hp_destination_code":null,"hp_number":"01038881360","hp_full":"+8201038881360","status":"issued","created_at":"2024-07-24T22:55:55.716Z","expired_at":"2024-07-24T23:00:55.716Z"}]}

class MoblieCertificationRes {


  MoblieCertificationRes.fromJson(dynamic json) {
    _data = json['data'] != null ? MoblieCertificationData.fromJson(json['data']) : null;
  }
  MoblieCertificationData? _data;

  MoblieCertificationData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    final _data = this._data;
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    return map;
  }

}

/// items : [{"seq":"55","id":"VC55","user_id":"ID100","hp_country_code":"82","hp_destination_code":null,"hp_number":"01038881360","hp_full":"+8201038881360","status":"issued","created_at":"2024-07-24T22:55:55.716Z","expired_at":"2024-07-24T23:00:55.716Z"}]

class MoblieCertificationData {


  MoblieCertificationData.fromJson(dynamic json) {
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(MoblieCertificationItems.fromJson(v));
      });
    }
  }
  List<MoblieCertificationItems>? _items;

  List<MoblieCertificationItems>? get items => _items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    final _items = this._items;
    if (_items != null) {
      map['items'] = _items.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// seq : "55"
/// id : "VC55"
/// user_id : "ID100"
/// hp_country_code : "82"
/// hp_destination_code : null
/// hp_number : "01038881360"
/// hp_full : "+8201038881360"
/// status : "issued"
/// created_at : "2024-07-24T22:55:55.716Z"
/// expired_at : "2024-07-24T23:00:55.716Z"

class MoblieCertificationItems
{

  MoblieCertificationItems.fromJson(dynamic json)
  {
    _seq = json['seq'] ?? '';
    _id = json['id'] ?? '';
    _userId = json['user_id'] ?? '';
    _hpCountryCode = json['hp_country_code'] ?? '';
    _hpDestinationCode = json['hp_destination_code'] ?? '';
    _hpNumber = json['hp_number'] ?? '';
    _hpFull = json['hp_full'] ?? '';
    _status = json['status'] ?? '';
    _createdAt = json['created_at'] ?? '';
    _expiredAt = json['expired_at'] ?? '';
  }

  String _seq = '';
  String _id = '';
  String _userId = '';
  String _hpCountryCode = '';
  String _hpDestinationCode = '';
  String _hpNumber = '';
  String _hpFull = '';
  String _status = '';
  String _createdAt = '';
  String _expiredAt = '';

  String get seq => _seq;
  String get id => _id;
  String get userId => _userId;
  String get hpCountryCode => _hpCountryCode;
  String get hpDestinationCode => _hpDestinationCode;
  String get hpNumber => _hpNumber;
  String get hpFull => _hpFull;
  String get status => _status;
  String get createdAt => _createdAt;
  String get expiredAt => _expiredAt;

  Map<String, dynamic> toJson()
  {
    final map = <String, dynamic>{};
    map['seq'] = _seq;
    map['id'] = _id;
    map['user_id'] = _userId;
    map['hp_country_code'] = _hpCountryCode;
    map['hp_destination_code'] = _hpDestinationCode;
    map['hp_number'] = _hpNumber;
    map['hp_full'] = _hpFull;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['expired_at'] = _expiredAt;
    return map;
  }
}