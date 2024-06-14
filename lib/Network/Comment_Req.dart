/// parent_id : null
/// type_cd : "content"
/// content : "댓글달기3"

class CommentReq
{
  CommentReq
  (
    {
    required String? parentId,
    required String? typeCd,
    required String? content,
    }
    )
  {
    _parentId = parentId;
    _typeCd = typeCd;
    _content = content;
  }

  CommentReq.fromJson(dynamic json) {
    _parentId = json['parent_id'];
    _typeCd = json['type_cd'];
    _content = json['content'];
  }
  String? _parentId;
  String? _typeCd;
  String? _content;

  String? get parentId => _parentId;
  String? get typeCd => _typeCd;
  String? get content => _content;

  Map<String, dynamic> toJson()
  {
    final map = <String, dynamic>{};
    map['parent_id'] = _parentId;
    map['type_cd'] = _typeCd;
    map['content'] = _content;
    return map;
  }

}