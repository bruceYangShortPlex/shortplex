import 'package:flutter/cupertino.dart';

import '../UserInfo/HistoryPage.dart';

class RewardHistory extends HistoryPage {
  RewardHistory({super.key, required super.PageTitle, required super.historyType});

  @override
  State<RewardHistory> createState() => _RewardHistoryState();
}

class _RewardHistoryState extends State<RewardHistory>
{
  @override
  void initState() {
    widget.loadingComplete = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.HistoryBuild(context);
  }
}
