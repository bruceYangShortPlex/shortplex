/// data : {"count":2,"total":2,"itemsPerPage":20,"page":0,"max_page":0,"items":[{"seq":"2","id":"GL2","user_id":"ID99","account":"충전","description":"40팝콘+2보너스","product_type":null,"product_id":null,"platform_currency":"popcorns","payment_provider":"google_play","payment_transaction_id":"223456789","payment_data":{"data":"구글 플레이 결제데이터"},"payment_currency":"KRW","payment_amt":"3900.00","debit":"0.00","credit":"40.00","balance":"50.00","created_at":"2024-07-19T08:55:42.106Z","created_by":"apiuser","updated_at":null,"updated_by":null,"deleted_at":null,"deleted_by":null,"remark":null},{"seq":"1","id":"GL1","user_id":"ID99","account":"충전","description":"40팝콘+2보너스","product_type":null,"product_id":null,"platform_currency":"popcorns","payment_provider":"google_play","payment_transaction_id":"223456789","payment_data":{"data":"구글 플레이 결제데이터"},"payment_currency":"KRW","payment_amt":"3900.00","debit":"0.00","credit":"40.00","balance":"50.00","created_at":"2024-07-19T00:30:30.813Z","created_by":"apiuser","updated_at":null,"updated_by":null,"deleted_at":null,"deleted_by":null,"remark":null}]}

class WalletHistoryRes
{
  WalletHistoryRes(
  {
    required WalletHistoryData data,
  }){
    _data = data;
}

  WalletHistoryRes.fromJson(dynamic json) {
    _data = json['data'] != null ? WalletHistoryData.fromJson(json['data']) : null;
  }
  WalletHistoryData? _data;

  WalletHistoryData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    final _data = this._data;
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    return map;
  }

}

/// count : 2
/// total : 2
/// itemsPerPage : 20
/// page : 0
/// max_page : 0
/// items : [{"seq":"2","id":"GL2","user_id":"ID99","account":"충전","description":"40팝콘+2보너스","product_type":null,"product_id":null,"platform_currency":"popcorns","payment_provider":"google_play","payment_transaction_id":"223456789","payment_data":{"data":"구글 플레이 결제데이터"},"payment_currency":"KRW","payment_amt":"3900.00","debit":"0.00","credit":"40.00","balance":"50.00","created_at":"2024-07-19T08:55:42.106Z","created_by":"apiuser","updated_at":null,"updated_by":null,"deleted_at":null,"deleted_by":null,"remark":null},{"seq":"1","id":"GL1","user_id":"ID99","account":"충전","description":"40팝콘+2보너스","product_type":null,"product_id":null,"platform_currency":"popcorns","payment_provider":"google_play","payment_transaction_id":"223456789","payment_data":{"data":"구글 플레이 결제데이터"},"payment_currency":"KRW","payment_amt":"3900.00","debit":"0.00","credit":"40.00","balance":"50.00","created_at":"2024-07-19T00:30:30.813Z","created_by":"apiuser","updated_at":null,"updated_by":null,"deleted_at":null,"deleted_by":null,"remark":null}]

class WalletHistoryData
{
  WalletHistoryData({
     required int count,
    required int total,
    required int itemsPerPage,
    required int page,
    required int maxPage,
    required List<WalletHistoryItems>? items,}){
    _count = count;
    _total = total;
    _itemsPerPage = itemsPerPage;
    _page = page;
    _maxPage = maxPage;
    _items = items;
}

  WalletHistoryData.fromJson(dynamic json) {
    _count = json['count'] ?? 0;
    _total = json['total'] ?? 0;
    _itemsPerPage = json['itemsPerPage'] ?? 0;
    _page = json['page'] ?? 0;
    _maxPage = json['max_page'] ?? 0;
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(WalletHistoryItems.fromJson(v));
      });
    }
  }
  int _count = 0;
  int _total = 0;
  int _itemsPerPage = 0;
  int _page = 0;
  int _maxPage = 0;
  List<WalletHistoryItems>? _items;

  int get count => _count;
  int get total => _total;
  int get itemsPerPage => _itemsPerPage;
  int get page => _page;
  int get maxPage => _maxPage;
  List<WalletHistoryItems>? get items => _items;

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
/// id : "GL2"
/// user_id : "ID99"
/// account : "충전"
/// description : "40팝콘+2보너스"
/// product_type : null
/// product_id : null
/// platform_currency : "popcorns"
/// payment_provider : "google_play"
/// payment_transaction_id : "223456789"
/// payment_data : {"data":"구글 플레이 결제데이터"}
/// payment_currency : "KRW"
/// payment_amt : "3900.00"
/// debit : "0.00"
/// credit : "40.00"
/// balance : "50.00"
/// created_at : "2024-07-19T08:55:42.106Z"
/// created_by : "apiuser"
/// updated_at : null
/// updated_by : null
/// deleted_at : null
/// deleted_by : null
/// remark : null

