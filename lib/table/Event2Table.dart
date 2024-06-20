import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shortplex/table/Event2TableData.dart';
import 'JsonTypeReader.dart';

class Event2table
{
  Event2table._privateConstructor();


  // 생성자를 호출하고 반환된 Singleton 인스턴스를 _instance 변수에 할당
  static final Event2table _instance = Event2table._privateConstructor();

  // Singleton() 호출시에 _instance 변수를 반환
  factory Event2table()
  {
    return _instance;
  }

  //Map<int?, String>? Table = null;
  static List<Event2TableData> tableDataList = <Event2TableData>[];
  get tableData => tableDataList;

  InitTable() async
  {
    // if (Table != null)
    //   return;
    //
    // Table = await readJson('assets/json/string.json') as Map<int?, String>?;

    tableDataList =  (await readJson('assets/json/Event2.json'))!;
  }

  Future<List<Event2TableData>?> readJson(String _path) async
  {
    final response = await rootBundle.loadString(_path);

    //print(response);

    try {
      JsonTypeReader<Event2TableData> _placeList = JsonTypeReader.fromJson(
          response, Event2TableData.fromJson);
      return _placeList.listTableDatas!;
    }
    catch(e)
    {
      print(e);
      return null;
    }

    // Map<num?, Event2TableData> datas = {}; // Map<int?, StringTable>();
    // for (int i = 0; i < _placeList.listTableDatas!.length; ++i)
    // {
    //   var item = _placeList.listTableDatas![i];
    //   datas[item.id] = item;
    // }
    //
    // return datas;
  }
}
