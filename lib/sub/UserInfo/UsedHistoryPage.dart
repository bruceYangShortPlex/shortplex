import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shortplex/sub/UserInfo/HistoryPage.dart';

class UsedHistoryPage extends HistoryPage
{
  UsedHistoryPage({super.key, required super.PageTitle});

  @override
  State<UsedHistoryPage> createState() => _UsedHistoryPageState();
}

class _UsedHistoryPageState extends State<UsedHistoryPage>
{
  @override
  void didChangeDependencies()
  {
    super.didChangeDependencies();

    List<HistoryData> list2 = <HistoryData>[];

    var historyData = HistoryData();
    historyData.content1 = '29,900';
    historyData.content2 = '-10 보너스';
    historyData.time = '11시간전';
    historyData.episode = 0;
    historyData.date = '05. 2024';
    list2.add(historyData);
    widget.mainlist.add(list2);
    widget.mainlist.add(list2);
  }

  @override
  Widget build(BuildContext context)
  {
    return widget.HistoryBuild(context);
  }
}
