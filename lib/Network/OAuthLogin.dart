
class OAuthLogin {
  String? email;
  String? displayname;
  String? providerid;
  String? provideruserid;
  String? privacypolicies;
  String? photourl;
  String? platform;
  bool? emailverified;
  String? phonenumber;
  String? disabled;
  String? providerdata;
  String? customclaims;
  String? lastsignintime;
  String? tokensvalidaftertime;
  String? metadata;
  String? remark;

  OAuthLogin({
    this.email,
    this.displayname,
    this.providerid,
    this.provideruserid,
    this.privacypolicies,
    this.photourl,
    this.platform,
    this.emailverified,
    this.phonenumber,
    this.disabled,
    this.providerdata,
    this.customclaims,
    this.lastsignintime,
    this.tokensvalidaftertime,
    this.metadata,
    this.remark,
  });

  factory OAuthLogin.fromJson(Map<String, dynamic> json) => OAuthLogin
    (
        email: json["email"],
        displayname: json["kor"],
        providerid: json['providerid'],
        provideruserid: json['provideruserid'],
        privacypolicies: json['privacypolicies'],
        photourl: json['photourl'],
        platform: json['platform'],
        emailverified: json['emailverified'],
        phonenumber: json['phonenumber'],
        disabled: json['disabled'],
        providerdata: json['providerdata'],
        customclaims: json['customclaims'],
        lastsignintime: json['lastsignintime'],
        tokensvalidaftertime: json['tokensvalidaftertime'],
        metadata: json['metadata'],
        remark: json['remark'],
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['displayname'] = displayname;
    map['providerid'] = providerid;
    map['provideruserid'] = provideruserid;
    map['privacypolicies'] = privacypolicies;
    map['photourl'] = photourl;
    map['platform'] = platform;
    map['emailverified'] = emailverified;
    map['phonenumber'] = phonenumber;
    map['disabled'] = disabled;
    map['providerdata'] = providerdata;
    map['customclaims'] = customclaims;
    map['lastsignintime'] = lastsignintime;
    map['tokensvalidaftertime'] = tokensvalidaftertime;
    map['metadata'] = metadata;
    map['remark'] = remark;
    return map;
  }
}
