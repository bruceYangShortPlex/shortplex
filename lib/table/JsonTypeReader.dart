import 'dart:convert';

class JsonTypeReader<T>
{
  final List<T>? listTableDatas;

  JsonTypeReader({this.listTableDatas});

  factory JsonTypeReader.fromJson(String jsonString, T Function(Map<String, dynamic>) fromJson)
  {
    List<dynamic> listFromJson = json.decode(jsonString);
    List<T> places = listFromJson.map((value) => fromJson(value)).toList();
    return JsonTypeReader(listTableDatas: places);
  }
}