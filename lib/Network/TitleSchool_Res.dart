/// data : {"count":1,"total":1,"itemsPerPage":20,"page":0,"max_page":0,"items":[{"id":"ACDM1","title":"테스트 아카데미","image_url":"https://storage.googleapis.com/quadra-content/academy/ACDM1-AcademyImage-1722245539129.webp","gift":"경품\n1.경품\n2.경품\n","start_dt":"2024-07-30T00:00:00.000Z"}],"prev":[{"id":"ACDM4","title":"New Academy Added","image_url":"https://storage.googleapis.com/quadra-content/academy/ACDM4-AcademyImage-1722421115418.png","gift":null,"start_dt":"2024-07-29T00:00:00.000Z"}],"next":[{"id":"ACDM3","title":"New Academy Added","image_url":"https://storage.googleapis.com/quadra-content/academy/ACDM3-AcademyImage-1722420043388.png","gift":"경품 목록\n1.없음\n2.없음\n","start_dt":"2024-07-31T00:00:00.000Z"}]}

class TitleSchoolRes
{
  TitleSchoolRes.fromJson(dynamic json) {
    _data = json['data'] != null ? TitleSchoolData.fromJson(json['data']) : null;
  }
  TitleSchoolData? _data;

  TitleSchoolData? get data => _data;

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
/// items : [{"id":"ACDM1","title":"테스트 아카데미","image_url":"https://storage.googleapis.com/quadra-content/academy/ACDM1-AcademyImage-1722245539129.webp","gift":"경품\n1.경품\n2.경품\n","start_dt":"2024-07-30T00:00:00.000Z"}]
/// prev : [{"id":"ACDM4","title":"New Academy Added","image_url":"https://storage.googleapis.com/quadra-content/academy/ACDM4-AcademyImage-1722421115418.png","gift":null,"start_dt":"2024-07-29T00:00:00.000Z"}]
/// next : [{"id":"ACDM3","title":"New Academy Added","image_url":"https://storage.googleapis.com/quadra-content/academy/ACDM3-AcademyImage-1722420043388.png","gift":"경품 목록\n1.없음\n2.없음\n","start_dt":"2024-07-31T00:00:00.000Z"}]

class TitleSchoolData
{

  TitleSchoolData.fromJson(dynamic json) {
    _count = json['count'] ?? 0;
    _total = json['total'] ?? 0;
    _itemsPerPage = json['itemsPerPage'] ?? 0;
    _page = json['page'] ?? 0;
    _maxPage = json['max_page'] ?? 0;
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(TitleSchoolItems.fromJson(v));
      });
    }
    if (json['prev'] != null) {
      _prev = [];
      json['prev'].forEach((v) {
        _prev?.add(Prev.fromJson(v));
      });
    }
    if (json['next'] != null) {
      _next = [];
      json['next'].forEach((v) {
        _next?.add(Next.fromJson(v));
      });
    }
  }
  int _count = 0;
  int _total = 0;
  int _itemsPerPage = 0;
  int _page = 0;
  int _maxPage = 0;
  List<TitleSchoolItems>? _items;
  List<Prev>? _prev;
  List<Next>? _next;

  int get count => _count;
  int get total => _total;
  int get itemsPerPage => _itemsPerPage;
  int get page => _page;
  int get maxPage => _maxPage;
  List<TitleSchoolItems>? get items => _items;
  List<Prev>? get prev => _prev;
  List<Next>? get next => _next;

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
    final _prev = this._prev;
    if (_prev != null) {
      map['prev'] = _prev.map((v) => v.toJson()).toList();
    }
    final _next = this._next;
    if (_next != null) {
      map['next'] = _next.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "ACDM3"
/// title : "New Academy Added"
/// image_url : "https://storage.googleapis.com/quadra-content/academy/ACDM3-AcademyImage-1722420043388.png"
/// gift : "경품 목록\n1.없음\n2.없음\n"
/// start_dt : "2024-07-31T00:00:00.000Z"

class Next
{
  Next.fromJson(dynamic json) {
    _id = json['id'] ?? '';
    _title = json['title'] ?? '';
    _imageUrl = json['image_url'] ?? '';
    _gift = json['gift'] ?? '';
    _startDt = json['start_dt'] ?? '';
  }
  String _id = '';
  String _title = '';
  String _imageUrl = '';
  String _gift = '';
  String _startDt = '';

  String get id => _id;
  String get title => _title;
  String get imageUrl => _imageUrl;
  String get gift => _gift;
  String get startDt => _startDt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['image_url'] = _imageUrl;
    map['gift'] = _gift;
    map['start_dt'] = _startDt;
    return map;
  }

}

/// id : "ACDM4"
/// title : "New Academy Added"
/// image_url : "https://storage.googleapis.com/quadra-content/academy/ACDM4-AcademyImage-1722421115418.png"
/// gift : null
/// start_dt : "2024-07-29T00:00:00.000Z"

class Prev {

  Prev.fromJson(dynamic json) {
    _id = json['id'] ?? '';
    _title = json['title'] ?? '';
    _imageUrl = json['image_url'] ?? '';
    _gift = json['gift'] ?? '';
    _startDt = json['start_dt'] ?? '';
  }
  String _id = '';
  String _title = '';
  String _imageUrl = '';
  String _gift = '';
  String _startDt = '';

  String get id => _id;
  String get title => _title;
  String get imageUrl => _imageUrl;
  String get gift => _gift;
  String get startDt => _startDt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['image_url'] = _imageUrl;
    map['gift'] = _gift;
    map['start_dt'] = _startDt;
    return map;
  }
}

/// id : "ACDM1"
/// title : "테스트 아카데미"
/// image_url : "https://storage.googleapis.com/quadra-content/academy/ACDM1-AcademyImage-1722245539129.webp"
/// gift : "경품\n1.경품\n2.경품\n"
/// start_dt : "2024-07-30T00:00:00.000Z"

class TitleSchoolItems
{
  TitleSchoolItems.fromJson(dynamic json) {
    _id = json['id'] ?? '';
    _title = json['title'] ?? '';
    _imageUrl = json['image_url'] ?? '';
    _gift = json['gift'] ?? '';
    _startDt = json['start_dt'] ?? '';
  }

  String _id = '';
  String _title = '';
  String _imageUrl = '';
  String _gift = '';
  String _startDt = '';

  String get id => _id;
  String get title => _title;
  String get imageUrl => _imageUrl;
  String get gift => _gift;
  String get startDt => _startDt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['image_url'] = _imageUrl;
    map['gift'] = _gift;
    map['start_dt'] = _startDt;
    return map;
  }

}