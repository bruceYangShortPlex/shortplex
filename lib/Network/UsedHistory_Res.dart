/// data : {"count":1,"total":1,"itemsPerPage":20,"page":0,"max_page":0,"items":[{"user_id":"ID8","account":"구매","description":"31회귀한 황후의 연예계 공략법","product_type":"episode","product_id":"EP33","popcorns":"3.00","bonus":"3.00","created_at":"2024-08-09T03:27:57.452Z","dt":"2024-08-08T15:00:00.000Z","episode_no":31,"thumbnail_img_url_fhd":null,"thumbnail_img_url_hd":"https://storage.googleapis.com/quadra-content/thumbnails/CONT5-EP33-hd-thumbnail-1722953969738.png","thumbnail_img_url_sd":null,"price_amt":"3","thumbnail_img_url":"https://storage.googleapis.com/quadra-content/thumbnails/CONT5-thumbnailimage-1722944845075.png","poster_landscape_img_url":"https://storage.googleapis.com/quadra-content/posters/CONT5-posterimagelandscape-1722944789129.png","poster_portrait_img_url":"https://storage.googleapis.com/quadra-content/posters/CONT5-posterimageportrait-1722944793978.png"}]}

class UsedHistoryRes
{
  UsedHistoryRes.fromJson(dynamic json) {
    _data = json['data'] != null ? UsedHistoryData.fromJson(json['data']) : null;
  }

  UsedHistoryData? _data;
  UsedHistoryData? get data => _data;
}

/// count : 1
/// total : 1
/// itemsPerPage : 20
/// page : 0
/// max_page : 0
/// items : [{"user_id":"ID8","account":"구매","description":"31회귀한 황후의 연예계 공략법","product_type":"episode","product_id":"EP33","popcorns":"3.00","bonus":"3.00","created_at":"2024-08-09T03:27:57.452Z","dt":"2024-08-08T15:00:00.000Z","episode_no":31,"thumbnail_img_url_fhd":null,"thumbnail_img_url_hd":"https://storage.googleapis.com/quadra-content/thumbnails/CONT5-EP33-hd-thumbnail-1722953969738.png","thumbnail_img_url_sd":null,"price_amt":"3","thumbnail_img_url":"https://storage.googleapis.com/quadra-content/thumbnails/CONT5-thumbnailimage-1722944845075.png","poster_landscape_img_url":"https://storage.googleapis.com/quadra-content/posters/CONT5-posterimagelandscape-1722944789129.png","poster_portrait_img_url":"https://storage.googleapis.com/quadra-content/posters/CONT5-posterimageportrait-1722944793978.png"}]

class UsedHistoryData {

  UsedHistoryData.fromJson(dynamic json) {
    _count = json['count'] ?? 0;
    _total = json['total'] ?? 0;
    _itemsPerPage = json['itemsPerPage'] ?? 0;
    _page = json['page'] ?? 0;
    _maxPage = json['max_page'] ?? 0;
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(UsedHistoryItems.fromJson(v));
      });
    }
  }
  int _count = 0;
  int _total = 0;
  int _itemsPerPage = 0;
  int _page = 0;
  int _maxPage = 0;
  List<UsedHistoryItems>? _items;

  int get count => _count;
  int get total => _total;
  int get itemsPerPage => _itemsPerPage;
  int get page => _page;
  int get maxPage => _maxPage;
  List<UsedHistoryItems>? get items => _items;
}

/// user_id : "ID8"
/// account : "구매"
/// description : "31회귀한 황후의 연예계 공략법"
/// product_type : "episode"
/// product_id : "EP33"
/// popcorns : "3.00"
/// bonus : "3.00"
/// created_at : "2024-08-09T03:27:57.452Z"
/// dt : "2024-08-08T15:00:00.000Z"
/// episode_no : 31
/// thumbnail_img_url_fhd : null
/// thumbnail_img_url_hd : "https://storage.googleapis.com/quadra-content/thumbnails/CONT5-EP33-hd-thumbnail-1722953969738.png"
/// thumbnail_img_url_sd : null
/// price_amt : "3"
/// thumbnail_img_url : "https://storage.googleapis.com/quadra-content/thumbnails/CONT5-thumbnailimage-1722944845075.png"
/// poster_landscape_img_url : "https://storage.googleapis.com/quadra-content/posters/CONT5-posterimagelandscape-1722944789129.png"
/// poster_portrait_img_url : "https://storage.googleapis.com/quadra-content/posters/CONT5-posterimageportrait-1722944793978.png"

class UsedHistoryItems
{
  UsedHistoryItems.fromJson(dynamic json) {
    _userId = json['user_id'] ?? '';
    _account = json['account'] ?? '';
    _description = json['description'] ?? '';
    _productType = json['product_type'] ?? '';
    _productId = json['product_id'] ?? '';
    _popcorns = json['popcorns'] ?? '';
    _bonus = json['bonus'] ?? '';
    _createdAt = json['created_at'] ?? '';
    _dt = json['dt'] ?? '';
    _episodeNo = json['episode_no'] ?? 0;
    _thumbnailImgUrlFhd = json['thumbnail_img_url_fhd'] ?? '';
    _thumbnailImgUrlHd = json['thumbnail_img_url_hd'] ?? '';
    _thumbnailImgUrlSd = json['thumbnail_img_url_sd'] ?? '';
    _priceAmt = json['price_amt'] ?? '';
    _thumbnailImgUrl = json['thumbnail_img_url'] ?? '';
    _posterLandscapeImgUrl = json['poster_landscape_img_url'] ?? '';
    _posterPortraitImgUrl = json['poster_portrait_img_url'] ?? '';
    title = json['title'] ?? '';
  }
  String _userId = '';
  String _account = '';
  String _description = '';
  String _productType = '';
  String _productId = '';
  String _popcorns = '';
  String _bonus = '';
  String _createdAt = '';
  String _dt = '';
  int _episodeNo = 0;
  String _thumbnailImgUrlFhd = '';
  String _thumbnailImgUrlHd = '';
  String _thumbnailImgUrlSd = '';
  String _priceAmt = '';
  String _thumbnailImgUrl = '';
  String _posterLandscapeImgUrl = '';
  String _posterPortraitImgUrl = '';
  String title = '';

  String get userId => _userId;
  String get account => _account;
  String get description => _description;
  String get productType => _productType;
  String get productId => _productId;

  String get popcorns
  {
    if (_popcorns.isEmpty)
    {
      return '';
    }
    return _popcorns.split('.')[0];
  }

  String get bonus
  {
    if (_bonus.isEmpty)
    {
      return '';
    }
    return _bonus.split('.')[0];
  }

  String get createdAt => _createdAt;
  String get dt => _dt;
  int get episodeNo => _episodeNo;
  String get thumbnailImgUrlFhd => _thumbnailImgUrlFhd;
  String get thumbnailImgUrlHd => _thumbnailImgUrlHd;
  String get thumbnailImgUrlSd => _thumbnailImgUrlSd;
  String get priceAmt => _priceAmt;
  String get thumbnailImgUrl => _thumbnailImgUrl;
  String get posterLandscapeImgUrl => _posterLandscapeImgUrl;
  String get posterPortraitImgUrl => _posterPortraitImgUrl;
}