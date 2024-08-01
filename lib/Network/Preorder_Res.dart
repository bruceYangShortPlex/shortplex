/// data : {"count":3,"total":3,"itemsPerPage":20,"page":0,"max_page":0,"items":[{"id":"OD55","user_id":"ID115","product_type":"invoice","product_id":"40003","name":null,"description":null,"price":null,"quantity":1,"amount":null,"status":"on-hold","order_data":{"payment_provider":"google","payment_data":{"productId":"40003","orderId":"test-transaction-id"}},"created_at":"2024-07-31T11:50:14.932Z","updated_at":null,"updated_by":null},{"id":"OD59","user_id":"ID115","product_type":"episode","product_id":"EP32","name":null,"description":null,"price":"3.00","quantity":1,"amount":"3.00","status":"on-hold","order_data":{"payment_provider":"shortplex","payment_data":{"product_type":"episode","product_id":"EP32"}},"created_at":"2024-07-31T14:21:26.375Z","updated_at":null,"updated_by":null},{"id":"OD58","user_id":"ID115","product_type":"episode","product_id":"EP33","name":null,"description":null,"price":"3.00","quantity":1,"amount":"3.00","status":"on-hold","order_data":{"payment_provider":"shortplex","payment_data":{"product_type":"episode","product_id":"EP33"}},"created_at":"2024-07-31T14:20:58.704Z","updated_at":null,"updated_by":null}]}

class PreorderRes
{
  PreorderRes.fromJson(dynamic json) {
    _data = json['data'] != null ? PreorderData.fromJson(json['data']) : null;
  }

  PreorderData? _data;
  PreorderData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    final _data = this._data;
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    return map;
  }
}

/// count : 3
/// total : 3
/// itemsPerPage : 20
/// page : 0
/// max_page : 0
/// items : [{"id":"OD55","user_id":"ID115","product_type":"invoice","product_id":"40003","name":null,"description":null,"price":null,"quantity":1,"amount":null,"status":"on-hold","order_data":{"payment_provider":"google","payment_data":{"productId":"40003","orderId":"test-transaction-id"}},"created_at":"2024-07-31T11:50:14.932Z","updated_at":null,"updated_by":null},{"id":"OD59","user_id":"ID115","product_type":"episode","product_id":"EP32","name":null,"description":null,"price":"3.00","quantity":1,"amount":"3.00","status":"on-hold","order_data":{"payment_provider":"shortplex","payment_data":{"product_type":"episode","product_id":"EP32"}},"created_at":"2024-07-31T14:21:26.375Z","updated_at":null,"updated_by":null},{"id":"OD58","user_id":"ID115","product_type":"episode","product_id":"EP33","name":null,"description":null,"price":"3.00","quantity":1,"amount":"3.00","status":"on-hold","order_data":{"payment_provider":"shortplex","payment_data":{"product_type":"episode","product_id":"EP33"}},"created_at":"2024-07-31T14:20:58.704Z","updated_at":null,"updated_by":null}]

class PreorderData
{
  PreorderData.fromJson(dynamic json) {
    _count = json['count'] ?? 0;
    _total = json['total'] ?? 0;
    _itemsPerPage = json['itemsPerPage'] ?? 0;
    _page = json['page'] ?? 0;
    _maxPage = json['max_page'] ?? 0;
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(PreorderItem.fromJson(v));
      });
    }
  }
  int _count = 0;
  int _total = 0;
  int _itemsPerPage = 0;
  int _page = 0;
  int _maxPage = 0;
  List<PreorderItem>? _items;

  int get count => _count;
  int get total => _total;
  int get itemsPerPage => _itemsPerPage;
  int get page => _page;
  int get maxPage => _maxPage;
  List<PreorderItem>? get items => _items;

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

/// id : "OD55"
/// user_id : "ID115"
/// product_type : "invoice"
/// product_id : "40003"
/// name : null
/// description : null
/// price : null
/// quantity : 1
/// amount : null
/// status : "on-hold"
/// order_data : {"payment_provider":"google","payment_data":{"productId":"40003","orderId":"test-transaction-id"}}
/// created_at : "2024-07-31T11:50:14.932Z"
/// updated_at : null
/// updated_by : null

class PreorderItem
{
  PreorderItem.fromJson(dynamic json) {
    _id = json['id'] ?? '';
    _userId = json['user_id'] ?? '';
    _productType = json['product_type'] ?? '';
    _productId = json['product_id'] ?? '';
    _name = json['name'] ?? '';
    _description = json['description'] ?? '';
    _price = json['price'] ?? '0';
    _quantity = json['quantity'] ?? 0;
    _amount = json['amount'] ?? '0';
    _status = json['status'] ?? '';
    _orderData = json['order_data'] != null ? OrderData.fromJson(json['order_data']) : null;
    _createdAt = json['created_at'] ?? '';
    _updatedAt = json['updated_at'] ?? '';
    _updatedBy = json['updated_by'] ?? '';
  }
  String _id = '';
  String _userId = '';
  String _productType = '';
  String _productId = '';
  String _name = '';
  String _description = '';
  String _price = '';
  int _quantity = 0;
  String _amount = '';
  String _status = '';
  OrderData? _orderData;
  String _createdAt = '';
  String _updatedAt = '';
  String _updatedBy = '';

  String get id => _id;
  String get userId => _userId;
  String get productType => _productType;
  String get productId => _productId;
  String get name => _name;
  String get description => _description;
  String get price => _price;
  int get quantity => _quantity;
  String get amount => _amount;
  String get status => _status;
  OrderData? get orderData => _orderData;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get updatedBy => _updatedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['product_type'] = _productType;
    map['product_id'] = _productId;
    map['name'] = _name;
    map['description'] = _description;
    map['price'] = _price;
    map['quantity'] = _quantity;
    map['amount'] = _amount;
    map['status'] = _status;
    final _orderData = this._orderData;
    if (_orderData != null) {
      map['order_data'] = _orderData.toJson();
    }
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['updated_by'] = _updatedBy;
    return map;
  }

}

/// payment_provider : "google"
/// payment_data : {"productId":"40003","orderId":"test-transaction-id"}

class OrderData
{
  OrderData.fromJson(dynamic json) {
    _paymentProvider = json['payment_provider'] ?? '';
    _paymentData = json['payment_data'] != null ? PreorderPaymentData.fromJson(json['payment_data']) : null;
  }
  String _paymentProvider = '';
  PreorderPaymentData? _paymentData;

  String get paymentProvider => _paymentProvider;
  PreorderPaymentData? get paymentData => _paymentData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['payment_provider'] = _paymentProvider;
    final _paymentData = this._paymentData;
    if (_paymentData != null) {
      map['payment_data'] = _paymentData.toJson();
    }
    return map;
  }

}

/// productId : "40003"
/// orderId : "test-transaction-id"

class PreorderPaymentData
{
  PreorderPaymentData({
    required String productId,
    required String orderId,})
  {
    _productId = productId;
    _orderId = orderId;
  }

  PreorderPaymentData.fromJson(dynamic json) {
    _productId = json['productId'] ?? '';
    _orderId = json['orderId'] ?? '';
  }
  String _productId = '';
  String _orderId = '';

  String get productId => _productId;
  String get orderId => _orderId;

  Map<String, dynamic> toJson()
  {
    final map = <String, dynamic>{};
    map['productId'] = _productId;
    map['orderId'] = _orderId;
    return map;
  }
}