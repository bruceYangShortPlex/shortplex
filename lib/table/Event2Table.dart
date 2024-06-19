import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shortplex/table/Event2TableData.dart';
import 'JsonTypeReader.dart';

class Event2table
{
  static Event2table get to => Get.find();

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
