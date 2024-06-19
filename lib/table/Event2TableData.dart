class Event2TableData
{
  int? _id;
  num _name  = 0;
  num _condition = 0;
  num _conditionsum  = 0;
  num _count = 0;
  num _rate1 = 0;
  num _chance1 = 0;
  num _rate2 = 0;
  num _chance2 = 0;
  num _rate3 = 0;
  num _chance3 = 0;
  num _rate4 = 0;
  num _chance4 = 0;
  num _rate5 = 0;
  num _chance5 = 0;
  num _rate6 = 0;
  num _chance6 = 0;
  num _rate7 = 0;
  num _chance7 = 0;
  num _rate8 = 0;
  num _chance8 = 0;

  Event2TableData
  (
    {
      required int id,
      required num name,
      required num condition,
      required num conditionsum,
      required num count,
      required num rate1,
      required num chance1,
      required num rate2,
      required num chance2,
      required num rate3,
      required num chance3,
      required num rate4,
      required num chance4,
      required num rate5,
      required num chance5,
      required num rate6,
      required num chance6,
      required num rate7,
      required num chance7,
      required num rate8,
      required num chance8,
    }
  )
  {
    _id = id;
    _name = name;
    _condition = condition;
    _conditionsum  = conditionsum;
    _count = count;
    _rate1 = rate1;
    _chance1 = chance1;
    _rate2 = rate2;
    _chance2 = chance2;
    _rate3 = rate3;
    _chance3 = chance3;
    _rate4 = rate4;
    _chance4 = chance4;
    _rate5 = rate5;
    _chance5 = chance5;
    _rate6 = rate6;
    _chance6 = chance6;
    _rate7 = rate7;
    _chance7 = chance7;
    _rate8 = rate8;
    _chance8 = chance8;
  }

  factory Event2TableData.fromJson(Map<String, dynamic> json)
  {
    return
    Event2TableData
    (
      id: json['id'] != null ? int.parse(json["id"]) : 0,
      name: json['name'] != null ? num.parse(json["name"]) : 0,
      condition: json['condition'] != null ? num.parse(json["condition"]) : 0,
      conditionsum: json['conditionsum'] != null ? num.parse(json["conditionsum"]) : 0,
      chance1: json['chance1'] != null ? num.parse(json["chance1"]) : 0,
      chance2: json['chance2'] != null ? num.parse(json["chance2"]) : 0,
      chance3: json['chance3'] != null ? num.parse(json["chance3"]) : 0,
      chance4: json['chance4'] != null ? num.parse(json["chance4"]) : 0,
      chance5: json['chance5'] != null ? num.parse(json["chance5"]) : 0,
      chance6: json['chance6'] != null ? num.parse(json["chance6"]) : 0,
      chance7: json['chance7'] != null ? num.parse(json["chance7"]) : 0,
      chance8: json['chance8'] != null ? num.parse(json["chance8"]) : 0,
      rate1: json['rate1'] != null ? num.parse(json["rate1"]) : 0,
      rate2: json['rate2'] != null ? num.parse(json["rate2"]) : 0,
      rate3: json['rate3'] != null ? num.parse(json["rate3"]) : 0,
      rate4: json['rate4'] != null ? num.parse(json["rate4"]) : 0,
      rate5: json['rate5'] != null ? num.parse(json["rate5"]) : 0,
      rate6: json['rate6'] != null ? num.parse(json["rate6"]) : 0,
      rate7: json['rate7'] != null ? num.parse(json["rate7"]) : 0,
      rate8: json['rate8'] != null ? num.parse(json["rate8"]) : 0,
      count: json['count'] != null ? num.parse(json["count"]) : 0,
    );
  }

  int? get id => _id;
  num get name => _name;
  num get condition => _condition;
  num get conditionsum => _conditionsum;
  num get count => _count;
  num get rate1 => _rate1;
  num get chance1 => _chance1;
  num get rate2 => _rate2;
  num get chance2 => _chance2;
  num get rate3 => _rate3;
  num get chance3 => _chance3;
  num get rate4 => _rate4;
  num get chance4 => _chance4;
  num get rate5 => _rate5;
  num get chance5 => _chance5;
  num get rate6 => _rate6;
  num get chance6 => _chance6;
  num get rate7 => _rate7;
  num get chance7 => _chance7;
  num get rate8 => _rate8;
  num get chance8 => _chance8;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['condition'] = _condition;
    map['conditionsum'] = _conditionsum;
    map['count'] = _count;
    map['rate1'] = _rate1;
    map['chance1'] = _chance1;
    map['rate2'] = _rate2;
    map['chance2'] = _chance2;
    map['rate3'] = _rate3;
    map['chance3'] = _chance3;
    map['rate4'] = _rate4;
    map['chance4'] = _chance4;
    map['rate5'] = _rate5;
    map['chance5'] = _chance5;
    map['rate6'] = _rate6;
    map['chance6'] = _chance6;
    map['rate7'] = _rate7;
    map['chance7'] = _chance7;
    map['rate8'] = _rate8;
    map['chance8'] = _chance8;
    return map;
  }
}