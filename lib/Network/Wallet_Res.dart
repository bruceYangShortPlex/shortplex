/// data : {"count":1,"total":1,"itemsPerPage":20,"page":0,"max_page":0,"items":[{"user_id":"ID99","popcorns":"80.00","bonus":"2.00","unexpected_credit":"0"}]}

class WalletRes
{
  WalletRes({
     required WalletData data,})
  {
    _data = data;
}

  WalletRes.fromJson(dynamic json) {
    _data = json['data'] != null ? WalletData.fromJson(json['data']) : null;
  }
  WalletData? _data;

  WalletData? get data => _data;

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
/// items : [{"user_id":"ID99","popcorns":"80.00","bonus":"2.00","unexpected_credit":"0"}]

class WalletData
{
  WalletData({
   required num count,
    required num total,
    required num itemsPerPage,
    required num page,
    required num maxPage,
    required List<WalletItems> items,}){
    _count = count;
    _total = total;
    _itemsPerPage = itemsPerPage;
    _page = page;
    _maxPage = maxPage;
    _items = items;
}

  WalletData.fromJson(dynamic json) {
    _count = json['count'] ?? 0;
    _total = json['total'] ?? 0;
    _itemsPerPage = json['itemsPerPage'] ?? 0;
    _page = json['page'] ?? 0;
    _maxPage = json['max_page'] ?? 0;
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(WalletItems.fromJson(v));
      });
    }
  }
  num _count = 0;
  num _total = 0;
  num _itemsPerPage = 0;
  num _page = 0;
  num _maxPage = 0;
  List<WalletItems>? _items;

  num get count => _count;
  num get total => _total;
  num get itemsPerPage => _itemsPerPage;
  num get page => _page;
  num get maxPage => _maxPage;
  List<WalletItems>? get items => _items;

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

/// user_id : "ID99"
/// popcorns : "80.00"
/// bonus : "2.00"
/// unexpected_credit : "0"

class WalletItems {
  WalletItems({
    required String userId,
    required String popcorns,
    required String bonus,
    required String unexpectedCredit,}){
    _userId = userId;
    _popcorns = popcorns;
    _bonus = bonus;
    _unexpectedCredit = unexpectedCredit;
}

  WalletItems.fromJson(dynamic json) {
    _userId = json['user_id'] ?? '';
    _popcorns = json['popcorns'] ?? '';
    _bonus = json['bonus'] ?? '';
    _unexpectedCredit = json['unexpected_credit'] ?? '';
  }
  String _userId = '';
  String _popcorns = '';
  String _bonus = '';
  String _unexpectedCredit = '';

  String get userId => _userId;
  String get popcorns => _popcorns;
  String get bonus => _bonus;
  String get unexpectedCredit => _unexpectedCredit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['popcorns'] = _popcorns;
    map['bonus'] = _bonus;
    map['unexpected_credit'] = _unexpectedCredit;
    return map;
  }

}