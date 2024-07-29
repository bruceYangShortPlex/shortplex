/// data : {"count":8,"total":8,"itemsPerPage":20,"page":0,"max_page":0,"items":[{"seq":"2","id":"PD2","name":"20팝콘","description":"+0보너스","category_id":"CAT1","category_nm":"인앱스토어","product_type":"product","price":"1900.00","stock":-1,"popcorns":20,"bonus":0,"bonusrate":"0.00","duration_days":null,"created_at":"2024-07-19T16:44:57.084Z"},{"seq":"3","id":"PD3","name":"40팝콘","description":"+2보너스","category_id":"CAT1","category_nm":"인앱스토어","product_type":"product","price":"3900.00","stock":-1,"popcorns":40,"bonus":2,"bonusrate":"5.00","duration_days":null,"created_at":"2024-07-19T16:44:57.084Z"},{"seq":"4","id":"PD4","name":"80팝콘","description":"+8보너스","category_id":"CAT1","category_nm":"인앱스토어","product_type":"product","price":"7900.00","stock":-1,"popcorns":80,"bonus":8,"bonusrate":"10.00","duration_days":null,"created_at":"2024-07-19T16:44:57.084Z"},{"seq":"5","id":"PD5","name":"140팝콘","description":"+21보너스","category_id":"CAT1","category_nm":"인앱스토어","product_type":"product","price":"13900.00","stock":-1,"popcorns":140,"bonus":21,"bonusrate":"15.00","duration_days":null,"created_at":"2024-07-19T16:44:57.084Z"},{"seq":"6","id":"PD6","name":"200팝콘","description":"+40보너스","category_id":"CAT1","category_nm":"인앱스토어","product_type":"product","price":"19900.00","stock":-1,"popcorns":200,"bonus":40,"bonusrate":"20.00","duration_days":null,"created_at":"2024-07-19T16:44:57.084Z"},{"seq":"7","id":"PD7","name":"300팝콘","description":"+90보너스","category_id":"CAT1","category_nm":"인앱스토어","product_type":"product","price":"29900.00","stock":-1,"popcorns":300,"bonus":90,"bonusrate":"30.00","duration_days":null,"created_at":"2024-07-19T16:44:57.084Z"},{"seq":"8","id":"PD8","name":"정기구독권","description":"숏플렉스의 모든 콘텐츠를 마음껏 즐길 수 있는 최고의 혜택!","category_id":"CAT1","category_nm":"인앱스토어","product_type":"subscription","price":"39900.00","stock":-1,"popcorns":0,"bonus":0,"bonusrate":"0.00","duration_days":30,"created_at":"2024-07-19T16:44:57.084Z"},{"seq":"9","id":"PD9","name":"정기구독권","description":"숏플렉스의 모든 콘텐츠를 마음껏 즐길 수 있는 최고의 혜택!","category_id":"CAT2","category_nm":"숏플렉스","product_type":"subscription","price":"800.00","stock":-1,"popcorns":0,"bonus":0,"bonusrate":"0.00","duration_days":30,"created_at":"2024-07-19T16:44:57.084Z"}]}

class ProductRes
{
  ProductRes(
  {
    required ProductData data,}){
    _data = data;
}

  ProductRes.fromJson(dynamic json)
  {
    _data = json['data'] != null ? ProductData.fromJson(json['data']) : null;
  }
  ProductData? _data;
  ProductData? get data => _data;

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

/// count : 8
/// total : 8
/// itemsPerPage : 20
/// page : 0
/// max_page : 0
/// items : [{"seq":"2","id":"PD2","name":"20팝콘","description":"+0보너스","category_id":"CAT1","category_nm":"인앱스토어","product_type":"product","price":"1900.00","stock":-1,"popcorns":20,"bonus":0,"bonusrate":"0.00","duration_days":null,"created_at":"2024-07-19T16:44:57.084Z"},{"seq":"3","id":"PD3","name":"40팝콘","description":"+2보너스","category_id":"CAT1","category_nm":"인앱스토어","product_type":"product","price":"3900.00","stock":-1,"popcorns":40,"bonus":2,"bonusrate":"5.00","duration_days":null,"created_at":"2024-07-19T16:44:57.084Z"},{"seq":"4","id":"PD4","name":"80팝콘","description":"+8보너스","category_id":"CAT1","category_nm":"인앱스토어","product_type":"product","price":"7900.00","stock":-1,"popcorns":80,"bonus":8,"bonusrate":"10.00","duration_days":null,"created_at":"2024-07-19T16:44:57.084Z"},{"seq":"5","id":"PD5","name":"140팝콘","description":"+21보너스","category_id":"CAT1","category_nm":"인앱스토어","product_type":"product","price":"13900.00","stock":-1,"popcorns":140,"bonus":21,"bonusrate":"15.00","duration_days":null,"created_at":"2024-07-19T16:44:57.084Z"},{"seq":"6","id":"PD6","name":"200팝콘","description":"+40보너스","category_id":"CAT1","category_nm":"인앱스토어","product_type":"product","price":"19900.00","stock":-1,"popcorns":200,"bonus":40,"bonusrate":"20.00","duration_days":null,"created_at":"2024-07-19T16:44:57.084Z"},{"seq":"7","id":"PD7","name":"300팝콘","description":"+90보너스","category_id":"CAT1","category_nm":"인앱스토어","product_type":"product","price":"29900.00","stock":-1,"popcorns":300,"bonus":90,"bonusrate":"30.00","duration_days":null,"created_at":"2024-07-19T16:44:57.084Z"},{"seq":"8","id":"PD8","name":"정기구독권","description":"숏플렉스의 모든 콘텐츠를 마음껏 즐길 수 있는 최고의 혜택!","category_id":"CAT1","category_nm":"인앱스토어","product_type":"subscription","price":"39900.00","stock":-1,"popcorns":0,"bonus":0,"bonusrate":"0.00","duration_days":30,"created_at":"2024-07-19T16:44:57.084Z"},{"seq":"9","id":"PD9","name":"정기구독권","description":"숏플렉스의 모든 콘텐츠를 마음껏 즐길 수 있는 최고의 혜택!","category_id":"CAT2","category_nm":"숏플렉스","product_type":"subscription","price":"800.00","stock":-1,"popcorns":0,"bonus":0,"bonusrate":"0.00","duration_days":30,"created_at":"2024-07-19T16:44:57.084Z"}]

class ProductData {
  ProductData({
    required int count,
    required int total,
    required int itemsPerPage,
    required int page,
    required int maxPage,
    required List<ProductItem> items,}){
    _count = count;
    _total = total;
    _itemsPerPage = itemsPerPage;
    _page = page;
    _maxPage = maxPage;
    _items = items;
}

