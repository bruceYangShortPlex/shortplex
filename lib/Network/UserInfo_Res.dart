/// data : {"count":1,"total":1,"itemsPerPage":20,"page":0,"max_page":0,"items":[{"seq":"17","id":"TR17","user_id":"ID99","email":"jason.jang2@shortplex.co.kr","displayname":"장상열","photourl":"https://lh3.googleusercontent.com/a/ACg8ocL5_6ejaNV_Gpe9fBgknRh1zmbP1xY8-dVlSRu2zEvf1AL7Og=s96-c","gender":null,"birth_dt":null,"hp_country_code":null,"hp_destination_code":null,"hp_number":null,"hp_full":null,"hpverified":false,"alarmallow":true,"created_at":"2024-07-16T09:48:10.043Z","created_by":"adminuser","updated_at":null,"updated_by":null,"deleted_at":null,"deleted_by":null,"remark":null}]}

class UserInfoRes
{
  UserInfoRes({
     required UserResData data,}){
    _data = data;
}

  UserInfoRes.fromJson(dynamic json)
  {
    _data = (json['data'] != null ? UserResData.fromJson(json['data']) : null)!;
  }

  UserResData? _data;

  UserResData? get data => _data;

  Map<String, dynamic> toJson()
  {
    final map = <String, dynamic>{};
    final _data = this._data;
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    return map;
  }
}

/// count : 1
/// total : 1
/// itemsPerPage : 20
/// page : 0
/// max_page : 0
/// items : [{"seq":"17","id":"TR17","user_id":"ID99","email":"jason.jang2@shortplex.co.kr","displayname":"장상열","photourl":"https://lh3.googleusercontent.com/a/ACg8ocL5_6ejaNV_Gpe9fBgknRh1zmbP1xY8-dVlSRu2zEvf1AL7Og=s96-c","gender":null,"birth_dt":null,"hp_country_code":null,"hp_destination_code":null,"hp_number":null,"hp_full":null,"hpverified":false,"alarmallow":true,"created_at":"2024-07-16T09:48:10.043Z","created_by":"adminuser","updated_at":null,"updated_by":null,"deleted_at":null,"deleted_by":null,"remark":null}]

class UserResData
{
  UserResData({
    required int count,
    required int total,
    required int itemsPerPage,
    required int page,
    required int maxPage,
    required  List<UserInfoItems> items,}){
    _count = count;
    _total = total;
    _itemsPerPage = itemsPerPage;
    _page = page;
    _maxPage = maxPage;
    _items = items;
}

