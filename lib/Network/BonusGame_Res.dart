/// data : {"count":0,"total":0,"itemsPerPage":20,"page":0,"max_page":0,"items":[{"id":"PCNZ2","user_id":"ID112","condition":40,"condition_sum":340,"bonus":null,"percentage":null},{"id":"PCNZ3","user_id":"ID112","condition":80,"condition_sum":340,"bonus":null,"percentage":null},null],"prize":{"20":[{"bonus":2,"percentage":"5%"},{"bonus":4,"percentage":"10%"},{"bonus":6,"percentage":"10%"},{"bonus":8,"percentage":"15%"},{"bonus":10,"percentage":"15%"},{"bonus":20,"percentage":"20%"},{"bonus":30,"percentage":"15%"},{"bonus":40,"percentage":"10%"}],"60":[{"bonus":4,"percentage":"10%"},{"bonus":8,"percentage":"10%"},{"bonus":12,"percentage":"15%"},{"bonus":16,"percentage":"15%"},{"bonus":20,"percentage":"20%"},{"bonus":40,"percentage":"15%"},{"bonus":60,"percentage":"10%"},{"bonus":80,"percentage":"5%"}],"140":[{"bonus":8,"percentage":"20%"},{"bonus":16,"percentage":"20%"},{"bonus":24,"percentage":"20%"},{"bonus":32,"percentage":"15%"},{"bonus":40,"percentage":"15%"},{"bonus":80,"percentage":"6%"},{"bonus":120,"percentage":"3%"},{"bonus":160,"percentage":"1%"}],"340":[{"bonus":20,"percentage":"40%"},{"bonus":40,"percentage":"40%"},{"bonus":60,"percentage":"10%"},{"bonus":80,"percentage":"5%"},{"bonus":100,"percentage":"3%"},{"bonus":200,"percentage":"1%"},{"bonus":300,"percentage":"0.7%"},{"bonus":400,"percentage":"0.3%"}]},"expired_at":"2024-07-30T11:09:48.466Z"}

class BonusGameRes
{
  BonusGameRes.fromJson(dynamic json) {
    _data = json['data'] != null ? BonusGameData.fromJson(json['data']) : null;
  }

  BonusGameData? _data;
  BonusGameData? get data => _data;
}

/// count : 0
/// total : 0
/// itemsPerPage : 20
/// page : 0
/// max_page : 0
/// items : [{"id":"PCNZ2","user_id":"ID112","condition":40,"condition_sum":340,"bonus":null,"percentage":null},{"id":"PCNZ3","user_id":"ID112","condition":80,"condition_sum":340,"bonus":null,"percentage":null},null]
/// prize : {"20":[{"bonus":2,"percentage":"5%"},{"bonus":4,"percentage":"10%"},{"bonus":6,"percentage":"10%"},{"bonus":8,"percentage":"15%"},{"bonus":10,"percentage":"15%"},{"bonus":20,"percentage":"20%"},{"bonus":30,"percentage":"15%"},{"bonus":40,"percentage":"10%"}],"60":[{"bonus":4,"percentage":"10%"},{"bonus":8,"percentage":"10%"},{"bonus":12,"percentage":"15%"},{"bonus":16,"percentage":"15%"},{"bonus":20,"percentage":"20%"},{"bonus":40,"percentage":"15%"},{"bonus":60,"percentage":"10%"},{"bonus":80,"percentage":"5%"}],"140":[{"bonus":8,"percentage":"20%"},{"bonus":16,"percentage":"20%"},{"bonus":24,"percentage":"20%"},{"bonus":32,"percentage":"15%"},{"bonus":40,"percentage":"15%"},{"bonus":80,"percentage":"6%"},{"bonus":120,"percentage":"3%"},{"bonus":160,"percentage":"1%"}],"340":[{"bonus":20,"percentage":"40%"},{"bonus":40,"percentage":"40%"},{"bonus":60,"percentage":"10%"},{"bonus":80,"percentage":"5%"},{"bonus":100,"percentage":"3%"},{"bonus":200,"percentage":"1%"},{"bonus":300,"percentage":"0.7%"},{"bonus":400,"percentage":"0.3%"}]}
/// expired_at : "2024-07-30T11:09:48.466Z"

