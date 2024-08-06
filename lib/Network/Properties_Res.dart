/// data : {"count":1,"total":1,"itemsPerPage":20,"page":0,"max_page":0,"items":[{"seq":"4","id":"US4","user_id":"ID115","key":"testkey","value":"myvalue","data":null,"created_at":"2024-08-06T16:38:02.026Z","created_by":"apiuser","updated_at":null,"updated_by":null,"deleted_at":null,"deleted_by":null,"remark":null}]}

class PropertiesRes {

  PropertiesRes.fromJson(dynamic json) {
    _data = json['data'] != null ? PropertiesData.fromJson(json['data']) : null;
  }

  PropertiesData? _data;
  PropertiesData? get data => _data;

  Map<String, dynamic> toJson() {
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
/// items : [{"seq":"4","id":"US4","user_id":"ID115","key":"testkey","value":"myvalue","data":null,"created_at":"2024-08-06T16:38:02.026Z","created_by":"apiuser","updated_at":null,"updated_by":null,"deleted_at":null,"deleted_by":null,"remark":null}]

class PropertiesData
{

  PropertiesData.fromJson(dynamic json) {
    _count = json['count'] ?? 0;
    _total = json['total'] ?? 0;
    _itemsPerPage = json['itemsPerPage'] ?? 0;
    _page = json['page'] ?? 0;
    _maxPage = json['max_page'] ?? 0;
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(PropertiesItems.fromJson(v));
      });
    }
  }

  int _count = 0;
  int _total = 0;
  int _itemsPerPage = 0;
  int _page = 0;
  int _maxPage = 0;
  List<PropertiesItems>? _items;

  int get count => _count;
  int get total => _total;
  int get itemsPerPage => _itemsPerPage;
  int get page => _page;
  int get maxPage => _maxPage;
  List<PropertiesItems>? get items => _items;

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

/// seq : "4"
/// id : "US4"
/// user_id : "ID115"
/// key : "testkey"
/// value : "myvalue"
/// data : null
/// created_at : "2024-08-06T16:38:02.026Z"
/// created_by : "apiuser"
/// updated_at : null
/// updated_by : null
/// deleted_at : null
/// deleted_by : null
/// remark : null

class PropertiesItems {

  PropertiesItems.fromJson(dynamic json) {
    _userId = json['user_id'] ?? '';
    _key = json['key'] ?? '';
    _value = json['value'] ?? '';
  }

  String _userId = '';
  String _key = '';
  String _value = '';


  String get userId => _userId;
  String get key => _key;
  String get value => _value;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['user_id'] = _userId;
    map['key'] = _key;
    map['value'] = _value;

    return map;
  }
}