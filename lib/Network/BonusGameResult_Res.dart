class BonusGameResultRes
{
  BonusGameResultRes({
    required String seq,
    required String id,
    required String userID,
    required int condition,
    required int conditionSum,
    required String bonus,
    required String rate,
    required String percentage,
  })
  {
    _seq = seq;
    _id = id;
    _condition = condition;
    _conditionSum = conditionSum;
    _bonus = bonus;
    _rate = rate;
    _percentage = percentage;
    _userId = userID;
  }

  BonusGameResultRes.fromJson(dynamic json)
  {
    _seq = json['seq'] ?? '';
    //print(1);
    _id = json['id'] ?? '';
    //print(2);
    _userId = json['user_id'] ?? '';
    //print(3);
    _condition = json['condition'] ?? 0;
    // //print(4);
    _conditionSum = json['condition_sum'] ?? 0;
    //print(5);
    _bonus = json['bonus'] ?? '';
    //print(6);
    _rate = json['rate'] ?? '';
    //print(7);
    _percentage = json['percentage'] ?? '';
    //print(8);
    _createdAt = json['created_at'] ?? '';
    //print(9);
    _createdBy = json['created_by'] ?? '';
    //print(10);
    _updatedAt = json['updated_at'] ?? '';
    //print(11);
    _updatedBy = json['updated_by'] ?? '';
    //print(12);
    _deletedAt = json['deleted_at'] ?? '';
    //print(13);
    _deletedBy = json['deleted_by'] ?? '';
    //print(14);
    _remark = json['remark'] ?? '';
    //print(15);
  }

  String _seq = '';
  String _id = '';
  String _userId = '';
  int _condition = 80;
  int _conditionSum = 140;
  String _bonus = '';
  String _rate = '';
  String _percentage = '';
  String _createdAt = '';
  String _createdBy = '';
  String _updatedAt = '';
  String _updatedBy = '';
  String _deletedAt = '';
  String _deletedBy = '';
  String _remark = '';

  String get seq => _seq;
  String get id => _id;
  String get userId => _userId;
  int get condition => _condition;
  int get conditionSum => _conditionSum;
  int get bonus
  {
    int r = 0;
    String b = _bonus.split('.')[0];

    if (int.tryParse(b) != null)
    {
      r = int.parse(b);
    }

    return r;
  }

  String get rate => _rate;
  String get percentage => _percentage;
  String get createdAt => _createdAt;
  String get createdBy => _createdBy;
  String get updatedAt => _updatedAt;
  String get updatedBy => _updatedBy;
  String get deletedAt => _deletedAt;
  String get deletedBy => _deletedBy;
  String get remark => _remark;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['seq'] = _seq;
    map['id'] = _id;
    map['user_id'] = _userId;
    map['condition'] = _condition;
    map['condition_sum'] = _conditionSum;
    map['bonus'] = _bonus;
    map['rate'] = _rate;
    map['percentage'] = _percentage;
    map['created_at'] = _createdAt;
    map['created_by'] = _createdBy;
    map['updated_at'] = _updatedAt;
    map['updated_by'] = _updatedBy;
    map['deleted_at'] = _deletedAt;
    map['deleted_by'] = _deletedBy;
    map['remark'] = _remark;
    return map;
  }

}