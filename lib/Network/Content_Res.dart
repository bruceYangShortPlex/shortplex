/// data : {"id":"CONT1","title":"황후마마가 돌아왔다","subtitle":"황후마마가 돌아왔다 부제목","slug":"hwang-hu-ma-ma-ga-dor-a-wass-da","description":"황후마마가 돌아왔다 설명","teaser":"황후마마가 돌아왔다 티져","release_at":null,"restrain_at":null,"preview_yn":true,"preview_start_at":"2024-06-10T00:00:00.000Z","genre":"로맨스,로판,시대물","tag":"SF,요즘뜨는,추천","share_link":null,"cover_img_url":"https://storage.googleapis.com/quadra-content/CONT1-coverimage-1717985451250.jpeg","thumbnail_img_url":"https://storage.googleapis.com/quadra-content/CONT1-thumbnailimage-1717985440793.jpeg","poster_landscape_img_url":null,"poster_portrait_img_url":"https://storage.googleapis.com/quadra-content/CONT1-posterimageportrait-1717985447237.jpeg","string_key":null,"weight":500,"featured":true,"created_at":"2024-06-10T11:09:08.297Z","episode":[{"id":"EP1","no":1,"title":"1회차","episode_fhd":"EP1-fhd-1717993295708.mp4","episode_hd":null,"episode_sd":null,"alt_img_url":null,"price_amt":"1000","share_link":null,"content_id":"CONT1","created_at":"2024-06-10T11:21:56.639Z"},{"id":"EP2","no":2,"title":"2회차","episode_fhd":"EP2-fhd-1718016749608.mp4","episode_hd":null,"episode_sd":null,"alt_img_url":null,"price_amt":"1000","share_link":null,"content_id":"CONT1","created_at":"2024-06-10T14:47:38.552Z"},{"id":"EP3","no":3,"title":"3회차","episode_fhd":"EP3-fhd-1718078652244.mp4","episode_hd":null,"episode_sd":null,"alt_img_url":null,"price_amt":"1000","share_link":null,"content_id":"CONT1","created_at":"2024-06-11T13:03:48.731Z"}],"stat":[{"platform":"Quadra System","type_cd":"content","key":"CONT1","host":null,"path":null,"href":null,"slug":null,"action":"view","cnt":"2","amt":"2","users":"0"}]}

class ContentRes
{
  ContentRes({
      required ContentResData data,}){
    _data = data;
}

  ContentRes.fromJson(dynamic json) {
    _data = json['data'] != null ? ContentResData.fromJson(json['data']) : null;
  }
  ContentResData? _data;
ContentRes copyWith({  required ContentResData data,
}) => ContentRes(  data: _data!,
);
  ContentResData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    final _data = this._data;
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    return map;
  }

}

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
/// genre : "로맨스,로판,시대물"
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
/// episode : [{"id":"EP1","no":1,"title":"1회차","episode_fhd":"EP1-fhd-1717993295708.mp4","episode_hd":null,"episode_sd":null,"alt_img_url":null,"price_amt":"1000","share_link":null,"content_id":"CONT1","created_at":"2024-06-10T11:21:56.639Z"},{"id":"EP2","no":2,"title":"2회차","episode_fhd":"EP2-fhd-1718016749608.mp4","episode_hd":null,"episode_sd":null,"alt_img_url":null,"price_amt":"1000","share_link":null,"content_id":"CONT1","created_at":"2024-06-10T14:47:38.552Z"},{"id":"EP3","no":3,"title":"3회차","episode_fhd":"EP3-fhd-1718078652244.mp4","episode_hd":null,"episode_sd":null,"alt_img_url":null,"price_amt":"1000","share_link":null,"content_id":"CONT1","created_at":"2024-06-11T13:03:48.731Z"}]
/// stat : [{"platform":"Quadra System","type_cd":"content","key":"CONT1","host":null,"path":null,"href":null,"slug":null,"action":"view","cnt":"2","amt":"2","users":"0"}]

