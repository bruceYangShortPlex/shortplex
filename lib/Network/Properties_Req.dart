/// key : "testkey"
/// value : "myvalue"

class PropertiesReq
{
  PropertiesReq({
     required String key,
     required String value,}){
    _key = key;
    _value = value;
}

  PropertiesReq.fromJson(dynamic json) {
    _key = json['key'];
    _value = json['value'];
  }
  String _key = '';
  String _value = '';

  String get key => _key;
  String get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = _key;
    map['value'] = _value;
    return map;
  }

}