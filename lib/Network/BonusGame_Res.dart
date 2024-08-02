/// data : {"count":0,"total":0,"itemsPerPage":20,"page":0,"max_page":0,"items":[{"id":"PCNZ2","user_id":"ID112","condition":40,"condition_sum":340,"bonus":null,"percentage":null},{"id":"PCNZ3","user_id":"ID112","condition":80,"condition_sum":340,"bonus":null,"percentage":null},null],"prize":{"20":[{"bonus":2,"percentage":"5%"},{"bonus":4,"percentage":"10%"},{"bonus":6,"percentage":"10%"},{"bonus":8,"percentage":"15%"},{"bonus":10,"percentage":"15%"},{"bonus":20,"percentage":"20%"},{"bonus":30,"percentage":"15%"},{"bonus":40,"percentage":"10%"}],"60":[{"bonus":4,"percentage":"10%"},{"bonus":8,"percentage":"10%"},{"bonus":12,"percentage":"15%"},{"bonus":16,"percentage":"15%"},{"bonus":20,"percentage":"20%"},{"bonus":40,"percentage":"15%"},{"bonus":60,"percentage":"10%"},{"bonus":80,"percentage":"5%"}],"140":[{"bonus":8,"percentage":"20%"},{"bonus":16,"percentage":"20%"},{"bonus":24,"percentage":"20%"},{"bonus":32,"percentage":"15%"},{"bonus":40,"percentage":"15%"},{"bonus":80,"percentage":"6%"},{"bonus":120,"percentage":"3%"},{"bonus":160,"percentage":"1%"}],"340":[{"bonus":20,"percentage":"40%"},{"bonus":40,"percentage":"40%"},{"bonus":60,"percentage":"10%"},{"bonus":80,"percentage":"5%"},{"bonus":100,"percentage":"3%"},{"bonus":200,"percentage":"1%"},{"bonus":300,"percentage":"0.7%"},{"bonus":400,"percentage":"0.3%"}]},"expired_at":"2024-07-30T11:09:48.466Z"}

class BonusGameRes {
  BonusGameRes({
      Data data,}){
    _data = data;
}

  BonusGameRes.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data _data;
BonusGameRes copyWith({  Data data,
}) => BonusGameRes(  data: data ?? _data,
);
  Data get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    return map;
  }

}

/// count : 0
/// total : 0
/// itemsPerPage : 20
/// page : 0
/// max_page : 0
/// items : [{"id":"PCNZ2","user_id":"ID112","condition":40,"condition_sum":340,"bonus":null,"percentage":null},{"id":"PCNZ3","user_id":"ID112","condition":80,"condition_sum":340,"bonus":null,"percentage":null},null]
/// prize : {"20":[{"bonus":2,"percentage":"5%"},{"bonus":4,"percentage":"10%"},{"bonus":6,"percentage":"10%"},{"bonus":8,"percentage":"15%"},{"bonus":10,"percentage":"15%"},{"bonus":20,"percentage":"20%"},{"bonus":30,"percentage":"15%"},{"bonus":40,"percentage":"10%"}],"60":[{"bonus":4,"percentage":"10%"},{"bonus":8,"percentage":"10%"},{"bonus":12,"percentage":"15%"},{"bonus":16,"percentage":"15%"},{"bonus":20,"percentage":"20%"},{"bonus":40,"percentage":"15%"},{"bonus":60,"percentage":"10%"},{"bonus":80,"percentage":"5%"}],"140":[{"bonus":8,"percentage":"20%"},{"bonus":16,"percentage":"20%"},{"bonus":24,"percentage":"20%"},{"bonus":32,"percentage":"15%"},{"bonus":40,"percentage":"15%"},{"bonus":80,"percentage":"6%"},{"bonus":120,"percentage":"3%"},{"bonus":160,"percentage":"1%"}],"340":[{"bonus":20,"percentage":"40%"},{"bonus":40,"percentage":"40%"},{"bonus":60,"percentage":"10%"},{"bonus":80,"percentage":"5%"},{"bonus":100,"percentage":"3%"},{"bonus":200,"percentage":"1%"},{"bonus":300,"percentage":"0.7%"},{"bonus":400,"percentage":"0.3%"}]}
/// expired_at : "2024-07-30T11:09:48.466Z"

class Data {
  Data({
      num count, 
      num total, 
      num itemsPerPage, 
      num page, 
      num maxPage, 
      List<Items> items, 
      Prize prize, 
      String expiredAt,}){
    _count = count;
    _total = total;
    _itemsPerPage = itemsPerPage;
    _page = page;
    _maxPage = maxPage;
    _items = items;
    _prize = prize;
    _expiredAt = expiredAt;
}

