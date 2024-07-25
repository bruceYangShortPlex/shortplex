/// data : {"items":[{"id":"MI1","name":"영상 1회 공유하기","description":null,"is_active":true,"visibility":true,"id_cd":"70001","name_cd":"300016","group_no":0,"rewardicon":"50001","max_cnt":1,"reward_type":"2","amount":1},{"id":"MI2","name":"유료 콘텐츠 5편 잠금해제(1/3)","description":null,"is_active":true,"visibility":true,"id_cd":"70002","name_cd":"300017","group_no":1,"rewardicon":"50001","max_cnt":5,"reward_type":"2","amount":1},{"id":"MI3","name":"유료 콘텐츠 10편 잠금해제(2/3)","description":null,"is_active":true,"visibility":true,"id_cd":"70003","name_cd":"300018","group_no":1,"rewardicon":"50004","max_cnt":15,"reward_type":"2","amount":3},{"id":"MI4","name":"유료 콘텐츠 20편 잠금해제(3/3)","description":null,"is_active":true,"visibility":true,"id_cd":"70004","name_cd":"300019","group_no":1,"rewardicon":"50004","max_cnt":30,"reward_type":"2","amount":5},{"id":"MI5","name":"제목학원 댓글 좋아요 누르기","description":null,"is_active":true,"visibility":true,"id_cd":"70005","name_cd":"300020","group_no":0,"rewardicon":"50001","max_cnt":1,"reward_type":"2","amount":1},{"id":"MI6","name":"광고상품 1개 구매하기","description":null,"is_active":true,"visibility":true,"id_cd":"70006","name_cd":"300021","group_no":0,"rewardicon":"50005","max_cnt":1,"reward_type":"2","amount":10},{"id":"MI7","name":"공개예정 추천 알림 받기","description":null,"is_active":true,"visibility":true,"id_cd":"70007","name_cd":"300022","group_no":0,"rewardicon":"50004","max_cnt":1,"reward_type":"2","amount":2},{"id":"MI8","name":"광고 시청 1회(1/3)","description":null,"is_active":true,"visibility":true,"id_cd":"70008","name_cd":"300023","group_no":2,"rewardicon":"50001","max_cnt":1,"reward_type":"2","amount":1},{"id":"MI9","name":"광고 시청 2회(2/3)","description":null,"is_active":true,"visibility":true,"id_cd":"70009","name_cd":"300024","group_no":2,"rewardicon":"50001","max_cnt":2,"reward_type":"2","amount":1},{"id":"MI10","name":"광고 시청 3회(3/3)","description":null,"is_active":true,"visibility":true,"id_cd":"70010","name_cd":"300025","group_no":2,"rewardicon":"50001","max_cnt":3,"reward_type":"2","amount":1},{"id":"MI11","name":"제목학원 댓글 작성하기","description":null,"is_active":true,"visibility":true,"id_cd":"70011","name_cd":"300052","group_no":0,"rewardicon":"50004","max_cnt":1,"reward_type":"2","amount":2}]}

class MissionRes
{


  MissionRes.fromJson(dynamic json) {
    _data = json['data'] != null ? MissionData.fromJson(json['data']) : null;
  }
  MissionData? _data;

  MissionData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    final _data = this._data;
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    return map;
  }

}

