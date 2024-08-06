import 'package:flutter/foundation.dart';

class ContentRes
{
  ContentInfoRes({
    required ContentResData data,}){
    _data = data;
  }

  ContentRes.fromJson(dynamic json) {
    _data = (json['data'] != null ? ContentResData.fromJson(json['data']) : null)!;
  }
  ContentResData? _data;

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

class ContentResData
{
  ContentResData.fromJson(dynamic json) {
    _id = json['id'] ?? '';
    _title = json['title'] ?? '';
    _subtitle = json['subtitle'] ?? '';
    _slug = json['slug'] ?? '';
    _description = json['description'] ?? '';
    _teaser = json['teaser'] ?? '';
    _releaseAt = json['release_at'] ?? '';
    _restrainAt = json['restrain_at'] ?? '';
    _previewYn = json['preview_yn'] ?? false;
    _previewStartAt = json['preview_start_at'] ?? '';
    _genre = json['genre_cd'] ?? '';
    _tag = json['tag'] ?? '';
    _shareLink = json['share_link'] ?? '';
    _coverImgUrl = json['cover_img_url'] ?? '';
    _thumbnailImgUrl = json['thumbnail_img_url'] ?? '';
    _posterLandscapeImgUrl = json['poster_landscape_img_url'] ?? '';
    _posterPortraitImgUrl = json['poster_portrait_img_url'] ?? '';
    _stringKey = json['string_key'] ?? '';
    _weight = json['weight'] ?? 0;
    _featured = json['featured'] ?? false;
    _topten = json['topten'] ?? false;
    _createdAt = json['created_at'] ?? '';
    _episodeTotal = json['episode_total'] ?? 0;
    _episodeMaxpage = json['episode_maxpage'] ?? 0;
    releaseEventDt = json['release_event_dt'] ?? '';
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
  String _id = '';
  String _title = '';
  String _subtitle = '';
  String _slug = '';
  String _description = '';
  String _teaser = '';
  String _releaseAt = '';
  String _restrainAt = '';
  bool _previewYn = false;
  String _previewStartAt = '';
  String _genre = '';
  String _tag = '';
  String _shareLink = '';
  String _coverImgUrl = '';
  String _thumbnailImgUrl = '';
  String _posterLandscapeImgUrl = '';
  String _posterPortraitImgUrl = '';
  String _stringKey = '';
  int _weight = 0;
  bool _featured = false;
  bool _topten = false;
  String _createdAt  = '';
  int _episodeTotal = 0;
  int _episodeMaxpage = 0;
  String releaseEventDt = '';
  List<Episode>? _episode;
  List<Stat>? _stat;

  String get id => _id;
  String get title => _title;
  String get subtitle => _subtitle;
  String get slug => _slug;
  String get description => _description;
  String get teaser => _teaser;
  String get releaseAt => _releaseAt;
  String get restrainAt => _restrainAt;
  bool get previewYn => _previewYn;
  String get previewStartAt => _previewStartAt;
  String get genre => _genre;
  String get tag => _tag;
  String get shareLink => _shareLink;
  String get coverImgUrl => _coverImgUrl;
  String get thumbnailImgUrl => _thumbnailImgUrl;
  String get posterLandscapeImgUrl => _posterLandscapeImgUrl;
  String get posterPortraitImgUrl => _posterPortraitImgUrl;
  String get stringKey => _stringKey;
  int get weight => _weight;
  bool get featured => _featured;
  bool get topten => _topten;
  String get createdAt => _createdAt;
  int get episodeTotal => _episodeTotal;
  int get episodeMaxpage => _episodeMaxpage;
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
    map['topten'] = _topten;
    map['created_at'] = _createdAt;
    map['episode_total'] = _episodeTotal;
    map['episode_maxpage'] = _episodeMaxpage;
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

class Stat {
  Stat({
    required String platform,
    required String typeCd,
    required String key,
    required String host,
    required String path,
    required String href,
    required String slug,
    required String action,
    required String cnt,
    required int amt,
    required String users,}){
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

  Stat.fromJson(dynamic json) {
    _platform = json['platform'] ?? '';
    _typeCd = json['type_cd'] ?? '';
    _key = json['key'] ?? '';
    _host = json['host'] ?? '';
    _path = json['path'] ?? '';
    _href = json['href'] ?? '';
    _slug = json['slug'] ?? '';
    _action = json['action'] ?? '';
    _cnt = json['cnt'] ?? '';
    _amt = json['amt'] != null ? int.parse(json['amt']) : 0;
    _users = json['users'] ?? '';
    user_id = json['user_id'] ?? '';
  }
  String _platform = '';
  String _typeCd = '';
  String _key = '';
  String _host = '';
  String _path = '';
  String _href = '';
  String _slug = '';
  String _action = '';
  String _cnt = '';
  int _amt = 0;
  String _users = '';
  String user_id = '';

  String get platform => _platform;
  String get typeCd => _typeCd;
  String get key => _key;
  String get host => _host;
  String get path => _path;
  String get href => _href;
  String get slug => _slug;
  String get action => _action;
  String get cnt => _cnt;
  int get amt => _amt;
  String get users => _users;

  Map<String, dynamic> toJson()
  {
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

class Episode {

  Episode.fromJson(dynamic json) {
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
    _priceAmt = json['price_amt'] ?? 0;
    _shareLink = json['share_link'] ?? '';
    _contentId = json['content_id'] ?? '';
    _createdAt = json['created_at'] ?? '';
    owned = json['owned'] ?? false;
  }
  String _id = '';
  int _no = 0;
  String _title = '';
  String _episodeFhd = '';
  String _episodeHd = '';
  String _episodeSd = '';
  String _altImgUrlFhd = '';
  String _altImgUrlHd = '';
  String _altImgUrlSd = '';
  String _thumbnailImgUrlFhd = '';
  String _thumbnailImgUrlHd = '';
  String _thumbnailImgUrlSd = '';
  String _priceAmt = '0';
  String _shareLink = '';
  String _contentId = '';
  String _createdAt = '';
  bool owned = false;

  int get cost
  {
    if (int.tryParse(priceAmt) == null)
    {
      if (kDebugMode) {
        print('price tryparse is null');
      }
      return 0;
    }

    return int.parse(priceAmt);
  }

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

  bool get isLock
  {
    //가격이있는데 구매한적이 없다.
    var result = cost != 0 && owned == false;
    return result;
  }

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