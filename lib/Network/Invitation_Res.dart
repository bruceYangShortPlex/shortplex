import 'package:flutter/foundation.dart';

/// data : {"info":[{"user_id":"ID115","referral_code":"MZAAVXLS","follower_user_cnt":"0","following_user_cnt":"0"}],"bonus":[]}

class InvitationRes
{
  InvitationRes.fromJson(dynamic json) {
    _data = json['data'] != null ? InvitationData.fromJson(json['data']) : null;
  }
  InvitationData? _data;

  InvitationData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    final _data = this._data;
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    return map;
  }

}

/// info : [{"user_id":"ID115","referral_code":"MZAAVXLS","follower_user_cnt":"0","following_user_cnt":"0"}]
/// bonus : []

class InvitationData
{
  InvitationData.fromJson(dynamic json) {
    if (json['info'] != null) {
      _info = [];
      json['info'].forEach((v) {
        _info?.add(InvitationInfo.fromJson(v));
      });
    }
  }
  List<InvitationInfo>? _info;
  List<dynamic>? _bonus;

  List<InvitationInfo>? get info => _info;
  List<dynamic>? get bonus => _bonus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    final _info = this._info;
    if (_info != null) {
      map['info'] = _info.map((v) => v.toJson()).toList();
    }
    if (_bonus != null) {
      if (kDebugMode) {
        print('receive bonus info');
      }
    }
    return map;
  }
}

/// user_id : "ID115"
/// referral_code : "MZAAVXLS"
/// follower_user_cnt : "0"
/// following_user_cnt : "0"

class InvitationInfo
{
  InvitationInfo.fromJson(dynamic json) {
    _userId = json['user_id'] ?? '';
    _referralCode = json['referral_code'] ?? '';
    _followerUserCnt = json['follower_user_cnt'] ?? '';
    _followingUserCnt = json['following_user_cnt'] ?? '';
    followingReferralCode = json['following_referral_code'] ?? '';
  }
  String _userId = '';
  String _referralCode = '';
  String _followerUserCnt = '';
  String _followingUserCnt = '';
  String followingReferralCode = '';

  String get userId => _userId;
  String get referralCode => _referralCode;
  String get followerUserCnt => _followerUserCnt;
  String get followingUserCnt => _followingUserCnt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['referral_code'] = _referralCode;
    map['follower_user_cnt'] = _followerUserCnt;
    map['following_user_cnt'] = _followingUserCnt;
    return map;
  }

}