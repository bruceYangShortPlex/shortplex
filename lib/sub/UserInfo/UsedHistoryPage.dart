import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shortplex/sub/UserInfo/HistoryPage.dart';

class UsedHistoryPage extends HistoryPage
{
  const UsedHistoryPage({super.key, required super.PageTitle});

  @override
  State<UsedHistoryPage> createState() => _UsedHistoryPageState();
}

class _UsedHistoryPageState extends State<UsedHistoryPage>
{
  @override
  void didChangeDependencies()
  {
    super.didChangeDependencies();
    Get.put(HistoryListController());

    List<Widget> list2 = <Widget>[];
    List<Widget> list1 = <Widget>[];

    list1.add(widget.historyItem('assets/images/main/shortplex.png', '300 팝콘', '11시간전', '29,900'));
    list2.add(widget.historyItem('assets/images/main/shortplex.png', '8 팝콘', '11시간전', '9,900'));
    list2.add(widget.historyItem('assets/images/main/shortplex.png', '정기구독권', '9시간전', '19,900',));
    list2.add(widget.historyItem('assets/images/main/shortplex.png', '999,999,999 팝콘', '11시간전', '999,9999,999'));
    list2.add(widget.historyContent('assets/images/main/shortplex.png', '_episodes 2', '그 결혼', '11시간전', '-3팝콘', ''));
    list2.add(widget.historyContent('assets/images/main/shortplex.png', '_episodes 99', '황후마마가 돌아왔다', '1달전', '-200팝콘', '-600보너스',
        Color(0xFF00FFBF)));

    HistoryListController.to.mainlist.add(widget.historyMain(list1));
    HistoryListController.to.mainlist.add(widget.historyMain(list2));
  }

  @override
  Widget build(BuildContext context)
  {
    return widget.HistoryBuild(context);
  }
}