  Data.fromJson(dynamic json) {
    _count = json['count'];
    _total = json['total'];
    _itemsPerPage = json['itemsPerPage'];
    _page = json['page'];
    _maxPage = json['max_page'];
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items.add(Items.fromJson(v));
      });
    }
    _prize = json['prize'] != null ? Prize.fromJson(json['prize']) : null;
    _expiredAt = json['expired_at'];
  }
  num _count;
  num _total;
  num _itemsPerPage;
  num _page;
  num _maxPage;
  List<Items> _items;
  Prize _prize;
  String _expiredAt;
Data copyWith({  num count,
  num total,
  num itemsPerPage,
  num page,
  num maxPage,
  List<Items> items,
  Prize prize,
  String expiredAt,
}) => Data(  count: count ?? _count,
  total: total ?? _total,
  itemsPerPage: itemsPerPage ?? _itemsPerPage,
  page: page ?? _page,
  maxPage: maxPage ?? _maxPage,
  items: items ?? _items,
  prize: prize ?? _prize,
  expiredAt: expiredAt ?? _expiredAt,
);
  num get count => _count;
  num get total => _total;
  num get itemsPerPage => _itemsPerPage;
  num get page => _page;
  num get maxPage => _maxPage;
  List<Items> get items => _items;
  Prize get prize => _prize;
  String get expiredAt => _expiredAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = _count;
    map['total'] = _total;
    map['itemsPerPage'] = _itemsPerPage;
    map['page'] = _page;
    map['max_page'] = _maxPage;
    if (_items != null) {
      map['items'] = _items.map((v) => v.toJson()).toList();
    }
    if (_prize != null) {
      map['prize'] = _prize.toJson();
    }
    map['expired_at'] = _expiredAt;
    return map;
  }

}

/// 20 : [{"bonus":2,"percentage":"5%"},{"bonus":4,"percentage":"10%"},{"bonus":6,"percentage":"10%"},{"bonus":8,"percentage":"15%"},{"bonus":10,"percentage":"15%"},{"bonus":20,"percentage":"20%"},{"bonus":30,"percentage":"15%"},{"bonus":40,"percentage":"10%"}]
/// 60 : [{"bonus":4,"percentage":"10%"},{"bonus":8,"percentage":"10%"},{"bonus":12,"percentage":"15%"},{"bonus":16,"percentage":"15%"},{"bonus":20,"percentage":"20%"},{"bonus":40,"percentage":"15%"},{"bonus":60,"percentage":"10%"},{"bonus":80,"percentage":"5%"}]
/// 140 : [{"bonus":8,"percentage":"20%"},{"bonus":16,"percentage":"20%"},{"bonus":24,"percentage":"20%"},{"bonus":32,"percentage":"15%"},{"bonus":40,"percentage":"15%"},{"bonus":80,"percentage":"6%"},{"bonus":120,"percentage":"3%"},{"bonus":160,"percentage":"1%"}]
/// 340 : [{"bonus":20,"percentage":"40%"},{"bonus":40,"percentage":"40%"},{"bonus":60,"percentage":"10%"},{"bonus":80,"percentage":"5%"},{"bonus":100,"percentage":"3%"},{"bonus":200,"percentage":"1%"},{"bonus":300,"percentage":"0.7%"},{"bonus":400,"percentage":"0.3%"}]

class Prize {
  Prize({
      List<20> , 
      List<60> , 
      List<140> , 
      List<340> ,}){
    _ = ;
    _ = ;
    _ = ;
    _ = ;
}

