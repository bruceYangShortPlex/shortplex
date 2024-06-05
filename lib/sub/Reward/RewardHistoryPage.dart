import 'package:flutter/cupertino.dart';

import '../UserInfo/HistoryPage.dart';

class RewardHistory extends HistoryPage {
  RewardHistory({super.key, required super.PageTitle});

  @override
  State<RewardHistory> createState() => _RewardHistoryState();
}

class _RewardHistoryState extends State<RewardHistory> {
  @override
  Widget build(BuildContext context) {
    return widget.HistoryBuild(context);
  }
}
