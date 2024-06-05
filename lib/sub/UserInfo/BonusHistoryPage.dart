import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shortplex/sub/UserInfo/HistoryPage.dart';

class BonusHistoryPage extends HistoryPage
{
  BonusHistoryPage({super.key, required super.PageTitle});

  @override
  State<BonusHistoryPage> createState() => _BonusHistoryPageState();
}

class _BonusHistoryPageState extends State<BonusHistoryPage>
{
  @override
  void didChangeDependencies()
  {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context)
  {
    return widget.HistoryBuild(context);
  }
}
