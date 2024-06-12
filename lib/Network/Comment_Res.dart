/// data : [{"id":"CMT1","parent_id":null,"platform":"Quadra System","type_cd":"content","key":"CONT1","host":null,"path":null,"href":null,"slug":null,"user_id":null,"displayname":null,"photourl":null,"value":1,"content":"댓글달기","blocked":null,"created_at":"2024-06-11T15:58:49.385Z","updated_at":null,"replies":[{"id":"CMT3","user_id":null,"displayname":null,"photourl":null,"value":1,"content":"대댓글달기2 수정","blocked":null,"created_at":"2024-06-11T16:00:31.352881","updated_at":null}]},{"id":"CMT2","parent_id":null,"platform":"Quadra System","type_cd":"content","key":"CONT1","host":null,"path":null,"href":null,"slug":null,"user_id":null,"displayname":null,"photourl":null,"value":1,"content":"댓글달기2","blocked":null,"created_at":"2024-06-11T15:59:51.927Z","updated_at":null,"replies":[]},{"id":"CMT5","parent_id":null,"platform":"Quadra System","type_cd":"content","key":"CONT1","host":null,"path":null,"href":null,"slug":null,"user_id":null,"displayname":null,"photourl":null,"value":1,"content":"댓글달기3","blocked":null,"created_at":"2024-06-11T17:12:41.353Z","updated_at":null,"replies":[]}]

class CommentRes
{
  CommentRes({
      required List<CommentResData> data,}){
    _data = data;
}

  CommentRes.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CommentResData.fromJson(v));
      });
    }
  }
  List<CommentResData>? _data;
// CommentRes copyWith({  required List<CommentResData> data,
// }) => CommentRes(  data: _data ?? data,
// );
  List<CommentResData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class CommentResData {
  CommentResData({
      required String? id,
    required String? parentId,
      required String platform,
      required String typeCd,
      required String key,
    required String? host,
    required String? path,
    required String? href,
    required String? slug,
    required String? userId,
    required String? displayname,
    required String? photourl,
    required int value,
    required String? content,
    required bool blocked,
    required String? createdAt,
    required String? updatedAt,
    required  List<Replies>? replies,}){
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
    _replies = replies;
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
  List<Replies>? _replies;

  CommentResData.fromJson(dynamic json)
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
    _userId = json['user_id'];
    _displayname = json['displayname'];
    _photourl = json['photourl'];
    _value = json['value'];
    _content = json['content'];
    _blocked = json['blocked'] ?? false;
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['replies'] != null) {
      _replies = [];
      json['replies'].forEach((v) {
        _replies?.add(Replies.fromJson(v));
      });
    }
  }


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
  List<Replies>? get replies => _replies;

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
    if (_replies != null) {
      map['replies'] = _replies?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Replies {
  Replies({
      required String? id,
    required String? userId,
    required String? displayname,
    required String? photourl,
      required int value,
    required String? content,
     required bool blocked,
    required String? createdAt,
    required String? updatedAt,}){
    _id = id;
    _userId = userId;
    _displayname = displayname;
    _photourl = photourl;
    _value = value;
    _content = content;
    _blocked = blocked;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Replies.fromJson(dynamic json)
  {
    _id = json['id'];
    _userId = json['user_id'];
    _displayname = json['displayname'];
    _photourl = json['photourl'];
    _value = json['value'];
    _content = json['content'];
    _blocked = json['blocked'] ?? false;
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _userId;
  String? _displayname;
  String? _photourl;
  int _value = 0;
  String? _content;
  bool _blocked = false;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;
  String? get userId => _userId;
  String? get displayname => _displayname;
  String? get photourl => _photourl;
  int get value => _value;
  String? get content => _content;
  bool get blocked => _blocked;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['displayname'] = _displayname;
    map['photourl'] = _photourl;
    map['value'] = _value;
    map['content'] = _content;
    map['blocked'] = _blocked;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}