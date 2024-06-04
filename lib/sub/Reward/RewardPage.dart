import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../table/StringTable.dart';
import '../../table/UserData.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => UserData());
  await StringTable().InitTable();
  runApp(RewardPage());
}

class RewardPage extends StatefulWidget
{
  const RewardPage({super.key});

  @override
  State<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return mainWidget(context);
  }

Widget mainWidget(BuildContext context)=>
    SafeArea
    (
      child:
      CupertinoApp
      (
        home:
        CupertinoPageScaffold
        (
          backgroundColor: Colors.black,
          navigationBar:
          CupertinoNavigationBar
          (
            backgroundColor: Colors.transparent,
            leading:
            Container
            (
              height: 50,
              color: Colors.green,
              alignment: Alignment.center,
              child:
              Row
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  Text
                  (
                    StringTable().Table![300001]!,
                    style:
                    TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                  ),
                  Image.asset
                    (
                    alignment: Alignment.center,
                    width: 32,
                    height: 32,
                    'assets/images/User/my_bonus.png',
                    fit: BoxFit.fitHeight,
                  ),
                  Text
                  (
                    '${UserData.to.GetPopupcornCount().$2}',
                    style:
                    TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                  ),
                ],
              ),
            ),
          ),
          child:
          Container
          (
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            //color: Colors.blue,
          ),
        ),
      ),
    );
}