class BonusGameData
{
  BonusGameData.fromJson(dynamic json)
  {
    _count = json['count'] ?? 0;
    //print('BonusGameData 1');
    _total = json['total'] ?? 0;
    //print('BonusGameData 2');
    _itemsPerPage = json['itemsPerPage'] ?? 0;
    //print('BonusGameData 3');
    _page = json['page'] ?? 0;
    //print('BonusGameData 4');
    _maxPage = json['max_page'] ?? 0;
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(BonusItems.fromJson(v));
      });
    }
    _prize = json['prize'] != null ? Prize.fromJson(json['prize']) : null;
    _expiredAt = json['expired_at'] ?? '';
  }
  int _count = 0;
  int _total = 0;
  int _itemsPerPage = 0;
  int _page = 0;
  int _maxPage = 0;
  List<BonusItems>? _items;
  Prize? _prize;
  String _expiredAt = '';

  int get count => _count;
  int get total => _total;
  int get itemsPerPage => _itemsPerPage;
  int get page => _page;
  int get maxPage => _maxPage;
  List<BonusItems>? get items => _items;
  Prize? get prize => _prize;
  String get expiredAt => _expiredAt;
}

/// 20 : [{"bonus":2,"percentage":"5%"},{"bonus":4,"percentage":"10%"},{"bonus":6,"percentage":"10%"},{"bonus":8,"percentage":"15%"},{"bonus":10,"percentage":"15%"},{"bonus":20,"percentage":"20%"},{"bonus":30,"percentage":"15%"},{"bonus":40,"percentage":"10%"}]
/// 60 : [{"bonus":4,"percentage":"10%"},{"bonus":8,"percentage":"10%"},{"bonus":12,"percentage":"15%"},{"bonus":16,"percentage":"15%"},{"bonus":20,"percentage":"20%"},{"bonus":40,"percentage":"15%"},{"bonus":60,"percentage":"10%"},{"bonus":80,"percentage":"5%"}]
/// 140 : [{"bonus":8,"percentage":"20%"},{"bonus":16,"percentage":"20%"},{"bonus":24,"percentage":"20%"},{"bonus":32,"percentage":"15%"},{"bonus":40,"percentage":"15%"},{"bonus":80,"percentage":"6%"},{"bonus":120,"percentage":"3%"},{"bonus":160,"percentage":"1%"}]
/// 340 : [{"bonus":20,"percentage":"40%"},{"bonus":40,"percentage":"40%"},{"bonus":60,"percentage":"10%"},{"bonus":80,"percentage":"5%"},{"bonus":100,"percentage":"3%"},{"bonus":200,"percentage":"1%"},{"bonus":300,"percentage":"0.7%"},{"bonus":400,"percentage":"0.3%"}]

class Prize {

  Prize.fromJson(dynamic json) {
    if (json['20'] != null) {
      step1 = [];
      json['20'].forEach((v)
      {
        step1?.add(BonusTableData.fromJson(v));
      });
    }
    if (json['60'] != null) {
      step2 = [];
      json['60'].forEach((v) {
        step2?.add(BonusTableData.fromJson(v));
      });
    }
    if (json['140'] != null) {
      step3 = [];
      json['140'].forEach((v) {
        step3?.add(BonusTableData.fromJson(v));
      });
    }
    if (json['340'] != null) {
      step4 = [];
      json['340'].forEach((v) {
        step4?.add(BonusTableData.fromJson(v));
      });
    }
  }

  List<BonusTableData>? step1;
  List<BonusTableData>? step2;
  List<BonusTableData>? step3;
  List<BonusTableData>? step4;
}

/// bonus : 20
/// percentage : "40%"

class BonusTableData
{
  BonusTableData.fromJson(dynamic json) {
    _bonus = json['bonus'] ?? 0;
    _percentage = json['percentage'] ?? '';
  }

  int _bonus = 0;
  String _percentage = '';

  num get bonus => _bonus;
  String get percentage => _percentage;
}

class BonusItems
{
  BonusItems.fromJson(dynamic json)
  {
    //print('BonusGameData 5');
    _id = json['id'] ?? '';
    //print('BonusGameData 6');
    _userId = json['user_id'] ?? '';
    //print('BonusGameData 7');
    _condition = json['condition'] ?? 0;
    //print('BonusGameData 8');
    _conditionSum = json['condition_sum'] ?? 0;
    //print('BonusGameData 9');
    _bonus = json['bonus'] ?? '';
    //print('BonusGameData 10');
    _percentage = json['percentage'] ?? '';
    //print('BonusGameData 11');
  }

  String _id = '';
  String _userId = '';
  int _condition = 0;
  int _conditionSum = 0;
  String _bonus = '';
  String _percentage = '';

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
  String get percentage => _percentage;

  Map<String, dynamic> toJson()
  {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['condition'] = _condition;
    map['condition_sum'] = _conditionSum;
    map['bonus'] = _bonus;
    map['percentage'] = _percentage;
    return map;
  }
}