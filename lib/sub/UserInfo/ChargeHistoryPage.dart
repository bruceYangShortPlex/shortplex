import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shortplex/Util/HttpProtocolManager.dart';
import 'package:shortplex/sub/UserInfo/HistoryPage.dart';

import '../../table/StringTable.dart';

// void main() async
// {
//   WidgetsFlutterBinding.ensureInitialized();
//   await StringTable().InitTable();
//   runApp(ChargeHistoryPage(PageTitle: '기록'));
// }

class ChargeHistoryPage extends HistoryPage
{
  ChargeHistoryPage({super.key, required super.PageTitle});

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

      List<HistoryData> list2 = <HistoryData>[];
      for(var item in value.data!.items!)
      {
        var historyData = HistoryData();
        historyData.content1 = '29,900';
        historyData.content2 = '+10 팝콘';
        historyData.time = '11시간전';
        historyData.iconUrl = 'assets/images/shop/my_popcon2.png';
        historyData.episode = 1;
        historyData.date = '05. 2024';
        list2.add(historyData);
      }

      widget.mainlist.add(list2);
      widget.mainlist.add(list2);

      setState(()
      {
        widget.mainlist.add(list2);
        widget.mainlist.add(list2);
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
