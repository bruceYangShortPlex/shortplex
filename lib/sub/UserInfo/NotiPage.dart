import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../table/StringTable.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await StringTable().InitTable();

  runApp(const NotiPage(type: NotiType.TermsOfService,));
}

enum NotiType
{
  TermsOfService,
  PrivacyPolicy,
  LegalNotice
}

class NotiPage extends StatefulWidget
{
  const NotiPage({super.key, required this.type});

  final NotiType type;
  @override
  State<NotiPage> createState() => _NotiPageState();
}

class _NotiPageState extends State<NotiPage>
{
  List<NotiData> listNoti = <NotiData>[];

  setNoti()
  {
    switch(widget.type)
    {
      case NotiType.TermsOfService:
        {
          NotiData data = NotiData();
          data.TitleStringID = 400043;
          data.DescriptionStringID = 400080;
          listNoti.add(data);
        }
        break;
      case NotiType.PrivacyPolicy:
        {
          NotiData data = NotiData();
          data.TitleStringID = 400044;
          data.DescriptionStringID = 400081;
          listNoti.add(data);
        }
        break;
      case NotiType.LegalNotice:
        {
          NotiData data = NotiData();
          data.TitleStringID = 400045;
          data.DescriptionStringID = 400082;
          listNoti.add(data);
        }
        break;
      default:
        print('not found noti type');
        break;
    }
  }

  @override
  void initState() {
    setNoti();
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
            Row
              (
              mainAxisAlignment: MainAxisAlignment.start,
              children:
              [
                Container
                  (
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 50,
                  //color: Colors.blue,
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                  child:
                  CupertinoNavigationBarBackButton
                    (
                    color: Colors.white,
                    onPressed: ()
                    {
                      Get.back();
                    },
                  ),
                ),
                Container
                  (
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 50,
                  //color: Colors.green,
                  alignment: Alignment.center,
                  child:
                  Text
                  (
                    StringTable().Table![listNoti[0].TitleStringID]!,
                    style:
                    TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                  ),
                ),
                Container(width: MediaQuery.of(context).size.width * 0.3, height: 50,)
              ],
            ),
          ),
          child:
          Container
          (
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            //color: Colors.blue,
            child:
            SingleChildScrollView
            (
              child:
              Column
              (
                children:
                [
                  SizedBox(height: 60,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text
                    (
                      StringTable().Table![listNoti[0].DescriptionStringID]!,
                      style:
                      TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w400,),
                    ),
                  ),
                  SizedBox(height: 60,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
}

class NotiData
{
  int TitleStringID = 0;
  int DescriptionStringID = 0;
}