  Prize.fromJson(dynamic json) {
    if (json['20'] != null) {
      _ = [];
      json['20'].forEach((v) {
        _.add(20.fromJson(v));
      });
    }
    if (json['60'] != null) {
      _ = [];
      json['60'].forEach((v) {
        _.add(60.fromJson(v));
      });
    }
    if (json['140'] != null) {
      _ = [];
      json['140'].forEach((v) {
        _.add(140.fromJson(v));
      });
    }
    if (json['340'] != null) {
      _ = [];
      json['340'].forEach((v) {
        _.add(340.fromJson(v));
      });
    }
  }
  List<20> _;
  List<60> _;
  List<140> _;
  List<340> _;
Prize copyWith({  List<20> ,
  List<60> ,
  List<140> ,
  List<340> ,
}) => Prize(  :  ?? _,
  :  ?? _,
  :  ?? _,
  :  ?? _,
);
  List<20> get  => _;
  List<60> get  => _;
  List<140> get  => _;
  List<340> get  => _;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_ != null) {
      map['20'] = _.map((v) => v.toJson()).toList();
    }
    if (_ != null) {
      map['60'] = _.map((v) => v.toJson()).toList();
    }
    if (_ != null) {
      map['140'] = _.map((v) => v.toJson()).toList();
    }
    if (_ != null) {
      map['340'] = _.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// bonus : 20
/// percentage : "40%"

class 340 {
  340({
      num bonus, 
      String percentage,}){
    _bonus = bonus;
    _percentage = percentage;
}

  340.fromJson(dynamic json) {
    _bonus = json['bonus'];
    _percentage = json['percentage'];
  }
  num _bonus;
  String _percentage;
340 copyWith({  num bonus,
  String percentage,
}) => 340(  bonus: bonus ?? _bonus,
  percentage: percentage ?? _percentage,
);
  num get bonus => _bonus;
  String get percentage => _percentage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bonus'] = _bonus;
    map['percentage'] = _percentage;
    return map;
  }

}

/// bonus : 8
/// percentage : "20%"

class 140 {
  140({
      num bonus, 
      String percentage,}){
    _bonus = bonus;
    _percentage = percentage;
}

  140.fromJson(dynamic json) {
    _bonus = json['bonus'];
    _percentage = json['percentage'];
  }
  num _bonus;
  String _percentage;
140 copyWith({  num bonus,
  String percentage,
}) => 140(  bonus: bonus ?? _bonus,
  percentage: percentage ?? _percentage,
);
  num get bonus => _bonus;
  String get percentage => _percentage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bonus'] = _bonus;
    map['percentage'] = _percentage;
    return map;
  }

}

/// bonus : 4
/// percentage : "10%"

class 60 {
  60({
      num bonus, 
      String percentage,}){
    _bonus = bonus;
    _percentage = percentage;
}

  60.fromJson(dynamic json) {
    _bonus = json['bonus'];
    _percentage = json['percentage'];
  }
  num _bonus;
  String _percentage;
60 copyWith({  num bonus,
  String percentage,
}) => 60(  bonus: bonus ?? _bonus,
  percentage: percentage ?? _percentage,
);
  num get bonus => _bonus;
  String get percentage => _percentage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bonus'] = _bonus;
    map['percentage'] = _percentage;
    return map;
  }

}

/// bonus : 2
/// percentage : "5%"

class 20 {
  20({
      num bonus, 
      String percentage,}){
    _bonus = bonus;
    _percentage = percentage;
}

  20.fromJson(dynamic json) {
    _bonus = json['bonus'];
    _percentage = json['percentage'];
  }
  num _bonus;
  String _percentage;
20 copyWith({  num bonus,
  String percentage,
}) => 20(  bonus: bonus ?? _bonus,
  percentage: percentage ?? _percentage,
);
  num get bonus => _bonus;
  String get percentage => _percentage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bonus'] = _bonus;
    map['percentage'] = _percentage;
    return map;
  }

}

/// id : "PCNZ2"
/// user_id : "ID112"
/// condition : 40
/// condition_sum : 340
/// bonus : null
/// percentage : null

class Items {
  Items({
      String id, 
      String userId, 
      num condition, 
      num conditionSum, 
      dynamic bonus, 
      dynamic percentage,}){
    _id = id;
    _userId = userId;
    _condition = condition;
    _conditionSum = conditionSum;
    _bonus = bonus;
    _percentage = percentage;
}

  Items.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _condition = json['condition'];
    _conditionSum = json['condition_sum'];
    _bonus = json['bonus'];
    _percentage = json['percentage'];
  }
  String _id;
  String _userId;
  num _condition;
  num _conditionSum;
  dynamic _bonus;
  dynamic _percentage;
Items copyWith({  String id,
  String userId,
  num condition,
  num conditionSum,
  dynamic bonus,
  dynamic percentage,
}) => Items(  id: id ?? _id,
  userId: userId ?? _userId,
  condition: condition ?? _condition,
  conditionSum: conditionSum ?? _conditionSum,
  bonus: bonus ?? _bonus,
  percentage: percentage ?? _percentage,
);
  String get id => _id;
  String get userId => _userId;
  num get condition => _condition;
  num get conditionSum => _conditionSum;
  dynamic get bonus => _bonus;
  dynamic get percentage => _percentage;

  Map<String, dynamic> toJson() {
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