import 'Content_Res.dart';

/// data : {"count":2,"total":2,"itemsPerPage":20,"page":0,"max_page":0,"items":[{"id":"CONT1","title":"황후마마가 돌아왔다","subtitle":"#환생  #억울한 죽음  #복수  #사극","slug":"hwang-hu-ma-ma-ga-dor-a-wass-da","description":"사청과 부명수의 계략으로 억울한 죽음을 맞이한 사음, 환생 후 부명수와의 혼례 한 달 전으로 돌아오게 된다. 이번 생에서 과연 사음은 자신의 억울함을 풀고 복수할 수 있을까? 그리고 그녀를 진심으로 사랑한 북화국의 태자, 고경욱과 행복할 수 있을까?","teaser":null,"release_at":null,"restrain_at":null,"preview_yn":null,"preview_start_at":null,"genre":"로맨스, 시대물","tag":"시대극,총88화","share_link":"https://www.quadra-system.com/vod/preview/hwang-hu-ma-ma-ga-dor-a-wass-da","cover_img_url":null,"thumbnail_img_url":"https://storage.googleapis.com/quadra-content/thumbnails/CONT1-thumbnailimage-1719284551777.png","poster_landscape_img_url":"https://storage.googleapis.com/quadra-content/posters/CONT1-posterimagelandscape-1719195011378.jpeg","poster_portrait_img_url":"https://storage.googleapis.com/quadra-content/posters/CONT1-posterimageportrait-1719284548553.png","string_key":null,"weight":500,"featured":true,"topten":true,"favorites":"2","likes":"2","created_at":"2024-06-21T11:43:43.927Z","episode":{"id":"EP1","no":1,"title":"1회차","episode_fhd":"CONT1-EP1-fhd-1718938670101.mp4","episode_hd":"CONT1-EP1-hd-1718939818240.mp4","episode_sd":"CONT1-EP1-sd-1718939947791.mp4","alt_img_url_fhd":"https://storage.googleapis.com/quadra-content/altimages/CONT1-EP1-fhd-alt-1718938669037.png","alt_img_url_hd":"https://storage.googleapis.com/quadra-content/altimages/CONT1-EP1-hd-alt-1718939817770.png","alt_img_url_sd":"https://storage.googleapis.com/quadra-content/altimages/CONT1-EP1-sd-alt-1718939947437.png","thumbnail_img_url_fhd":"https://storage.googleapis.com/quadra-content/thumbnails/CONT1-EP1-fhd-thumbnail-1718938669891.png","thumbnail_img_url_hd":"https://storage.googleapis.com/quadra-content/thumbnails/CONT1-EP1-hd-thumbnail-1718939818071.png","thumbnail_img_url_sd":"https://storage.googleapis.com/quadra-content/thumbnails/CONT1-EP1-sd-thumbnail-1718939947651.png","price_amt":"3","share_link":null,"content_id":"CONT1","created_at":"2024-06-21T11:57:49.033Z"}},{"id":"CONT2","title":"아가씨의 수상한 보디가드","subtitle":null,"slug":"a-ga-ssi-eui-su-sang-han-bo-di-ga-deu","description":"심안심의 아버지는 실명한 딸을 위해 유명한 권투선수, 수기정을 찾아가 거액을 주며 딸의 보디가드가 되어 달라고 부탁하게 된다. 그러나 수기정의 절친한 친구인 기남천은 이 사실을 알고 본인이 대신 보디가드가 되기로 자처한다. 과연 그가 그녀에게 접근한 진짜 목적은 무엇일까?","teaser":null,"release_at":null,"restrain_at":null,"preview_yn":null,"preview_start_at":null,"genre":"재벌물, 복수극","tag":"재벌,복수,미스터리,도시","share_link":"https://www.quadra-system.com/vod/preview/a-ga-ssi-eui-su-sang-han-bo-di-ga-deu","cover_img_url":null,"thumbnail_img_url":"https://storage.googleapis.com/quadra-content/thumbnails/CONT2-thumbnailimage-1719284598838.png","poster_landscape_img_url":null,"poster_portrait_img_url":"https://storage.googleapis.com/quadra-content/posters/CONT2-posterimageportrait-1719284595942.png","string_key":null,"weight":500,"featured":true,"topten":true,"favorites":"0","likes":"0","created_at":"2024-06-21T13:25:52.243Z","episode":{"id":"EP11","no":1,"title":"1회차","episode_fhd":"CONT2-EP11-fhd-1718944121209.mp4","episode_hd":"CONT2-EP11-hd-1718944077875.mp4","episode_sd":"CONT2-EP11-sd-1718944190602.mp4","alt_img_url_fhd":"https://storage.googleapis.com/quadra-content/altimages/CONT2-EP11-fhd-alt-1718944120480.png","alt_img_url_hd":"https://storage.googleapis.com/quadra-content/altimages/CONT2-EP11-hd-alt-1718944077273.png","alt_img_url_sd":"https://storage.googleapis.com/quadra-content/altimages/CONT2-EP11-sd-alt-1718944190241.png","thumbnail_img_url_fhd":"https://storage.googleapis.com/quadra-content/thumbnails/CONT2-EP11-fhd-thumbnail-1718944120994.png","thumbnail_img_url_hd":"https://storage.googleapis.com/quadra-content/thumbnails/CONT2-EP11-hd-thumbnail-1718944077706.png","thumbnail_img_url_sd":"https://storage.googleapis.com/quadra-content/thumbnails/CONT2-EP11-sd-thumbnail-1718944190463.png","price_amt":"3","share_link":null,"content_id":"CONT2","created_at":"2024-06-21T13:27:57.269Z"}}]}