  ProductData.fromJson(dynamic json)
  {
    _count = json['count'] ?? 0;
    _total = json['total'] ?? 0;
    _itemsPerPage = json['itemsPerPage'] ?? 0;
    _page = json['page'] ?? 0;
    _maxPage = json['max_page'] ?? 0;
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(ProductItem.fromJson(v));
      });
    }
  }
  int _count = 0;
  int _total = 0;
  int _itemsPerPage = 0;
  int _page = 0;
  int _maxPage = 0;
  List<ProductItem>? _items;

  int get count => _count;
  int get total => _total;
  int get itemsPerPage => _itemsPerPage;
  int get page => _page;
  int get maxPage => _maxPage;
  List<ProductItem>? get items => _items;

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

/// seq : "2"
/// id : "PD2"
/// name : "20팝콘"
/// description : "+0보너스"
/// category_id : "CAT1"
/// category_nm : "인앱스토어"
/// product_type : "product"
/// price : "1900.00"
/// stock : -1
/// popcorns : 20
/// bonus : 0
/// bonusrate : "0.00"
/// duration_days : null
/// created_at : "2024-07-19T16:44:57.084Z"

class ProductItem
{
  ProductItem.fromJson(dynamic json)
  {
    _seq = json['seq'] ?? '';
    _id = json['id'] ?? '';
    _name = json['name'] ?? '';
    _description = json['description'] ?? '';
    _categoryId = json['category_id'] ?? '';
    _categoryNm = json['category_nm'] ?? '';
    _productType = json['product_type'] ?? '';
    _price = json['price'] ?? '';
    _stock = json['stock'] ?? 0;
    _popcorns = json['popcorns'] ?? 0;
    _bonus = json['bonus'] ?? 0;

    print('json[bonus] : ${json['bonus']} :');

    _bonusrate = json['bonusrate'] ?? '';
    _durationDays = json['duration_days'] ?? 0;
    _createdAt = json['created_at'] ?? '';
    currency = json['currency'] ?? '';
    shopid = json['shopid'] ?? '';
    itemicon = json['itemicon'] ?? '';

  }
  String _seq = '';
  String _id = '';
  String _name = '';
  String _description = '';
  String _categoryId = '';
  String _categoryNm = '';
  String _productType = '';
  String _price = '';
  int _stock = 0;
  int _popcorns = 0;
  int _bonus = 0;
  String _bonusrate = '';
  int _durationDays  = 0;
  String _createdAt  = '';
  String currency = "KRW";
  String shopid = '';
  String itemicon ='';

  String get seq => _seq;
  String get id => _id;
  String get name => _name;
  String get description => _description;
  String get categoryId => _categoryId;
  String get categoryNm => _categoryNm;
  String get productType => _productType;
  String get price
  {
    return
    _price.replaceAll('.00', '');
  }
  int get stock => _stock;
  int get popcorns => _popcorns;
  int get bonus => _bonus;
  String get bonusrate
  {
    return _bonusrate.replaceAll('.00', '');
  }
  int get durationDays => _durationDays;
  String get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['seq'] = _seq;
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['category_id'] = _categoryId;
    map['category_nm'] = _categoryNm;
    map['product_type'] = _productType;
    map['price'] = _price;
    map['stock'] = _stock;
    map['popcorns'] = _popcorns;
    map['bonus'] = _bonus;
    map['bonusrate'] = _bonusrate;
    map['duration_days'] = _durationDays;
    map['created_at'] = _createdAt;
    return map;
  }


}