import 'package:flutter/services.dart';
import 'StringTableData.dart';
import 'JsonTypeReader.dart';

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

// Future<String> GetStringTable(int _id) async
// {
//   var list = await readJson('assets/json/string.json');
//   String result = '';
//   for (int i = 0; i < list!.length; ++i)
//   {
//     var item = list[i];
//     if (item?.id == _id)
//     {
//       result = item?.kor;
//       break;
//     }
//   }
//   return result;
// }
