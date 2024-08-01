/// data : {"count":1,"total":1,"itemsPerPage":20,"page":0,"max_page":0,"items":[{"id":"60001","bonusrate":10,"max_no":50,"inputbonus":10}]}

class InvitationRewardInfoRes
{
  InvitationRewardInfoRes.fromJson(dynamic json) {
    _data = json['data'] != null ? InvitationRewardInfoData.fromJson(json['data']) : null;
  }
  InvitationRewardInfoData? _data;

  InvitationRewardInfoData? get data => _data;

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
/// items : [{"id":"60001","bonusrate":10,"max_no":50,"inputbonus":10}]

class InvitationRewardInfoData
{

  InvitationRewardInfoData.fromJson(dynamic json) {
    _count = json['count'];
    _total = json['total'];
    _itemsPerPage = json['itemsPerPage'];
    _page = json['page'];
    _maxPage = json['max_page'];
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(InvitationRewardInfoItems.fromJson(v));
      });
    }
  }
  int _count = 0;
  int _total = 0;
  int _itemsPerPage = 0;
  int _page = 0;
  int _maxPage = 0;
  List<InvitationRewardInfoItems>? _items;

  int get count => _count;
  int get total => _total;
  int get itemsPerPage => _itemsPerPage;
  int get page => _page;
  int get maxPage => _maxPage;
  List<InvitationRewardInfoItems>? get items => _items;

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

/// id : "60001"
/// bonusrate : 10
/// max_no : 50
/// inputbonus : 10

class InvitationRewardInfoItems
{
  InvitationRewardInfoItems.fromJson(dynamic json) {
    _id = json['id'] ?? '';
    _bonusrate = json['bonusrate'] ?? 0;
    _maxNo = json['max_no'] ?? 0;
    _inputbonus = json['inputbonus'] ?? 0;
  }
  String _id = '';
  int _bonusrate = 0;
  int _maxNo = 0;
  int _inputbonus = 0;

  String get id => _id;
  int get bonusrate => _bonusrate;
  int get maxNo => _maxNo;
  int get inputbonus => _inputbonus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['bonusrate'] = _bonusrate;
    map['max_no'] = _maxNo;
    map['inputbonus'] = _inputbonus;
    return map;
  }
}