class ContentResData
{
  ContentResData({
      required String? id,
    required String? title,
    required String? subtitle,
    required String? slug,
    required String? description,
    required String? teaser,
    required String? releaseAt,
    required String? restrainAt,
    required bool previewYn,
    required String? previewStartAt,
    required String? genre,
    required String? tag,
    required String? shareLink,
    required String? coverImgUrl,
    required String? thumbnailImgUrl,
    required String? posterLandscapeImgUrl,
    required String? posterPortraitImgUrl,
    required String? stringKey,
    required int weight,
    required bool featured,
    required String? createdAt,
    required List<Episode>? episode,
    required List<Stat>? stat,}){
    _id = id;
    _title = title;
    _subtitle = subtitle;
    _slug = slug;
    _description = description;
    _teaser = teaser;
    _releaseAt = releaseAt;
    _restrainAt = restrainAt;
    _previewYn = previewYn;
    _previewStartAt = previewStartAt;
    _genre = genre;
    _tag = tag;
    _shareLink = shareLink;
    _coverImgUrl = coverImgUrl;
    _thumbnailImgUrl = thumbnailImgUrl;
    _posterLandscapeImgUrl = posterLandscapeImgUrl;
    _posterPortraitImgUrl = posterPortraitImgUrl;
    _stringKey = stringKey;
    _weight = weight;
    _featured = featured;
    _createdAt = createdAt;
    _episode = episode;
    _stat = stat;
}

  ContentResData.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _subtitle = json['subtitle'];
    _slug = json['slug'];
    _description = json['description'];
    _teaser = json['teaser'];
    _releaseAt = json['release_at'];
    _restrainAt = json['restrain_at'];
    _previewYn = json['preview_yn'];
    _previewStartAt = json['preview_start_at'];
    _genre = json['genre'];
    _tag = json['tag'];
    _shareLink = json['share_link'];
    _coverImgUrl = json['cover_img_url'];
    _thumbnailImgUrl = json['thumbnail_img_url'];
    _posterLandscapeImgUrl = json['poster_landscape_img_url'];
    _posterPortraitImgUrl = json['poster_portrait_img_url'];
    _stringKey = json['string_key'];
    _weight = json['weight'];
    _featured = json['featured'];
    _createdAt = json['created_at'];
    if (json['episode'] != null) {
      _episode = [];
      json['episode'].forEach((v) {
        _episode?.add(Episode.fromJson(v));
      });
    }
    if (json['stat'] != null) {
      _stat = [];
      json['stat'].forEach((v) {
        _stat?.add(Stat.fromJson(v));
      });
    }
  }
  String? _id;
  String? _title;
  String? _subtitle;
  String? _slug;
  String? _description;
  String? _teaser;
  String? _releaseAt;
  String? _restrainAt;
  bool _previewYn = false;
  String? _previewStartAt;
  String? _genre;
  String? _tag;
  String? _shareLink;
  String? _coverImgUrl;
  String? _thumbnailImgUrl;
  String? _posterLandscapeImgUrl;
  String? _posterPortraitImgUrl;
  String? _stringKey;
  int _weight = 0;
  bool _featured = false;
  String? _createdAt;
  List<Episode>? _episode;
  List<Stat>? _stat;

  String? get id => _id;
  String? get title => _title;
  String? get subtitle => _subtitle;
  String? get slug => _slug;
  String? get description => _description;
  String? get teaser => _teaser;
  String? get releaseAt => _releaseAt;
  String? get restrainAt => _restrainAt;
  bool get previewYn => _previewYn;
  String? get previewStartAt => _previewStartAt;
  String? get genre => _genre;
  String? get tag => _tag;
  String? get shareLink => _shareLink;
  String? get coverImgUrl => _coverImgUrl;
  String? get thumbnailImgUrl => _thumbnailImgUrl;
  String? get posterLandscapeImgUrl => _posterLandscapeImgUrl;
  String? get posterPortraitImgUrl => _posterPortraitImgUrl;
  String? get stringKey => _stringKey;
  int get weight => _weight;
  bool get featured => _featured;
  String? get createdAt => _createdAt;
  List<Episode>? get episode => _episode;
  List<Stat>? get stat => _stat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['subtitle'] = _subtitle;
    map['slug'] = _slug;
    map['description'] = _description;
    map['teaser'] = _teaser;
    map['release_at'] = _releaseAt;
    map['restrain_at'] = _restrainAt;
    map['preview_yn'] = _previewYn;
    map['preview_start_at'] = _previewStartAt;
    map['genre'] = _genre;
    map['tag'] = _tag;
    map['share_link'] = _shareLink;
    map['cover_img_url'] = _coverImgUrl;
    map['thumbnail_img_url'] = _thumbnailImgUrl;
    map['poster_landscape_img_url'] = _posterLandscapeImgUrl;
    map['poster_portrait_img_url'] = _posterPortraitImgUrl;
    map['string_key'] = _stringKey;
    map['weight'] = _weight;
    map['featured'] = _featured;
    map['created_at'] = _createdAt;
    final _episode = this._episode;
    if (_episode != null) {
      map['episode'] = _episode.map((v) => v.toJson()).toList();
    }
    final _stat = this._stat;
    if (_stat != null) {
      map['stat'] = _stat.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// platform : "Quadra System"
/// type_cd : "content"
/// key : "CONT1"
/// host : null
/// path : null
/// href : null
/// slug : null
/// action : "view"
/// cnt : "2"
/// amt : "2"
/// users : "0"

class Stat {
  Stat({
      required String? platform,
    required String? typeCd,
    required String? key,
    required String? host,
    required String? path,
    required String? href,
    required String? slug,
    required String? action,
    required String? cnt,
    required String? amt,
    required String? users,}){
    _platform = platform;
    _typeCd = typeCd;
    _key = key;
    _host = host;
    _path = path;
    _href = href;
    _slug = slug;
    _action = action;
    _cnt = cnt;
    _amt = amt;
    _users = users;
}

  Stat.fromJson(dynamic json)
  {
    _platform = json['platform'];
    _typeCd = json['type_cd'];
    _key = json['key'];
    _host = json['host'];
    _path = json['path'];
    _href = json['href'];
    _slug = json['slug'];
    _action = json['action'];
    _cnt = json['cnt'];
    _amt = json['amt'];
    _users = json['users'];
  }
  String? _platform;
  String? _typeCd;
  String? _key;
  String? _host;
  String? _path;
  String? _href;
  String? _slug;
  String? _action;
  String? _cnt;
  String? _amt;
  String? _users;

  String? get platform => _platform;
  String? get typeCd => _typeCd;
  String? get key => _key;
  String? get host => _host;
  String? get path => _path;
  String? get href => _href;
  String? get slug => _slug;
  String? get action => _action;
  String? get cnt => _cnt;
  String? get amt => _amt;
  String? get users => _users;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['platform'] = _platform;
    map['type_cd'] = _typeCd;
    map['key'] = _key;
    map['host'] = _host;
    map['path'] = _path;
    map['href'] = _href;
    map['slug'] = _slug;
    map['action'] = _action;
    map['cnt'] = _cnt;
    map['amt'] = _amt;
    map['users'] = _users;
    return map;
  }

}

