/// data : {"count":5,"total":5,"itemsPerPage":20,"page":0,"max_page":0,"items":[{"id":"CMT1","parent_id":null,"platform":"Quadra System","type_cd":"content","key":"CONT1","host":null,"path":null,"href":null,"slug":null,"user_id":null,"displayname":null,"photourl":null,"value":1,"content":"댓글달기","blocked":null,"created_at":"2024-06-11T15:58:49.385Z","updated_at":null,"likes":"0","replies":"3"},{"id":"CMT2","parent_id":null,"platform":"Quadra System","type_cd":"content","key":"CONT1","host":null,"path":null,"href":null,"slug":null,"user_id":null,"displayname":null,"photourl":null,"value":1,"content":"댓글달기2","blocked":null,"created_at":"2024-06-11T15:59:51.927Z","updated_at":null,"likes":"0","replies":"0"},{"id":"CMT20","parent_id":null,"platform":"Quadra System","type_cd":"content","key":"CONT1","host":null,"path":null,"href":null,"slug":null,"user_id":null,"displayname":null,"photourl":null,"value":1,"content":"댓글달기3","blocked":null,"created_at":"2024-06-13T16:14:36.584Z","updated_at":null,"likes":"0","replies":"0"},{"id":"CMT5","parent_id":null,"platform":"Quadra System","type_cd":"content","key":"CONT1","host":null,"path":null,"href":null,"slug":null,"user_id":null,"displayname":null,"photourl":null,"value":1,"content":"댓글달기3","blocked":null,"created_at":"2024-06-11T17:12:41.353Z","updated_at":null,"likes":"0","replies":"0"},{"id":"CMT6","parent_id":null,"platform":"Quadra System","type_cd":"content","key":"CONT1","host":null,"path":null,"href":null,"slug":null,"user_id":null,"displayname":null,"photourl":null,"value":1,"content":"댓글달기3","blocked":null,"created_at":"2024-06-13T11:21:34.897Z","updated_at":null,"likes":"0","replies":"0"}]}

class CommentRes
{
  CommentRes({
    required CommentResData data,}){
    _data = data;
  }

  CommentRes.fromJson(dynamic json) {
    _data = json['data'] != null ? CommentResData.fromJson(json['data']) : null;
  }
  CommentResData? _data;
  CommentResData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// count : 5
/// total : 5
/// itemsPerPage : 20
/// page : 0
/// max_page : 0
/// items : [{"id":"CMT1","parent_id":null,"platform":"Quadra System","type_cd":"content","key":"CONT1","host":null,"path":null,"href":null,"slug":null,"user_id":null,"displayname":null,"photourl":null,"value":1,"content":"댓글달기","blocked":null,"created_at":"2024-06-11T15:58:49.385Z","updated_at":null,"likes":"0","replies":"3"},{"id":"CMT2","parent_id":null,"platform":"Quadra System","type_cd":"content","key":"CONT1","host":null,"path":null,"href":null,"slug":null,"user_id":null,"displayname":null,"photourl":null,"value":1,"content":"댓글달기2","blocked":null,"created_at":"2024-06-11T15:59:51.927Z","updated_at":null,"likes":"0","replies":"0"},{"id":"CMT20","parent_id":null,"platform":"Quadra System","type_cd":"content","key":"CONT1","host":null,"path":null,"href":null,"slug":null,"user_id":null,"displayname":null,"photourl":null,"value":1,"content":"댓글달기3","blocked":null,"created_at":"2024-06-13T16:14:36.584Z","updated_at":null,"likes":"0","replies":"0"},{"id":"CMT5","parent_id":null,"platform":"Quadra System","type_cd":"content","key":"CONT1","host":null,"path":null,"href":null,"slug":null,"user_id":null,"displayname":null,"photourl":null,"value":1,"content":"댓글달기3","blocked":null,"created_at":"2024-06-11T17:12:41.353Z","updated_at":null,"likes":"0","replies":"0"},{"id":"CMT6","parent_id":null,"platform":"Quadra System","type_cd":"content","key":"CONT1","host":null,"path":null,"href":null,"slug":null,"user_id":null,"displayname":null,"photourl":null,"value":1,"content":"댓글달기3","blocked":null,"created_at":"2024-06-13T11:21:34.897Z","updated_at":null,"likes":"0","replies":"0"}]

class CommentResData {
  CommentResData({
    required int count,
    required int total,
    required int itemsPerPage,
    required int page,
    required int maxPage,
    required List<CommentItems>? items,}){
    _count = count;
    _total = total;
    _itemsPerPage = itemsPerPage;
    _page = page;
    _maxPage = maxPage;
    _items = items;
  }

