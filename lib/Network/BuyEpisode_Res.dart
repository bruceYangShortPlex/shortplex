/// data : {"process":"inventory fetch","status":false,"body":{"payment_provider":"shortplex","payment_data":{"product_type":"episode","product_id":"EP33"}},"message":"You already have it","isvalid":true,"product_type":"episode","product_id":"EP33","payment_provider":"shortplex","payment_data":{"product_type":"episode","product_id":"EP33"},"payment_transaction_id":"transaction passed","user_id":"ID115","product":{"id":"EP33","no":3,"title":"나의 장군 남친님","episode_fhd":null,"episode_hd":"CONT3-EP33-hd-1719705422891.mp4","episode_sd":null,"alt_img_url_fhd":null,"alt_img_url_hd":"https://storage.googleapis.com/quadra-content/altimages/CONT3-EP33-hd-alt-1719705422891.png","alt_img_url_sd":null,"thumbnail_img_url_fhd":null,"thumbnail_img_url_hd":"https://storage.googleapis.com/quadra-content/thumbnails/CONT3-EP33-hd-thumbnail-1719705422891.png","thumbnail_img_url_sd":null,"price_amt":"3","share_link":null,"content_id":"CONT3","created_at":"2024-06-30T08:54:42.522Z"},"inventory":[{"id":"IN8","user_id":"ID115","item_type":"episode","item_id":"EP33","title":"나의 장군 남친님","no":3,"isactive":true,"created_at":"2024-07-31T14:22:54.103Z"}]}

class BuyEpisodeRes
{
  BuyEpisodeRes.fromJson(dynamic json) {
    _data = json['data'] != null ? BuyEpisodeResData.fromJson(json['data']) : null;
  }
  BuyEpisodeResData? _data;

  BuyEpisodeResData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    final _data = this._data;
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    return map;
  }
}

/// process : "inventory fetch"
/// status : false
/// body : {"payment_provider":"shortplex","payment_data":{"product_type":"episode","product_id":"EP33"}}
/// message : "You already have it"
/// isvalid : true
/// product_type : "episode"
/// product_id : "EP33"
/// payment_provider : "shortplex"
/// payment_data : {"product_type":"episode","product_id":"EP33"}
/// payment_transaction_id : "transaction passed"
/// user_id : "ID115"
/// product : {"id":"EP33","no":3,"title":"나의 장군 남친님","episode_fhd":null,"episode_hd":"CONT3-EP33-hd-1719705422891.mp4","episode_sd":null,"alt_img_url_fhd":null,"alt_img_url_hd":"https://storage.googleapis.com/quadra-content/altimages/CONT3-EP33-hd-alt-1719705422891.png","alt_img_url_sd":null,"thumbnail_img_url_fhd":null,"thumbnail_img_url_hd":"https://storage.googleapis.com/quadra-content/thumbnails/CONT3-EP33-hd-thumbnail-1719705422891.png","thumbnail_img_url_sd":null,"price_amt":"3","share_link":null,"content_id":"CONT3","created_at":"2024-06-30T08:54:42.522Z"}
/// inventory : [{"id":"IN8","user_id":"ID115","item_type":"episode","item_id":"EP33","title":"나의 장군 남친님","no":3,"isactive":true,"created_at":"2024-07-31T14:22:54.103Z"}]

class BuyEpisodeResData
{

  BuyEpisodeResData.fromJson(dynamic json) {
    _process = json['process'] ?? '';
    _status = json['status'];
    _body = json['body'] != null ? EpisodePaymentBody.fromJson(json['body']) : null;
    _message = json['message'] ?? '';
    _isvalid = json['isvalid'] ?? false;
    _productType = json['product_type'] ?? '';
    _productId = json['product_id'] ?? '';
    _paymentProvider = json['payment_provider'] ?? '';
    _paymentData = json['payment_data'] != null ? EpisodeBuyResPaymentData.fromJson(json['payment_data']) : null;
    _paymentTransactionId = json['payment_transaction_id'];
    _userId = json['user_id'] ?? '';
    _product = json['product'] != null ? EpisodeBuyResProduct.fromJson(json['product']) : null;
    if (json['inventory'] != null) {
      _inventory = [];
      json['inventory'].forEach((v) {
        _inventory?.add(Inventory.fromJson(v));
      });
    }
  }