/// items : [{"id":"MI1","name":"영상 1회 공유하기","description":null,"is_active":true,"visibility":true,"id_cd":"70001","name_cd":"300016","group_no":0,"rewardicon":"50001","max_cnt":1,"reward_type":"2","amount":1},{"id":"MI2","name":"유료 콘텐츠 5편 잠금해제(1/3)","description":null,"is_active":true,"visibility":true,"id_cd":"70002","name_cd":"300017","group_no":1,"rewardicon":"50001","max_cnt":5,"reward_type":"2","amount":1},{"id":"MI3","name":"유료 콘텐츠 10편 잠금해제(2/3)","description":null,"is_active":true,"visibility":true,"id_cd":"70003","name_cd":"300018","group_no":1,"rewardicon":"50004","max_cnt":15,"reward_type":"2","amount":3},{"id":"MI4","name":"유료 콘텐츠 20편 잠금해제(3/3)","description":null,"is_active":true,"visibility":true,"id_cd":"70004","name_cd":"300019","group_no":1,"rewardicon":"50004","max_cnt":30,"reward_type":"2","amount":5},{"id":"MI5","name":"제목학원 댓글 좋아요 누르기","description":null,"is_active":true,"visibility":true,"id_cd":"70005","name_cd":"300020","group_no":0,"rewardicon":"50001","max_cnt":1,"reward_type":"2","amount":1},{"id":"MI6","name":"광고상품 1개 구매하기","description":null,"is_active":true,"visibility":true,"id_cd":"70006","name_cd":"300021","group_no":0,"rewardicon":"50005","max_cnt":1,"reward_type":"2","amount":10},{"id":"MI7","name":"공개예정 추천 알림 받기","description":null,"is_active":true,"visibility":true,"id_cd":"70007","name_cd":"300022","group_no":0,"rewardicon":"50004","max_cnt":1,"reward_type":"2","amount":2},{"id":"MI8","name":"광고 시청 1회(1/3)","description":null,"is_active":true,"visibility":true,"id_cd":"70008","name_cd":"300023","group_no":2,"rewardicon":"50001","max_cnt":1,"reward_type":"2","amount":1},{"id":"MI9","name":"광고 시청 2회(2/3)","description":null,"is_active":true,"visibility":true,"id_cd":"70009","name_cd":"300024","group_no":2,"rewardicon":"50001","max_cnt":2,"reward_type":"2","amount":1},{"id":"MI10","name":"광고 시청 3회(3/3)","description":null,"is_active":true,"visibility":true,"id_cd":"70010","name_cd":"300025","group_no":2,"rewardicon":"50001","max_cnt":3,"reward_type":"2","amount":1},{"id":"MI11","name":"제목학원 댓글 작성하기","description":null,"is_active":true,"visibility":true,"id_cd":"70011","name_cd":"300052","group_no":0,"rewardicon":"50004","max_cnt":1,"reward_type":"2","amount":2}]

class MissionData {

  MissionData.fromJson(dynamic json) {
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(MissionItems.fromJson(v));
      });
    }
  }
  List<MissionItems>? _items;
  List<MissionItems>? get items => _items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    final _items = this._items;
    if (_items != null) {
      map['items'] = _items.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "MI1"
/// name : "영상 1회 공유하기"
/// description : null
/// is_active : true
/// visibility : true
/// id_cd : "70001"
/// name_cd : "300016"
/// group_no : 0
/// rewardicon : "50001"
/// max_cnt : 1
/// reward_type : "2"
/// amount : 1

class MissionItems
{
  MissionItems.fromJson(dynamic json) {
    _id = json['id'] ?? '';
    _name = json['name'] ?? '';
    _description = json['description'] ?? '';
    _isActive = json['is_active'] ?? false;
    _visibility = json['visibility'] ?? false;
    _idCd = json['id_cd'] ?? '';
    _nameCd = json['name_cd'] ?? '';
    _groupNo = json['group_no'] ?? 0;
    _rewardicon = json['rewardicon'] ?? '';
    _maxCnt = json['max_cnt'] ?? 0;
    _rewardType = json['reward_type'] ?? '';
    _amount = json['amount'] ?? 0;
    userID = json['usr_id'] ?? '';
    mission_cnt = json['mission_cnt'] ?? 0;
  }

  String _id = '';
  String _name = '';
  String _description = '';
  bool _isActive = false;
  bool _visibility = false;
  String _idCd = '';
  String _nameCd = '';
  num _groupNo = 0;
  String _rewardicon = '';
  int _maxCnt = 1;
  String _rewardType = '';
  int _amount = 0;
  String userID = '';
  int mission_cnt = 0;

  String get id => _id;
  String get name => _name;
  String get description => _description;
  bool get isActive => _isActive;
  bool get visibility => _visibility;
  String get idCd => _idCd;
  String get nameCd => _nameCd;
  num get groupNo => _groupNo;
  String get rewardicon => _rewardicon;
  num get maxCnt => _maxCnt;
  String get rewardType => _rewardType;
  num get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['is_active'] = _isActive;
    map['visibility'] = _visibility;
    map['id_cd'] = _idCd;
    map['name_cd'] = _nameCd;
    map['group_no'] = _groupNo;
    map['rewardicon'] = _rewardicon;
    map['max_cnt'] = _maxCnt;
    map['reward_type'] = _rewardType;
    map['amount'] = _amount;
    return map;
  }

}