  CommentResData.fromJson(dynamic json) {
    _count = json['count'] ?? 0;
    _total = json['total'] ?? 0;
    _itemsPerPage = json['itemsPerPage'] ?? 0;
    _page = json['page'] ?? 0;
    _maxPage = json['max_page'] ?? 0;
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(CommentItems.fromJson(v));
      });
    }
  }
  int _count = 0;
  int _total = 0;
  int _itemsPerPage = 0;
  int _page = 0;
  int _maxPage = 0;
  List<CommentItems>? _items;

  int get count => _count;
  int get total => _total;
  int get itemsPerPage => _itemsPerPage;
  int get page => _page;
  int get maxPage => _maxPage;
  List<CommentItems>? get items => _items;

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

/// id : "CMT1"
/// parent_id : null
/// platform : "Quadra System"
/// type_cd : "content"
/// key : "CONT1"
/// host : null
/// path : null
/// href : null
/// slug : null
/// user_id : null
/// displayname : null
/// photourl : null
/// value : 1
/// content : "댓글달기"
/// blocked : null
/// created_at : "2024-06-11T15:58:49.385Z"
/// updated_at : null
/// likes : "0"
/// replies : "3"

class CommentItems {
  CommentItems({
    required String id,
    required String parentId,
    required String platform,
    required String typeCd,
    required String key,
    required String host,
    required String path,
    required String href,
    required String slug,
    required String userId,
    required String displayname,
    required String photourl,
    required int value,
    required String content,
    required bool blocked,
    required String createdAt,
    required String updatedAt,
    required String likes,
    required String replies,}){
    _id = id;
    _parentId = parentId;
    _platform = platform;
    _typeCd = typeCd;
    _key = key;
    _host = host;
    _path = path;
    _href = href;
    _slug = slug;
    _userId = userId;
    _displayname = displayname;
    _photourl = photourl;
    _value = value;
    _content = content;
    _blocked = blocked;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _likes = likes;
    _replies = replies;
  }

  CommentItems.fromJson(dynamic json)
  {
    _id = json['id'];
    _parentId = json['parent_id'];
    _platform = json['platform'];
    _typeCd = json['type_cd'];
    _key = json['key'];
    _host = json['host'];
    _path = json['path'];
    _href = json['href'];
    _slug = json['slug'];
    _userId = json['user_id'] ?? '';
    _displayname = json['displayname'] ?? '';
    _photourl = json['photourl'] ?? '';
    _value = json['value'] ?? 0;
    _content = json['content'];
    _blocked = json['blocked'] ?? false;
    _createdAt = json['created_at'] ?? '';
    _updatedAt = json['updated_at'] ?? '';
    _likes = json['likes'] ?? '0';
    _replies = json['replies'] ?? '0';
    whoami = json['whoami'] ?? '';
    rank =  json['rank'] != null ? int.parse(json['rank']) : 100;
    episode_no =  json['episode_no'] != null ? int.parse(json['rank']) : 0;
    ilike =  json['ilike'] != null ? int.parse(json['ilike']) : 0;
  }
  String? _id;
  String? _parentId;
  String? _platform;
  String? _typeCd;
  String? _key;
  String? _host;
  String? _path;
  String? _href;
  String? _slug;
  String? _userId;
  String? _displayname;
  String? _photourl;
  int _value = 0;
  String? _content;
  bool _blocked = false;
  String? _createdAt;
  String? _updatedAt;
  String? _likes;
  String? _replies;
  int rank = 100;
  int episode_no = 0;
  String? whoami;
  int ilike = 0;

  String? get id => _id;
  String? get parentId => _parentId;
  String? get platform => _platform;
  String? get typeCd => _typeCd;
  String? get key => _key;
  String? get host => _host;
  String? get path => _path;
  String? get href => _href;
  String? get slug => _slug;
  String? get userId => _userId;
  String? get displayname => _displayname;
  String? get photourl => _photourl;
  int get value => _value;
  String? get content => _content;
  bool get blocked => _blocked;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get likes => _likes;
  String? get replies => _replies;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['parent_id'] = _parentId;
    map['platform'] = _platform;
    map['type_cd'] = _typeCd;
    map['key'] = _key;
    map['host'] = _host;
    map['path'] = _path;
    map['href'] = _href;
    map['slug'] = _slug;
    map['user_id'] = _userId;
    map['displayname'] = _displayname;
    map['photourl'] = _photourl;
    map['value'] = _value;
    map['content'] = _content;
    map['blocked'] = _blocked;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['likes'] = _likes;
    map['replies'] = _replies;
    return map;
  }

}