class WalletHistoryItems
{
  WalletHistoryItems.fromJson(dynamic json)
  {
    _seq = json['seq'] ?? '';
    _id = json['id'] ?? '';
    _userId = json['user_id'] ?? '';
    _account = json['account'] ?? '';
    _description = json['description'] ?? '';
    _productType = json['product_type'] ?? '';
    _productId = json['product_id'] ?? '';
    _platformCurrency = json['platform_currency'] ?? '';
    _paymentProvider = json['payment_provider'] ?? '';
    _paymentTransactionId = json['payment_transaction_id'] ?? '';
    _paymentData = json['payment_data'] != null ? WalletPaymentData.fromJson(json['payment_data']) : null;
    _paymentCurrency = json['payment_currency'] ?? '';
    _paymentAmt = json['payment_amt'] ?? '';
    _debit = json['debit'] ?? '';
    _credit = json['credit'] ?? '';
    _balance = json['balance'] ?? '';
    _createdAt = json['created_at'] ?? '';
    _createdBy = json['created_by'] ?? '';
    _updatedAt = json['updated_at'] ?? '';
    _updatedBy = json['updated_by'] ?? '';
    _deletedAt = json['deleted_at'] ?? '';
    _deletedBy = json['deleted_by'] ?? '';
    _remark = json['remark'] ?? '';
  }
  String? _seq;
  String? _id;
  String? _userId;
  String? _account;
  String? _description;
  String? _productType;
  String? _productId;
  String? _platformCurrency;
  String? _paymentProvider;
  String? _paymentTransactionId;
  WalletPaymentData? _paymentData;
  String _paymentCurrency = '';
  String _paymentAmt = '';
  String? _debit;
  String? _credit;
  String? _balance;
  String? _createdAt;
  String? _createdBy;
  String? _updatedAt;
  String? _updatedBy;
  String? _deletedAt;
  String? _deletedBy;
  String? _remark;

  String? get seq => _seq;
  String? get id => _id;
  String? get userId => _userId;
  String? get account => _account;
  String? get description => _description;
  String? get productType => _productType;
  String? get productId => _productId;
  String? get platformCurrency => _platformCurrency;
  String? get paymentProvider => _paymentProvider;
  String? get paymentTransactionId => _paymentTransactionId;
  WalletPaymentData? get paymentData => _paymentData;
  String get paymentCurrency => _paymentCurrency;
  String get paymentAmt => _paymentAmt;
  String? get debit => _debit;
  String? get credit
  {
    var value = _credit?.replaceAll('.00', '');
    return value;
  }
  String? get balance => _balance;
  String? get createdAt => _createdAt;
  String? get createdBy => _createdBy;
  String? get updatedAt => _updatedAt;
  String? get updatedBy => _updatedBy;
  String? get deletedAt => _deletedAt;
  String? get deletedBy => _deletedBy;
  String? get remark => _remark;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['seq'] = _seq;
    map['id'] = _id;
    map['user_id'] = _userId;
    map['account'] = _account;
    map['description'] = _description;
    map['product_type'] = _productType;
    map['product_id'] = _productId;
    map['platform_currency'] = _platformCurrency;
    map['payment_provider'] = _paymentProvider;
    map['payment_transaction_id'] = _paymentTransactionId;
    final _paymentData = this._paymentData;
    if (_paymentData != null) {
      map['payment_data'] = _paymentData.toJson();
    }
    map['payment_currency'] = _paymentCurrency;
    map['payment_amt'] = _paymentAmt;
    map['debit'] = _debit;
    map['credit'] = _credit;
    map['balance'] = _balance;
    map['created_at'] = _createdAt;
    map['created_by'] = _createdBy;
    map['updated_at'] = _updatedAt;
    map['updated_by'] = _updatedBy;
    map['deleted_at'] = _deletedAt;
    map['deleted_by'] = _deletedBy;
    map['remark'] = _remark;
    return map;
  }

}

/// data : "구글 플레이 결제데이터"
class WalletPaymentData {
  WalletPaymentData({
    required String data,}){
    _data = data;
}

  WalletPaymentData.fromJson(dynamic json) {
    _data = json['data'];
  }
  String? _data;

  String? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = _data;
    return map;
  }

}