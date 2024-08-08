
class OAuthLogin
{
  String? email;
  String? displayname;
  String providerid ='google';
  String? provideruserid;
  String? privacypolicies;
  String? photourl;
  String platform = 'shortplex';

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

  Map<String, dynamic> toJson()
  {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['displayname'] = displayname;
    map['providerid'] = providerid;
    map['provideruserid'] = provideruserid;
    map['privacypolicies'] = privacypolicies;
    map['photourl'] = photourl;
    map['platform'] = platform;
    return map;
  }
}

class Logout
{
  String _email = '';
  String _password = '';
  String _username = '';

  Logout({required String email,required String password,required String username,})
  {
    _email = email;
    _password = password;
    _username = username;
  }

  Logout.fromJson(dynamic json)
  {
    _email = json['email'];
    _password = json['password'];
    _username = json['username'];
  }

  Logout copyWith({  required String email,
    required String password,
    required String username,
  }) => Logout(  email: email ?? _email,
    password: password ?? _password,
    username: username ?? _username,
  );

  String get email => _email;
  String get password => _password;
  String get username => _username;

  Map<String, dynamic> toJson()
  {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['password'] = _password;
    map['username'] = _username;
    return map;
  }
}
