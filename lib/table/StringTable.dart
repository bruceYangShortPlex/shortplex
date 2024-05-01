import 'package:flutter/services.dart';
import 'StringTableData.dart';
import 'JsonTypeReader.dart';
import 'package:http/http.dart' as http;

class StringTable
{
  // Private 생성자
  StringTable._privateConstructor();

  Map<int?, String>? Table = null;

  // 생성자를 호출하고 반환된 Singleton 인스턴스를 _instance 변수에 할당
  static final StringTable _instance = StringTable._privateConstructor();

  // Singleton() 호출시에 _instance 변수를 반환
  factory StringTable()
  {
    return _instance;
  }

  InitTable() async
  {
    if (Table != null)
      return;

    Table = await readJson('assets/json/string.json') as Map<int?, String>?;
    //Table = await downloadJSON('ddd');
  }
}

Future<Map<int?, String>> readJson(String _path) async {
  final response = await rootBundle.loadString(_path);

  JsonTypeReader<StringTableData> _placeList = JsonTypeReader.fromJson(response, StringTableData.fromJson);
  //return _placeList.listTableDatas;

  Map<int?, String> datas = {}; // Map<int?, StringTable>();
  for (int i = 0; i < _placeList.listTableDatas!.length; ++i)
  {
    var item = _placeList.listTableDatas![i];
    datas[item.id] = item.kor!;
  }

  return datas;
}

Future<Map<int?, String>> downloadJSON(String _uri) async {
  //var uri = 'https://your-web-hard.com/your-json-file.json';
  final response = await http.get(Uri.parse(_uri));

  if (response.statusCode == 200)
  {
    var _placeList = JsonTypeReader.fromJson(response.body, StringTableData.fromJson);
    Map<int?, String> datas = {}; // Map<int?, StringTable>();
    for (int i = 0; i < _placeList.listTableDatas!.length; ++i)
    {
      var item = _placeList.listTableDatas![i];
      datas[item.id] = item.kor!;
    }
    return datas;
  }
  else
  {
    throw Exception('Failed to download .json file.');
  }
}