  UserResData.fromJson(dynamic json)
  {
    _count = json['count'] ?? 0;
    _total = json['total'] ?? 0;
    _itemsPerPage = json['itemsPerPage'] ?? 0;
    _page = json['page'] ?? 0;
    _maxPage = json['max_page'] ?? 0;
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(UserInfoItems.fromJson(v));
      });
    }
  }

  num _count = 0;
  num _total = 0;
  num _itemsPerPage = 0;
  num _page = 0;
  num _maxPage = 0;
  List<UserInfoItems>? _items;

  num get count => _count;
  num get total => _total;
  num get itemsPerPage => _itemsPerPage;
  num get page => _page;
  num get maxPage => _maxPage;
  List<UserInfoItems>? get items => _items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = _count;
    map['total'] = _total;
    map['itemsPerPage'] = _itemsPerPage;
    map['page'] = _page;
    map['max_page'] = _maxPage;
    final _items = this._items;
    if (_items != null) {
      map['items'] = _items.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// seq : "17"
/// id : "TR17"
/// user_id : "ID99"
/// email : "jason.jang2@shortplex.co.kr"
/// displayname : "장상열"
/// photourl : "https://lh3.googleusercontent.com/a/ACg8ocL5_6ejaNV_Gpe9fBgknRh1zmbP1xY8-dVlSRu2zEvf1AL7Og=s96-c"
/// gender : null
/// birth_dt : null
/// hp_country_code : null
/// hp_destination_code : null
/// hp_number : null
/// hp_full : null
/// hpverified : false
/// alarmallow : true
/// created_at : "2024-07-16T09:48:10.043Z"
/// created_by : "adminuser"
/// updated_at : null
/// updated_by : null
/// deleted_at : null
/// deleted_by : null
/// remark : null

class UserInfoItems
{
  UserInfoItems({
    required String seq,
    required String id,
    required String userId,
    required String email,
    required String displayname,
    required String photourl,
    required String gender,
    required String birthDt,
    required String hpCountryCode,
    required String hpDestinationCode,
    required String hpNumber,
    required String hpFull,
    required  bool hpverified,
    required  bool alarmallow,
    required String createdAt,
    required String createdBy,
    required String updatedAt,
    required String updatedBy,
    required String deletedAt,
    required String deletedBy,
    required String remark,}){
    _seq = seq;
    _id = id;
    _userId = userId;
    _email = email;
    _displayname = displayname;
    _photourl = photourl;
    _gender = gender;
    _birthDt = birthDt;
    _hpCountryCode = hpCountryCode;
    _hpDestinationCode = hpDestinationCode;
    _hpNumber = hpNumber;
    _hpFull = hpFull;
    _hpverified = hpverified;
    _alarmallow = alarmallow;
    _createdAt = createdAt;
    _createdBy = createdBy;
    _updatedAt = updatedAt;
    _updatedBy = updatedBy;
    _deletedAt = deletedAt;
    _deletedBy = deletedBy;
    _remark = remark;
}

  UserInfoItems.fromJson(dynamic json)
  {
    _seq = json['seq'] ?? '';
    _id = json['id'] ?? '';
    _userId = json['user_id'] ?? '';
    _email = json['email'] ?? '';
    _displayname = json['displayname'] ?? '';
    _photourl = json['photourl'] ?? '';
    _gender = json['gender'] ?? '';
    _birthDt = json['birth_dt'] ?? '';
    _hpCountryCode = json['hp_country_code'] ?? '';
    _hpDestinationCode = json['hp_destination_code'] ?? '';
    _hpNumber = json['hp_number'] ?? '';
    _hpFull = json['hp_full'] ?? '';
    _hpverified = json['hpverified'] ?? '';
    _alarmallow = json['alarmallow'] ?? '';
    _createdAt = json['created_at'] ?? '';
    _createdBy = json['created_by'] ?? '';
    _updatedAt = json['updated_at'] ?? '';
    _updatedBy = json['updated_by'] ?? '';
    _deletedAt = json['deleted_at'] ?? '';
    _deletedBy = json['deleted_by'] ?? '';
    _remark = json['remark'] ?? '';
  }
  String _seq = '';
  String _id = '';
  String _userId = '';
  String _email = '';
  String _displayname = '';
  String _photourl = '';
  String _gender = '';
  String _birthDt = '';
  String _hpCountryCode = '';
  String _hpDestinationCode = '';
  String _hpNumber = '';
  String _hpFull = '';
  bool _hpverified = false;
  bool _alarmallow = false;
  String _createdAt  = '';
  String _createdBy  = '';
  String _updatedAt = '';
  String _updatedBy = '';
  String _deletedAt = '';
  String _deletedBy = '';
  String _remark = '';

  String get seq => _seq;
  String get id => _id;
  String get userId => _userId;
  String get email => _email;
  String get displayname => _displayname;
  String get photourl => _photourl;
  dynamic get gender => _gender;
  dynamic get birthDt => _birthDt;
  dynamic get hpCountryCode => _hpCountryCode;
  dynamic get hpDestinationCode => _hpDestinationCode;
  dynamic get hpNumber => _hpNumber;
  dynamic get hpFull => _hpFull;
  bool get hpverified => _hpverified;
  bool get alarmallow => _alarmallow;
  String get createdAt => _createdAt;
  String get createdBy => _createdBy;
  dynamic get updatedAt => _updatedAt;
  dynamic get updatedBy => _updatedBy;
  dynamic get deletedAt => _deletedAt;
  dynamic get deletedBy => _deletedBy;
  dynamic get remark => _remark;

  Map<String, dynamic> toJson()
  {
    final map = <String, dynamic>{};
    map['seq'] = _seq;
    map['id'] = _id;
    map['user_id'] = _userId;
    map['email'] = _email;
    map['displayname'] = _displayname;
    map['photourl'] = _photourl;
    map['gender'] = _gender;
    map['birth_dt'] = _birthDt;
    map['hp_country_code'] = _hpCountryCode;
    map['hp_destination_code'] = _hpDestinationCode;
    map['hp_number'] = _hpNumber;
    map['hp_full'] = _hpFull;
    map['hpverified'] = _hpverified;
    map['alarmallow'] = _alarmallow;
    map['created_at'] = _createdAt;
    map['created_by'] = _createdBy;
    map['updated_at'] = _updatedAt;
    map['updated_by'] = _updatedBy;
    map['deleted_at'] = _deletedAt;
    map['deleted_by'] = _deletedBy;
    map['remark'] = _remark;
    return map;
  }

}