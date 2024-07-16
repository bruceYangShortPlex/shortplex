/// email : "jason.jang2@shortplex.co.kr"
/// displayname : "장상열2"
/// photourl : "https://lh3.googleusercontent.com/a/ACg8ocL5_6ejaNV_Gpe9fBgknRh1zmbP1xY8-dVlSRu2zEvf1AL7Og=s96-c"
/// gender : "2c"
/// birth_dt : "2024-07-01"
/// hp_country_code : "3n"
/// hp_destination_code : "5n"
/// hp_number : "12n"
/// hpverified : false
/// alarmallow : true
/// updated_by : "ID85"

class UserInfoReq
{
  UserInfoReq({
     required String email,
    required String displayname,
    required String photourl,
    required  String gender,
    required String birthDt,
    required String hpCountryCode,
    required String hpDestinationCode,
    required String hpNumber,
    required bool alarmallow,
   }){
    _email = email;
    _displayname = displayname;
    _photourl = photourl;
    _gender = gender;
    _birthDt = birthDt;
    _hpCountryCode = hpCountryCode;
    _hpDestinationCode = hpDestinationCode;
    _hpNumber = hpNumber;
    _alarmallow = alarmallow;
  }

  UserInfoReq.fromJson(dynamic json)
  {
    _email = json['email'] ?? '';
    _displayname = json['displayname'] ?? '';
    _photourl = json['photourl'] ?? '';
    _gender = json['gender'] ?? '';
    _birthDt = json['birth_dt'] ?? '';
    _hpCountryCode = json['hp_country_code'] ?? '';
    _hpDestinationCode = json['hp_destination_code'] ?? '';
    _hpNumber = json['hp_number'] ?? '';
    _hpverified = json['hpverified'] ?? false;
    _alarmallow = json['alarmallow'] ?? false;
    _updatedBy = json['updated_by'] ?? '';
  }

  String _email = '';
  String _displayname = '';
  String _photourl = '';
  String _gender = '';
  String _birthDt = '';
  String _hpCountryCode = '';
  String _hpDestinationCode = '';
  String _hpNumber = '';
  bool _hpverified = false;
  bool _alarmallow = false;
  String _updatedBy = '';

  String get email => _email;
  String get displayname => _displayname;
  String get photourl => _photourl;
  String get gender => _gender;
  String get birthDt => _birthDt;
  String get hpCountryCode => _hpCountryCode;
  String get hpDestinationCode => _hpDestinationCode;
  String get hpNumber => _hpNumber;
  bool get hpverified => _hpverified;
  bool get alarmallow => _alarmallow;
  String get updatedBy => _updatedBy;

  Map<String, dynamic> toJson()
  {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['displayname'] = _displayname;
    map['photourl'] = _photourl;
    map['gender'] = _gender;
    map['birth_dt'] = _birthDt;
    map['hp_country_code'] = _hpCountryCode;
    map['hp_destination_code'] = _hpDestinationCode;
    map['hp_number'] = _hpNumber;
    map['hpverified'] = _hpverified;
    map['alarmallow'] = _alarmallow;
    map['updated_by'] = _updatedBy;
    return map;
  }

}