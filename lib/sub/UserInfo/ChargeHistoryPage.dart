import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shortplex/sub/UserInfo/HistoryPage.dart';

import '../../table/StringTable.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await StringTable().InitTable();
  runApp(ChargeHistoryPage(PageTitle: '기록'));
}

class ChargeHistoryPage extends HistoryPage
{
  ChargeHistoryPage({super.key, required super.PageTitle});

  @override
  State<ChargeHistoryPage> createState() => _ChargeHistoryPageState();
}

class _ChargeHistoryPageState extends State<ChargeHistoryPage>
{
  @override
  void initState() {
     super.initState();
     List<HistoryData> list2 = <HistoryData>[];

     var historyData = HistoryData();
     historyData.content1 = '29,900';
     historyData.content2 = '-10 보너스';
     historyData.time = '11시간전';
     historyData.episode = 1;
     historyData.date = '05. 2024';
     list2.add(historyData);
     widget.mainlist.add(list2);
     widget.mainlist.add(list2);
  }

  @override
  void didChangeDependencies()
  {
    super.didChangeDependencies();

    // List<Widget> list1 = <Widget>[];
    //
    // list1.add(widget.historyItem('assets/images/main/shortplex.png', '300 팝콘', '11시간전', '29,900'));
    // list2.add(widget.historyItem('assets/images/main/shortplex.png', '8 팝콘', '11시간전', '9,900'));
    // list2.add(widget.historyItem('assets/images/main/shortplex.png', '정기구독권', '9시간전', '19,900',));
    // list2.add(widget.historyItem('assets/images/main/shortplex.png', '999,999,999 팝콘', '11시간전', '999,9999,999'));
    //
    // HistoryListController.to.mainlist.add(widget.historyMain(list1));
    // HistoryListController.to.mainlist.add(widget.historyMain(list2));
    print('add complete');
  }

  @override
  Widget build(BuildContext context)
  {
    return widget.HistoryBuild(context);
  }
}
