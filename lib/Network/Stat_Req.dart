/// type_cd : "content"
/// action : "like"
/// value : 1

class StatReq
{
  StatReq({
     required String typeCd,
     required String action,
     required int value,})
  {
    _typeCd = typeCd;
    _action = action;
    _value = value;
}

  StatReq.fromJson(dynamic json) {
    _typeCd = json['type_cd'];
    _action = json['action'];
    _value = json['value'] ?? 0;
  }
  String? _typeCd;
  String? _action;
  int _value = 1;

  String? get typeCd => _typeCd;
  String? get action => _action;
  int get value => _value;

  Map<String, dynamic> toJson()
  {
    final map = <String, dynamic>{};
    map['type_cd'] = _typeCd;
    map['action'] = _action;
    map['value'] = _value;
    return map;
  }
}