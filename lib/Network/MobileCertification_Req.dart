/// hp_country_code : "82"
/// hp_destination_code : "010"
/// hp_number : "12345678"

class MobileCertificationReq
{
  MobileCertificationReq({
     required String hpCountryCode,
      required String hpDestinationCode,
      required String hpNumber,}){
    _hpCountryCode = hpCountryCode;
    _hpDestinationCode = hpDestinationCode;
    _hpNumber = hpNumber;
}

  MobileCertificationReq.fromJson(dynamic json)
  {
    _hpCountryCode = json['hp_country_code'];
    _hpDestinationCode = json['hp_destination_code'];
    _hpNumber = json['hp_number'];
  }

  String _hpCountryCode = '';
  String _hpDestinationCode = '';
  String _hpNumber = '';

  String get hpCountryCode => _hpCountryCode;
  String get hpDestinationCode => _hpDestinationCode;
  String get hpNumber => _hpNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hp_country_code'] = _hpCountryCode;
    map['hp_destination_code'] = _hpDestinationCode;
    map['hp_number'] = _hpNumber;
    return map;
  }
}