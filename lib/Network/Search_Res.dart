/// data : {"count":1,"total":1,"itemsPerPage":20,"page":0,"max_page":0,"items":[{"seq":"1","id":"CONT1","title":"황후마마가 돌아왔다","subtitle":"황후마마가 돌아왔다 부제목","slug":"hwang-hu-ma-ma-ga-dor-a-wass-da","description":"황후마마가 돌아왔다 설명","teaser":"황후마마가 돌아왔다 티져","release_at":null,"restrain_at":null,"preview_yn":true,"preview_start_at":"2024-06-10T00:00:00.000Z","genre":"전생물,로맨스","tag":"SF,요즘뜨는,추천","share_link":null,"cover_img_url":"https://storage.googleapis.com/quadra-content/CONT1-coverimage-1717985451250.jpeg","thumbnail_img_url":"https://storage.googleapis.com/quadra-content/CONT1-thumbnailimage-1717985440793.jpeg","poster_landscape_img_url":null,"poster_portrait_img_url":"https://storage.googleapis.com/quadra-content/CONT1-posterimageportrait-1717985447237.jpeg","string_key":null,"weight":500,"featured":true,"created_at":"2024-06-10T11:09:08.297Z","created_by":null,"updated_at":null,"updated_by":null,"deleted_at":null,"deleted_by":null,"remark":null}]}

class SearchRes
{
  SearchResData? _data;
  SearchResData get data => _data!;

  SearchRes.fromJson(dynamic json)
  {
    print('json[data] : ${json['data']}');

    _data = (json['data'] != null ? SearchResData.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data!.toJson();
    }
    return map;
  }

}

/// count : 1
/// total : 1
/// itemsPerPage : 20
/// page : 0
/// max_page : 0
/// items : [{"seq":"1","id":"CONT1","title":"황후마마가 돌아왔다","subtitle":"황후마마가 돌아왔다 부제목","slug":"hwang-hu-ma-ma-ga-dor-a-wass-da","description":"황후마마가 돌아왔다 설명","teaser":"황후마마가 돌아왔다 티져","release_at":null,"restrain_at":null,"preview_yn":true,"preview_start_at":"2024-06-10T00:00:00.000Z","genre":"전생물,로맨스","tag":"SF,요즘뜨는,추천","share_link":null,"cover_img_url":"https://storage.googleapis.com/quadra-content/CONT1-coverimage-1717985451250.jpeg","thumbnail_img_url":"https://storage.googleapis.com/quadra-content/CONT1-thumbnailimage-1717985440793.jpeg","poster_landscape_img_url":null,"poster_portrait_img_url":"https://storage.googleapis.com/quadra-content/CONT1-posterimageportrait-1717985447237.jpeg","string_key":null,"weight":500,"featured":true,"created_at":"2024-06-10T11:09:08.297Z","created_by":null,"updated_at":null,"updated_by":null,"deleted_at":null,"deleted_by":null,"remark":null}]

class SearchResData
{
  int _count = 0;
  int _total = 0;
  int _itemsPerPage = 0;
  int _page = 0;
  int _maxPage = 0;
  List<Items> _items = <Items>[];

  SearchResData({
      required int count,
      required int total,
      required int itemsPerPage,
      required int page,
      required int maxPage,
      required List<Items> items,}){
    _count = count;
    _total = total;
    _itemsPerPage = itemsPerPage;
    _page = page;
    _maxPage = maxPage;
    _items = items;
}

  SearchResData.fromJson(dynamic json)
  {
    _count = json['count'];
    _total = json['total'];
    _itemsPerPage = json['itemsPerPage'];
    _page = json['page'];
    _maxPage = json['max_page'];
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items.add(Items.fromJson(v));
      });
    }
  }