/// id : "EP1"
/// no : 1
/// title : "1회차"
/// episode_fhd : "EP1-fhd-1717993295708.mp4"
/// episode_hd : null
/// episode_sd : null
/// alt_img_url : null
/// price_amt : "1000"
/// share_link : null
/// content_id : "CONT1"
/// created_at : "2024-06-10T11:21:56.639Z"

class Episode {
  Episode({
      required String? id,
      required int no,
    required String? title,
    required String? episodeFhd,
    required String? episodeHd,
    required String? episodeSd,
    required String? altImgUrl,
    required String? priceAmt,
    required String? shareLink,
    required String? contentId,
    required String? createdAt,}){
    _id = id;
    _no = no;
    _title = title;
    _episodeFhd = episodeFhd;
    _episodeHd = episodeHd;
    _episodeSd = episodeSd;
    _altImgUrl = altImgUrl;
    _priceAmt = priceAmt;
    _shareLink = shareLink;
    _contentId = contentId;
    _createdAt = createdAt;
}

  Episode.fromJson(dynamic json)
  {
    _id = json['id'];
    _no = json['no'];
    _title = json['title'];
    _episodeFhd = json['episode_fhd'];
    _episodeHd = json['episode_hd'];
    _episodeSd = json['episode_sd'];
    _altImgUrl = json['alt_img_url'];
    _priceAmt = json['price_amt'];
    _shareLink = json['share_link'];
    _contentId = json['content_id'];
    _createdAt = json['created_at'];
  }
  String? _id;
  int _no = 0;
  String? _title;
  String? _episodeFhd;
  String? _episodeHd;
  String? _episodeSd;
  String? _altImgUrl;
  String? _priceAmt;
  String? _shareLink;
  String? _contentId;
  String? _createdAt;

  String? get id => _id;
  int get no => _no;
  String? get title => _title;
  String? get episodeFhd => _episodeFhd;
  String? get episodeHd => _episodeHd;
  String? get episodeSd => _episodeSd;
  String? get altImgUrl => _altImgUrl;
  String? get priceAmt => _priceAmt;
  String? get shareLink => _shareLink;
  String? get contentId => _contentId;
  String? get createdAt => _createdAt;
  bool isLock  = false;
  bool isCheck = false;
  int cost = 0;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['no'] = _no;
    map['title'] = _title;
    map['episode_fhd'] = _episodeFhd;
    map['episode_hd'] = _episodeHd;
    map['episode_sd'] = _episodeSd;
    map['alt_img_url'] = _altImgUrl;
    map['price_amt'] = _priceAmt;
    map['share_link'] = _shareLink;
    map['content_id'] = _contentId;
    map['created_at'] = _createdAt;
    return map;
  }

}