  String _process = '';
  dynamic _status;
  EpisodePaymentBody? _body;
  String _message = '';
  bool _isvalid = false;
  String _productType = '';
  String _productId = '';
  String _paymentProvider = '';
  EpisodeBuyResPaymentData? _paymentData;
  String _paymentTransactionId = '';
  String _userId = '';
  EpisodeBuyResProduct? _product;
  List<Inventory>? _inventory;

  String get process => _process;
  dynamic get status => _status;
  EpisodePaymentBody? get body => _body;
  String get message => _message;
  bool get isvalid => _isvalid;
  String get productType => _productType;
  String get productId => _productId;
  String get paymentProvider => _paymentProvider;
  EpisodeBuyResPaymentData? get paymentData => _paymentData;
  String get paymentTransactionId => _paymentTransactionId;
  String get userId => _userId;
  EpisodeBuyResProduct? get product => _product;
  List<Inventory>? get inventory => _inventory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['process'] = _process;
    map['status'] = _status;
    final _body = this._body;
    if (_body != null) {
      map['body'] = _body.toJson();
    }
    map['message'] = _message;
    map['isvalid'] = _isvalid;
    map['product_type'] = _productType;
    map['product_id'] = _productId;
    map['payment_provider'] = _paymentProvider;
    final _paymentData = this._paymentData;
    if (_paymentData != null) {
      map['payment_data'] = _paymentData.toJson();
    }
    map['payment_transaction_id'] = _paymentTransactionId;
    map['user_id'] = _userId;
    final _product = this._product;
    if (_product != null) {
      map['product'] = _product.toJson();
    }
    final _inventory = this._inventory;
    if (_inventory != null) {
      map['inventory'] = _inventory.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "IN8"
/// user_id : "ID115"
/// item_type : "episode"
/// item_id : "EP33"
/// title : "나의 장군 남친님"
/// no : 3
/// isactive : true
/// created_at : "2024-07-31T14:22:54.103Z"

class Inventory
{

  Inventory.fromJson(dynamic json) {
    _id = json['id'] ?? '';
    _userId = json['user_id'] ?? '';
    _itemType = json['item_type'] ?? '';
    _itemId = json['item_id'] ?? '';
    _title = json['title'] ?? '';
    _no = json['no'] ?? 0;
    _isactive = json['isactive'] ?? false;
    _createdAt = json['created_at'] ?? '';
  }

  String _id = '';
  String _userId = '';
  String _itemType = '';
  String _itemId = '';
  String _title = '';
  int _no = 0;
  bool _isactive = false;
  String _createdAt = '';

  String get id => _id;
  String get userId => _userId;
  String get itemType => _itemType;
  String get itemId => _itemId;
  String get title => _title;
  int get no => _no;
  bool get isactive => _isactive;
  String get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['item_type'] = _itemType;
    map['item_id'] = _itemId;
    map['title'] = _title;
    map['no'] = _no;
    map['isactive'] = _isactive;
    map['created_at'] = _createdAt;
    return map;
  }

}

/// id : "EP33"
/// no : 3
/// title : "나의 장군 남친님"
/// episode_fhd : null
/// episode_hd : "CONT3-EP33-hd-1719705422891.mp4"
/// episode_sd : null
/// alt_img_url_fhd : null
/// alt_img_url_hd : "https://storage.googleapis.com/quadra-content/altimages/CONT3-EP33-hd-alt-1719705422891.png"
/// alt_img_url_sd : null
/// thumbnail_img_url_fhd : null
/// thumbnail_img_url_hd : "https://storage.googleapis.com/quadra-content/thumbnails/CONT3-EP33-hd-thumbnail-1719705422891.png"
/// thumbnail_img_url_sd : null
/// price_amt : "3"
/// share_link : null
/// content_id : "CONT3"
/// created_at : "2024-06-30T08:54:42.522Z"

class EpisodeBuyResProduct
{
  EpisodeBuyResProduct.fromJson(dynamic json) {
    _id = json['id'] ?? '';
    _no = json['no'] ?? 0;
    _title = json['title'] ?? '';
    _episodeFhd = json['episode_fhd'] ?? '';
    _episodeHd = json['episode_hd'] ?? '';
    _episodeSd = json['episode_sd'] ?? '';
    _altImgUrlFhd = json['alt_img_url_fhd'] ?? '';
    _altImgUrlHd = json['alt_img_url_hd'] ?? '';
    _altImgUrlSd = json['alt_img_url_sd'] ?? '';
    _thumbnailImgUrlFhd = json['thumbnail_img_url_fhd'] ?? '';
    _thumbnailImgUrlHd = json['thumbnail_img_url_hd'] ?? '';
    _thumbnailImgUrlSd = json['thumbnail_img_url_sd'] ?? '';
    _priceAmt = json['price_amt'] ?? '';
    _shareLink = json['share_link'] ?? '';
    _contentId = json['content_id'] ?? '';
    _createdAt = json['created_at'] ?? '';
  }
  String _id = '';
  int _no = 0;
  String _title  = '';
  String _episodeFhd  = '';
  String _episodeHd  = '';
  String _episodeSd  = '';
  String _altImgUrlFhd  = '';
  String _altImgUrlHd  = '';
  String _altImgUrlSd  = '';
  String _thumbnailImgUrlFhd  = '';
  String _thumbnailImgUrlHd  = '';
  String _thumbnailImgUrlSd  = '';
  String _priceAmt  = '';
  String _shareLink  = '';
  String _contentId  = '';
  String _createdAt  = '';