class RecommendedRes
{
  RecommendedRes({
     required RecommendedData data,}){
    _data = data;
}

  RecommendedRes.fromJson(dynamic json) {
    _data = (json['data'] != null ? RecommendedData.fromJson(json['data']) : null)!;
  }
  RecommendedData? _data;

  RecommendedData? get data => _data;
}

class RecommendedData
{
  RecommendedData.fromJson(dynamic json) {
    _count = json['count'];
    _total = json['total'];
    _itemsPerPage = json['itemsPerPage'];
    _page = json['page'];
    _maxPage = json['max_page'];
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(RecommendedContentData.fromJson(v));
      });
    }
  }
  int _count = 0;
  int _total = 0;
  int _itemsPerPage = 0;
  int _page = 0;
  int _maxPage = 0;
  List<RecommendedContentData>? _items;

  num get count => _count;
  num get total => _total;
  num get itemsPerPage => _itemsPerPage;
  num get page => _page;
  num get maxPage => _maxPage;
  List<RecommendedContentData>? get items => _items;
}

class RecommendedContentData {

  RecommendedContentData.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _subtitle = json['subtitle'];
    _slug = json['slug'];
    _description = json['description'] ?? '';
    _teaser = json['teaser'];
    _releaseAt = json['release_at'];
    _restrainAt = json['restrain_at'];
    _previewYn = json['preview_yn'] ?? false;
    _previewStartAt = json['preview_start_at'];
    _genre = json['genre_cd'];
    _tag = json['tag'];
    _shareLink = json['share_link'] ?? '';
    _coverImgUrl = json['cover_img_url'];
    _thumbnailImgUrl = json['thumbnail_img_url'] ?? '';
    _posterLandscapeImgUrl = json['poster_landscape_img_url'];
    _posterPortraitImgUrl = json['poster_portrait_img_url'];
    _stringKey = json['string_key'];
    _weight = json['weight'] ?? 0;
    _featured = json['featured'] ?? false;
    _topten = json['topten'] ?? false;
    _createdAt = json['created_at'];
    _episodeTotal = json['episode_total'] ?? 0;
    _episodeMaxpage = json['episode_maxpage'] ?? 0;
    if (json['stat'] != null) {
      _stat = [];
      json['stat'].forEach((v) {
        _stat?.add(Stat.fromJson(v));
      });
    }
    if (json['episode'] != null)
    {
      _episode = Episode.fromJson(json['episode']);
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
  bool _topten = false;
  String? _createdAt;
  int _episodeTotal = 0;
  int _episodeMaxpage = 0;
  List<Stat>? _stat;
  Episode? _episode;

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
  bool get topten => _topten;
  String? get createdAt => _createdAt;
  int get episodeTotal => _episodeTotal;
  int get episodeMaxpage => _episodeMaxpage;
  List<Stat>? get stat => _stat;
  Episode? get episode => _episode;
}