SearchResData copyWith({  required int count,
  required int total,
  required int itemsPerPage,
  required int page,
  required int maxPage,
  required List<Items> items,
}) => SearchResData(  count: count ?? _count,
  total: total ?? _total,
  itemsPerPage: itemsPerPage ?? _itemsPerPage,
  page: page ?? _page,
  maxPage: maxPage ?? _maxPage,
  items: items ?? _items,
);
  int get count => _count;
  int get total => _total;
  int get itemsPerPage => _itemsPerPage;
  int get page => _page;
  int get maxPage => _maxPage;
  List<Items> get items => _items;

  Map<String, dynamic> toJson()
  {
    final map = <String, dynamic>{};

    map['count'] = _count;
    map['total'] = _total;
    map['itemsPerPage'] = _itemsPerPage;
    map['page'] = _page;
    map['max_page'] = _maxPage;

    if (_items != null)
    {
      map['items'] = _items.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// seq : "1"
/// id : "CONT1"
/// title : "황후마마가 돌아왔다"
/// subtitle : "황후마마가 돌아왔다 부제목"
/// slug : "hwang-hu-ma-ma-ga-dor-a-wass-da"
/// description : "황후마마가 돌아왔다 설명"
/// teaser : "황후마마가 돌아왔다 티져"
/// release_at : null
/// restrain_at : null
/// preview_yn : true
/// preview_start_at : "2024-06-10T00:00:00.000Z"
/// genre : "전생물,로맨스"
/// tag : "SF,요즘뜨는,추천"
/// share_link : null
/// cover_img_url : "https://storage.googleapis.com/quadra-content/CONT1-coverimage-1717985451250.jpeg"
/// thumbnail_img_url : "https://storage.googleapis.com/quadra-content/CONT1-thumbnailimage-1717985440793.jpeg"
/// poster_landscape_img_url : null
/// poster_portrait_img_url : "https://storage.googleapis.com/quadra-content/CONT1-posterimageportrait-1717985447237.jpeg"
/// string_key : null
/// weight : 500
/// featured : true
/// created_at : "2024-06-10T11:09:08.297Z"
/// created_by : null
/// updated_at : null
/// updated_by : null
/// deleted_at : null
/// deleted_by : null
/// remark : null

class Items
{
  int _weight = 0;
  bool _featured = false;
  bool _previewYn = false;

  String? _seq;
  String? _id = '';
  String? _title = '';
  String? _subtitle = '';
  String? _slug = '';
  String? _description = '';
  String? _teaser = '';
  String? _previewStartAt = '';
  String? _genre = '';
  String? _tag = '';
  String? _coverImgUrl = '';
  String? _thumbnailImgUrl = '';
  String? _posterPortraitImgUrl = '';
  String? _createdAt = '';
  String? _releaseAt;
  String? _restrainAt;
  String? _shareLink;
  String? _posterLandscapeImgUrl = '';
  String? _stringKey = '';
  String? _createdBy;
  String? _updatedAt;
  String? _updatedBy;
  String? _deletedAt;
  String? _deletedBy;
  String? _remark;

  int get weight => _weight;
  bool get previewYn => _previewYn;
  bool get featured => _featured;
  String? get seq => _seq;
  String? get id => _id;
  String? get title => _title;
  String? get subtitle => _subtitle;
  String? get slug => _slug;
  String? get description => _description;
  String? get teaser => _teaser;
  String? get previewStartAt => _previewStartAt;
  String? get genre => _genre;
  String? get tag => _tag;
  String? get coverImgUrl => _coverImgUrl;
  String? get thumbnailImgUrl => _thumbnailImgUrl;
  String? get posterPortraitImgUrl => _posterPortraitImgUrl;
  String? get createdAt => _createdAt;
  String? get releaseAt => _releaseAt;
  String? get restrainAt => _restrainAt;
  String? get shareLink => _shareLink;
  String? get posterLandscapeImgUrl => _posterLandscapeImgUrl;
  String? get stringKey => _stringKey;
  String? get createdBy => _createdBy;
  String? get updatedAt => _updatedAt;
  String? get updatedBy => _updatedBy;
  String? get deletedAt => _deletedAt;
  String? get deletedBy => _deletedBy;
  String? get remark => _remark;

  Items.fromJson(dynamic json)
  {
    _seq = json['seq'];
    _id = json['id'];
    _title = json['title'];
    _subtitle = json['subtitle'];
    _slug = json['slug'];
    _description = json['description'];
    _teaser = json['teaser'];
    _previewYn = json['preview_yn'];
    _previewStartAt = json['preview_start_at'];
    _genre = json['genre'];
    _tag = json['tag'];
    _coverImgUrl = json['cover_img_url'];
    _thumbnailImgUrl = json['thumbnail_img_url'];
    _posterPortraitImgUrl = json['poster_portrait_img_url'];
    _weight = json['weight'];
    _featured = json['featured'];
    _createdAt = json['created_at'];
    _releaseAt = json['release_at'];
    _restrainAt = json['restrain_at'];
    _shareLink = json['share_link'];
    _posterLandscapeImgUrl = json['poster_landscape_img_url'];
    _stringKey = json['string_key'];
    _createdBy = json['created_by'];
    _updatedAt = json['updated_at'];
    _updatedBy = json['updated_by'];
    _deletedAt = json['deleted_at'];
    _deletedBy = json['deleted_by'];
    _remark = json['remark'];
  }

// Items copyWith({  String seq,
//   String id,
//   String title,
//   String subtitle,
//   String slug,
//   String description,
//   String teaser,
//   dynamic releaseAt,
//   dynamic restrainAt,
//   bool previewYn,
//   String previewStartAt,
//   String genre,
//   String tag,
//   dynamic shareLink,
//   String coverImgUrl,
//   String thumbnailImgUrl,
//   dynamic posterLandscapeImgUrl,
//   String posterPortraitImgUrl,
//   dynamic stringKey,
//   num weight,
//   bool featured,
//   String createdAt,
//   dynamic createdBy,
//   dynamic updatedAt,
//   dynamic updatedBy,
//   dynamic deletedAt,
//   dynamic deletedBy,
//   dynamic remark,
// }) => Items(  seq: seq ?? _seq,
//   id: id ?? _id,
//   title: title ?? _title,
//   subtitle: subtitle ?? _subtitle,
//   slug: slug ?? _slug,
//   description: description ?? _description,
//   teaser: teaser ?? _teaser,
//   releaseAt: releaseAt ?? _releaseAt,
//   restrainAt: restrainAt ?? _restrainAt,
//   previewYn: previewYn ?? _previewYn,
//   previewStartAt: previewStartAt ?? _previewStartAt,
//   genre: genre ?? _genre,
//   tag: tag ?? _tag,
//   shareLink: shareLink ?? _shareLink,
//   coverImgUrl: coverImgUrl ?? _coverImgUrl,
//   thumbnailImgUrl: thumbnailImgUrl ?? _thumbnailImgUrl,
//   posterLandscapeImgUrl: posterLandscapeImgUrl ?? _posterLandscapeImgUrl,
//   posterPortraitImgUrl: posterPortraitImgUrl ?? _posterPortraitImgUrl,
//   stringKey: stringKey ?? _stringKey,
//   weight: weight ?? _weight,
//   featured: featured ?? _featured,
//   createdAt: createdAt ?? _createdAt,
//   createdBy: createdBy ?? _createdBy,
//   updatedAt: updatedAt ?? _updatedAt,
//   updatedBy: updatedBy ?? _updatedBy,
//   deletedAt: deletedAt ?? _deletedAt,
//   deletedBy: deletedBy ?? _deletedBy,
//   remark: remark ?? _remark,
// );


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['seq'] = _seq;
    map['id'] = _id;
    map['title'] = _title;
    map['subtitle'] = _subtitle;
    map['slug'] = _slug;
    map['description'] = _description;
    map['teaser'] = _teaser;
    map['preview_yn'] = _previewYn;
    map['preview_start_at'] = _previewStartAt;
    map['genre'] = _genre;
    map['tag'] = _tag;
    map['cover_img_url'] = _coverImgUrl;
    map['thumbnail_img_url'] = _thumbnailImgUrl;
    map['poster_portrait_img_url'] = _posterPortraitImgUrl;
    map['weight'] = _weight;
    map['featured'] = _featured;
    map['created_at'] = _createdAt;
    map['release_at'] = _releaseAt;
    map['restrain_at'] = _restrainAt;
    map['share_link'] = _shareLink;
    map['poster_landscape_img_url'] = _posterLandscapeImgUrl;
    map['string_key'] = _stringKey;
    map['created_by'] = _createdBy;
    map['updated_at'] = _updatedAt;
    map['updated_by'] = _updatedBy;
    map['deleted_at'] = _deletedAt;
    map['deleted_by'] = _deletedBy;
    map['remark'] = _remark;
    return map;
  }
}