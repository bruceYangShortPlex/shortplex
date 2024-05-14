
class OAuthLogin
{
  String? email;
  String? displayname;
  String? providerid ='google';
  String? provideruserid;
  String? privacypolicies;
  String? photourl;

  OAuthLogin({
    required this.email,
    required this.displayname,
    required this.providerid,
    required this.provideruserid,
    required this.privacypolicies,
    required this.photourl,
  });

  factory OAuthLogin.fromJson(Map<String, dynamic> json) => OAuthLogin
  (
    email: json["email"],
    displayname: json["kor"],
    providerid: json['providerid'],
    provideruserid: json['provideruserid'],
    privacypolicies: json['privacypolicies'],
    photourl: json['photourl'],
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['displayname'] = displayname;
    map['providerid'] = providerid;
    map['provideruserid'] = provideruserid;
    map['privacypolicies'] = privacypolicies;
    map['photourl'] = photourl;
    return map;
  }
}
