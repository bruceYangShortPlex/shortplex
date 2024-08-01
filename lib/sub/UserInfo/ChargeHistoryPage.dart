import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shortplex/Util/HttpProtocolManager.dart';
import 'package:shortplex/sub/UserInfo/HistoryPage.dart';

import '../../Util/ShortplexTools.dart';
import '../../table/StringTable.dart';
import '../Home/HomeData.dart';

// void main() async
// {
//   WidgetsFlutterBinding.ensureInitialized();
//   await StringTable().InitTable();
//   runApp(ChargeHistoryPage(PageTitle: '기록'));
// }

class ChargeHistoryPage extends HistoryPage
{
  ChargeHistoryPage({super.key, required super.PageTitle, required super.historyType});

  @override
  State<ChargeHistoryPage> createState() => _ChargeHistoryPageState();
}

class _ChargeHistoryPageState extends State<ChargeHistoryPage>
{
  @override
  void initState()
  {
    HttpProtocolManager.to.Get_WalletHistory(WalletHistoryType.CHARGE).then((value)
    {
      if (value == null)
      {
        return;
      }
      Map<int,List<HistoryData>> mapData = {};
      for(var item in value.data!.items!)
      {
        var historyData = HistoryData();
        historyData.content1 = HomeData.to.GetPrice(item.productId!); //임시 과거의 값을 알수 없기때문에 서버에서 받아야한다.
        //historyData.content2 = item.description!;
        print('item.description! : ${item.description!}');
        historyData.title = SetStringArgument(item.description!, [item.credit!]);
        historyData.time = GetReleaseTime(item.createdAt!);
        historyData.iconUrl = HomeData.to.GetShopIcon(item.credit!, false);
        //historyData.episode = 1;
        historyData.createdAt = item.createdAt!;
        historyData.date = '${GetDateString(item.createdAt!).$1} ${GetDateString(item.createdAt!).$2}'; // '5월 2024';

        if (mapData.containsKey(historyData.GetKey()))
        {
          var value = mapData[historyData.GetKey()];
          value?.add(historyData);
        }
        else
        {
          List<HistoryData> list = <HistoryData>[];
          list.add(historyData);
          mapData[historyData.GetKey()] = list;
        }
      }

      for(var item in mapData.values)
      {
        widget.mainlist.add(item);
      }

      setState(() {
        widget.loadingComplete = true;
      });
    },);

   super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return widget.HistoryBuild(context);
  }
}
