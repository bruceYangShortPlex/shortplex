import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shortplex/sub/UserInfo/HistoryPage.dart';

class UsedHistoryPage extends HistoryPage
{
  UsedHistoryPage({super.key, required super.PageTitle, required super.historyType});

  @override
  State<UsedHistoryPage> createState() => _UsedHistoryPageState();
}

class _UsedHistoryPageState extends State<UsedHistoryPage>
{
  @override
  void initState() {
    widget.loadingComplete = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return widget.HistoryBuild(context);
  }
}
