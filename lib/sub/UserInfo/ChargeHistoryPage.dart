import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shortplex/sub/UserInfo/HistoryPage.dart';

class ChargeHistoryPage extends HistoryPage
{
  const ChargeHistoryPage({super.key, required super.PageTitle});

  @override
  State<ChargeHistoryPage> createState() => _ChargeHistoryPageState();
}

class _ChargeHistoryPageState extends State<ChargeHistoryPage>
{
  @override
  void didChangeDependencies()
  {
    super.didChangeDependencies();
    Get.put(HistoryListController());
    HistoryListController.to.mainlist.clear();

    List<Widget> list2 = <Widget>[];
    List<Widget> list1 = <Widget>[];

    list1.add(widget.historyItem('assets/images/main/shortplex.png', '300 팝콘', '11시간전', '29,900'));
    list2.add(widget.historyItem('assets/images/main/shortplex.png', '8 팝콘', '11시간전', '9,900'));
    list2.add(widget.historyItem('assets/images/main/shortplex.png', '정기구독권', '9시간전', '19,900',));
    list2.add(widget.historyItem('assets/images/main/shortplex.png', '999,999,999 팝콘', '11시간전', '999,9999,999'));

    HistoryListController.to.mainlist.add(widget.historyMain(list1));
    HistoryListController.to.mainlist.add(widget.historyMain(list2));
    print('add complete');
  }

  @override
  Widget build(BuildContext context)
  {
    return widget.HistoryBuild(context);
  }
}