  String get id => _id;
  int get no => _no;
  String get title => _title;
  String get episodeFhd => _episodeFhd;
  String get episodeHd => _episodeHd;
  String get episodeSd => _episodeSd;
  String get altImgUrlFhd => _altImgUrlFhd;
  String get altImgUrlHd => _altImgUrlHd;
  String get altImgUrlSd => _altImgUrlSd;
  String get thumbnailImgUrlFhd => _thumbnailImgUrlFhd;
  String get thumbnailImgUrlHd => _thumbnailImgUrlHd;
  String get thumbnailImgUrlSd => _thumbnailImgUrlSd;
  String get priceAmt => _priceAmt;
  String get shareLink => _shareLink;
  String get contentId => _contentId;
  String get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['no'] = _no;
    map['title'] = _title;
    map['episode_fhd'] = _episodeFhd;
    map['episode_hd'] = _episodeHd;
    map['episode_sd'] = _episodeSd;
    map['alt_img_url_fhd'] = _altImgUrlFhd;
    map['alt_img_url_hd'] = _altImgUrlHd;
    map['alt_img_url_sd'] = _altImgUrlSd;
    map['thumbnail_img_url_fhd'] = _thumbnailImgUrlFhd;
    map['thumbnail_img_url_hd'] = _thumbnailImgUrlHd;
    map['thumbnail_img_url_sd'] = _thumbnailImgUrlSd;
    map['price_amt'] = _priceAmt;
    map['share_link'] = _shareLink;
    map['content_id'] = _contentId;
    map['created_at'] = _createdAt;
    return map;
  }

}

/// product_type : "episode"
/// product_id : "EP33"

class EpisodeBuyResPaymentData
{
  EpisodeBuyResPaymentData.fromJson(dynamic json)
  {
    _productType = json['product_type'] ?? '';
    _productId = json['product_id'] ?? '';
  }

  String _productType = '';
  String _productId = '';

  String get productType => _productType;
  String get productId => _productId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_type'] = _productType;
    map['product_id'] = _productId;
    return map;
  }
}

/// payment_provider : "shortplex"
/// payment_data : {"product_type":"episode","product_id":"EP33"}

class EpisodePaymentBody
{

  EpisodePaymentBody.fromJson(dynamic json) {
    _paymentProvider = json['payment_provider'] ?? '';
    _paymentData = json['payment_data'] != null ? EpisodeBuyResPaymentData.fromJson(json['payment_data']) : null;
  }
  String _paymentProvider = '';
  EpisodeBuyResPaymentData? _paymentData;

  String get paymentProvider => _paymentProvider;
  EpisodeBuyResPaymentData? get paymentData => _paymentData;

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
