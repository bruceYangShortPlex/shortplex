import 'Content_Res.dart';

class StatRes
{
  StatRes({
     required List<Stat> data,}){
    _data = data;
}

  StatRes.fromJson(dynamic json)
  {
    if (json['data'] != null)
    {
      _data = [];
      json['data'].forEach((v) {
        _data!.add(Stat.fromJson(v));
      });
    }
  }
  List<Stat>? _data;
  List<Stat>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    final _data = this._data;
    if (_data != null) {
      map['data'] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
