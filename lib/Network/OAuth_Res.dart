class OAuthRes
{
  String? id;
  String? userId;
  bool? fresh;
  String? expiresAt;

  OAuthRes.fromJson(dynamic json)
  {
    id = json['id'];
    userId = json['userId'];
    fresh = json['fresh'];
    expiresAt = json['expiresAt'];
  }

  Map<String, dynamic> toJson()
  {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userId'] = userId;
    map['fresh'] = fresh;
    map['expiresAt'] = expiresAt;
    return map;
  }
}