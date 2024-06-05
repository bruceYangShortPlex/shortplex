import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shortplex/sub/Reward/RewardHistoryPage.dart';
import 'package:shortplex/sub/Reward/TitleSchoolPage.dart';

import '../../Util/ShortplexTools.dart';
import '../../table/StringTable.dart';
import '../../table/UserData.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => UserData());
  await StringTable().InitTable();
  runApp(const RewardPage());
}

class RewardPage extends StatefulWidget
{
  const RewardPage({super.key});

  @override
  State<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {

  late Timer eventTimer;
  late TextEditingController textEditingController;
  late FocusNode textFieldFocusNode;

  var eventList = <ShortPlexEventData>[];
  var eventTimerList = <ShortPlexEventData>[];
  var dailyMissionList = <DailyMissionData>[];

  String featureCode = '숏플렉스대박!';

  void startTimer()
  {
    eventTimer = Timer.periodic(
    const Duration(minutes: 1),(Timer timer) =>
    setState(()
    {
      for(var item in eventTimerList)
      {
        if (item.EndTime == null)
        {
          continue;
        }

        item.difference = item.difference! - const Duration(minutes: 1);
        if (item.difference! <= Duration.zero)
        {
          item.difference = Duration.zero;
          eventTimerList.remove(item);
        }
        print('Time left: ${formatDuration(item.difference!).$1}:${formatDuration(item.difference!).$2}');
      }
    },
    ),
    );
  }

  void onFocusChange() {
    if (!textFieldFocusNode.hasFocus && textEditingController.text.isEmpty) {
      setState(() {
        textEditingController.text = StringTable().Table![300013]!;
      });
    }
  }

  @override
  void initState()
  {
    super.initState();

    var defaultText = UserData.to.recommendedName.isEmpty ? StringTable().Table![300013]! : UserData.to.recommendedName;

    textEditingController = TextEditingController(text: defaultText,);
    textFieldFocusNode = FocusNode();
    textFieldFocusNode.addListener(onFocusChange);

    for (int i = 0 ; i < 3; ++i)
    {
      var testData = ShortPlexEventData();
      if (i % 2 == 0)
      {
        testData.SetTestTime();
      }
      testData.Title = '왭하드 테이블에서 받든지 서버에서 받든지';
      eventList.add(testData);
      eventTimerList.add(testData);
    }

    for (int i = 0 ; i < 6 ; ++i)
    {
      var missionTestData = DailyMissionData();
      missionTestData.missionType = DailyMissionType.values[i];
      missionTestData.missionCompleteCount = i;
      missionTestData.isReceive = i == 2;
      dailyMissionList.add(missionTestData);
    }

    startTimer();
  }

  @override
  void dispose() {
    textFieldFocusNode.removeListener(onFocusChange);
    textFieldFocusNode.dispose();
    textEditingController.dispose();
    super.dispose();
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
            //color: Colors.green,
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
                  TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
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
                  TextStyle(fontSize: 15, color: Color(0xFF00FFBF), fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
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
          child:
          SingleChildScrollView
          (
            child:
            Column
            (
              children:
              [
                SizedBox(height: 80,),
                eventGroup(),
                SizedBox(height: 40,),
                titleSchool(),
                SizedBox(height: 40,),
                shareFriend(),
                dailyMission(),
                SizedBox(height: 40,),
              ],
            ),
          ),

        ),
      ),
    ),
  );

  Widget eventGroup()
  {
    return
    Container
    (
      width: 390,
      child:
      Column
      (
        children:
        [
          Container
          (
            width: 390,
            alignment: Alignment.centerLeft,
            child:
            Text
            (
              StringTable().Table![400022]!,
              style:
              TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
            ),
          ),
          for(var item in eventList)
            eventItem(item),
        ],
      ),
    );
  }

  Widget eventItem(ShortPlexEventData _data)
  {
    return
    Container
    (
      height: 100,
      width: 390,
      child:
      Stack
      (
        children:
        [
          Visibility
          (
            visible: _data.EndTime != null,
            child:
            Align
            (
              alignment: Alignment.centerRight,
              child:
              Padding
              (
                padding: const EdgeInsets.only(right: 30),
                child:
                Container
                (
                  width: 130,
                  height: 55,
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.98, -0.18),
                      end: Alignment(-0.98, 0.18),
                      colors: [Color(0xFF033C32), Color(0xFF0A293E)],
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: Color(0xFF0A2022),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child:
                  Padding
                  (
                    padding: EdgeInsets.only(top: 4, left: 8, right: 8),
                    child:
                    FittedBox
                    (
                      alignment: Alignment.topCenter,
                      child:
                      Text
                      (
                        _data.EndTime != null ? SetTableStringArgument(800007, [formatDuration(_data.difference!).$1,formatDuration(_data.difference!).$2]) : '',
                        style:
                        TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding
          (
            padding: const EdgeInsets.only(top: 50),
            child:
            Center
            (
              child:
              Container
              (
                width: 356,
                height: 64,
                decoration: ShapeDecoration(
                  color: Color(0xFF1E1E1E),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Color(0xFF5670CE),
                    ),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child:
                Stack
                (
                  children:
                  [
                    //Image.network(_data.BG_Url, width: 356, height: 64,fit: BoxFit.fill, ),
                    Align
                    (
                      alignment: Alignment.centerLeft,
                      child:
                      Padding
                      (
                        padding: const EdgeInsets.only(left: 20),
                        child: 
                        Image.network(_data.IconUrl, height: 32, width: 32,),
                        // Container
                        // (
                        //   width: 32,
                        //   height: 32,
                        //   color: Colors.grey,
                        // ),
                      ),
                    ),
                    Center
                    (
                      child:
                      Padding
                      (
                        padding: const EdgeInsets.only(left: 10),
                        child: Text
                        (
                          _data.Title,
                          style:
                          TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget titleSchool()
  {
    return
    Container
    (
      width: 390,
      child: Column
      (
        children:
        [
          Align
          (
            alignment: Alignment.centerLeft,
            child:
            Text
            (
              StringTable().Table![300002]!,
              style:
              TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
            ),
          ),
          SizedBox(height: 10,),
          Container
          (
            width: 390,
            height: 160,
            color: Colors.grey,
          ),
          SizedBox(height: 10,),
          Align
          (
            alignment: Alignment.center,
            child:
            Text
              (
              StringTable().Table![300004]!,
              style:
              TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
            ),
          ),
          SizedBox(height: 10,),
          Container
          (
            width: 310,
            height: 209,
            color: Colors.grey,
          ),
          SizedBox(height: 5,),
          Container
          (
            width: 310,
            height: 57,
            decoration: ShapeDecoration(
              color: Color(0xFF202020),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Color(0xFF373737)),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            alignment: Alignment.center,
            child:
            GestureDetector
            (
              onTap: ()
              {
                Get.to(() => const TitleSchoolPage());
              },
              child: Container
              (
                width: 284,
                height: 33,
                decoration: ShapeDecoration(
                  color: Color(0xFF2B2B2B),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1.50,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Color(0xFF00FFBF),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child:
                Row
                (
                   mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    Icon(CupertinoIcons.bubble_left_fill, color: Colors.white,),
                    SizedBox(width: 10,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child:
                      Text
                      (
                        StringTable().Table![300005]!,
                        style:
                        TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget shareFriend()
  {
    return
    Container
    (
      width: 390,
      child:
      Column
      (
        children:
        [
          Row
          (
            children:
            [
              Expanded
              (
                child:
                Padding
                (
                  padding: EdgeInsets.only(bottom: 2),
                  child: Text
                  (
                    StringTable().Table![300006]!,
                    style:
                    TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                  ),
                ),
              ),
              Expanded
              (
                child:
                Container
                (
                  padding: EdgeInsets.only(bottom: 2),
                  alignment: Alignment.centerRight,
                  child:
                  Text
                  (
                    StringTable().Table![300007]!,
                    style:
                    TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                  ),
                ),
              ),
              Container
              (
                alignment: Alignment.centerRight,
                child:
                IconButton
                (
                    alignment: Alignment.center,
                    color: Colors.white,
                    iconSize: 20,
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: ()
                    {
                      Get.to(() => RewardHistory(PageTitle: StringTable().Table![300007]!));
                    }
                ),
              )
            ],
          ),
          Container
          (
            width: 390,
            height: 160,
            color: Colors.grey,
            child:
            Stack
            (
              alignment: Alignment.center,
              children:
              [
                Align
                (
                  alignment: Alignment.bottomRight,
                  child:
                  Padding
                  (
                    padding: const EdgeInsets.only(bottom: 10, right: 20),
                    child:
                    GestureDetector
                    (
                      onTap: () {
                        print('share button on');
                      },
                      child:
                      Opacity
                      (
                        opacity: 0.70,
                        child: Container(
                          width: 56,
                          height: 45,
                          decoration: ShapeDecoration(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1.50,
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: Color(0xFF3B3B3B),
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child:
                          Stack
                          (
                            alignment: Alignment.center,
                            children:
                            [
                              Padding
                              (
                                padding: const EdgeInsets.only(bottom: 14),
                                child: Icon(CupertinoIcons.share, size: 22, color:Colors.white),
                              ),
                              Padding
                              (
                                padding: const EdgeInsets.only(top: 18),
                                child: Text
                                  (
                                  StringTable().Table![100024]!,
                                  style:
                                  TextStyle(fontSize: 10, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ),
          SizedBox(height: 30,),
          Container
          (
            width: 390,
            //color: Colors.grey,
            child:
            Row
            (
              children:
              [
                Expanded
                (
                  child:
                  Container
                  (
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.center,
                    child:
                    Stack
                    (
                      children:
                      [
                        Opacity
                        (
                          opacity: 0.70,
                          child:
                          Container
                          (
                            width: 145,
                            height: 66,
                            decoration: ShapeDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(1.00, 0.00),
                                end: Alignment(-1, 0),
                                colors: [Color(0xFF023D30), Color(0xFF0A273E)],
                              ),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                  color: Color(0xFF0A2022),
                                ),
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            alignment: Alignment.bottomCenter,
                            padding: EdgeInsets.only(bottom: 10),
                            child:
                            Text
                            (
                              StringTable().Table![300009]!,
                              style:
                              TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                            ),
                          ),
                        ),
                        Container
                        (
                          width: 145,
                          height: 26,
                          decoration: ShapeDecoration(
                            color: Color(0xFF2B2B2B),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1.50,
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: Color(0xFF656565),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(bottom: 2),
                          child:
                          Text
                          (
                            StringTable().Table![300009]!,
                            style:
                            TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded
                (
                  child:
                  Container
                  (
                    padding: const EdgeInsets.only(right: 20),
                    alignment: Alignment.center,
                    child:
                    Stack
                    (
                      children:
                      [
                        Opacity
                          (
                          opacity: 0.70,
                          child:
                          Container
                            (
                            width: 145,
                            height: 66,
                            decoration: ShapeDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(1.00, 0.00),
                                end: Alignment(-1, 0),
                                colors: [Color(0xFF023D30), Color(0xFF0A273E)],
                              ),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                  color: Color(0xFF0A2022),
                                ),
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            alignment: Alignment.bottomCenter,
                            padding: EdgeInsets.only(bottom: 10),
                            child:
                            Text
                            (
                              StringTable().Table![300010]!,
                              style:
                              TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                            ),
                          ),
                        ),
                        Container
                        (
                          width: 145,
                          height: 26,
                          decoration: ShapeDecoration(
                            color: Color(0xFF2B2B2B),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1.50,
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: Color(0xFF656565),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(bottom: 2),
                          child:
                          Text
                          (
                            StringTable().Table![300010]!,
                            style:
                            TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25,),
          Opacity
          (
            opacity: 0.70,
            child: Container(
              width: 322.76,
              height: 27,
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(1.00, 0.00),
                  end: Alignment(-1, 0),
                  colors: [Color(0xFF023D30), Color(0xFF0A273E)],
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Color(0xFF0E2E30),
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              child:
              Row
              (
                children:
                [
                  Expanded
                  (
                    child:
                    Container
                    (
                      padding: const EdgeInsets.only(bottom: 2, right: 10),
                      alignment: Alignment.centerRight,
                      child:
                      Text
                      (
                        StringTable().Table![300012]!,
                        style:
                        TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                      ),
                    ),
                  ),
                  Expanded
                  (
                    child:
                    SizedBox
                    (
                      height: 30,
                      child:
                      CupertinoTextField
                      (
                        //enabled: false,
                        readOnly: UserData.to.recommendedName.isEmpty == false,
                        padding: const EdgeInsets.only(top: 3, left: 20),
                        controller: textEditingController,
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontFamily: 'NotoSans', fontSize: 13, color: Colors.white),
                        decoration:
                        BoxDecoration
                        (
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xFF1E1E1E),
                          border:
                          Border.all
                          (
                            color: Color(0xFF656565),
                            width: 1,
                          ),
                        ),
                        focusNode: textFieldFocusNode,
                        onTap: ()
                        {
                          if (textEditingController.text == StringTable().Table![300013]!)
                          {
                            setState(()
                            {
                              textEditingController.text = '';
                            });
                          }
                        },
                        onEditingComplete: ()
                        {
                          print('입력 스트링 ${textEditingController.text}');
                          //TODO:추천인 서버랑 통신해서 보너스 받거나 에러코드 보여주기
                          ShowCustomSnackbar(SetTableStringArgument(300040, ['10']),SnackPosition.BOTTOM);
                          UserData.to.recommendedName = textEditingController.text;
                          setState(() {

                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 5,),
          Align
          (
            alignment: Alignment.centerLeft,
            child:
            Padding
            (
              padding: const EdgeInsets.only(left: 40),
              child:
              Text
              (
                UserData.to.recommendedName.isEmpty ? StringTable().Table![300012]! : '',
                style:
                TextStyle(fontSize: 10, color: Color(0xFF00FFBF), fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Opacity
            (
            opacity: 0.70,
            child: Container(
              width: 322.76,
              height: 27,
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(1.00, 0.00),
                  end: Alignment(-1, 0),
                  colors: [Color(0xFF023D30), Color(0xFF0A273E)],
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Color(0xFF0E2E30),
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              child:
              Row
              (
                children:
                [
                  Expanded
                  (
                    child:
                    Container
                    (
                      padding: const EdgeInsets.only(bottom: 2, right: 10),
                      alignment: Alignment.centerRight,
                      child:
                      Text
                      (
                        StringTable().Table![300011]!,
                        style:
                        TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                      ),
                    ),
                  ),
                  Expanded
                  (
                    child:
                    Container
                    (
                      width: 145,
                      height: 30,
                      decoration: ShapeDecoration(
                        color: Color(0xFF2B2B2B),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: Color(0xFF00FFBF),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child:
                      Row
                      (
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          Text
                          (
                            featureCode,
                            style:
                            TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                          ),
                          IconButton
                          (
                            padding: EdgeInsets.only(bottom: 2),
                            alignment: Alignment.center,
                            onPressed: ()
                            {
                              Clipboard.setData(ClipboardData(text: featureCode));
                            },
                            icon: Icon(CupertinoIcons.doc_on_clipboard, color: Colors.white, size: 20,),
                          ),
                        ],
                      ),
                    )
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 35,),
        ],
      ),
    );
  }

  Widget dailyMission()
  {
    return
    Container
    (
      width: 390,
      child:
      Column
      (
        children:
        [
          Align
          (
            alignment: Alignment.centerLeft,
            child:
            Text
            (
              StringTable().Table![300015]!,
              style:
              const TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
            ),
          ),
          SizedBox(height: 10,),
          for(var item in dailyMissionList)
            Padding
            (
              padding: const EdgeInsets.only(bottom: 20),
              child:
              dailyMissionItem(item),
            ),
          SizedBox(height: 15),
          Center
          (
            child: Container
            (
              padding: EdgeInsets.zero,
              width: 165,
              height: 40,
              child:
              CupertinoButton
              (
                pressedOpacity: 0.5,
                padding: EdgeInsets.only(bottom: 2),
                color: Color(0xFF00FFBF),
                onPressed: ()
                {
                  //TODO : 전체수령
                },
                child:
                Text
                (
                  StringTable().Table![300046]!,
                  style:
                  const TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dailyMissionItem(DailyMissionData _data)
  {
    var textColor = Colors.white;
    if (_data.isReceive) {
      textColor = Colors.grey;
    }
    else if (_data.missionCompleteCount == _data.totalMissionCount)
    {
      textColor = const Color(0xFF00FFBF);
    }

    var missionCount = _data.totalMissionCount - _data.missionCompleteCount;

    return
    Container
    (
      width: 360,
      height: 62,
      decoration: ShapeDecoration(
        color: Color(0xFF1B1B1B),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: Color(0xFFA0A0A0),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child:
      Row
      (
        children:
        [
          Expanded
          (
            flex: 2,
            child:
            Container
            (
              //color: Colors.blue,
              child:
              Column
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  Padding
                  (
                    padding: const EdgeInsets.only(left: 20),
                    child: Row
                    (
                      children:
                      [
                        Image.asset
                        (
                          alignment: Alignment.center,
                          width: 20,
                          height: 20,
                          'assets/images/User/my_bonus.png',
                          fit: BoxFit.scaleDown,
                        ),
                        SizedBox(width: 5,),
                        Text
                        (
                          SetTableStringArgument(400061, ['${_data.bounusCount}']),
                          style:
                          TextStyle(fontSize: 14, color: textColor, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                        ),
                        SizedBox(width: 5,),
                        for(int i = 0; i < _data.missionCompleteCount; ++i)
                          Padding
                          (
                            padding: EdgeInsets.only(left: 2),
                            child:
                            Icon(CupertinoIcons.circle_fill, size: 10, color: textColor,)
                          ),

                        for(int i = 0; i < missionCount; ++i)
                          Padding
                          (
                            padding: EdgeInsets.only(left: 2),
                            child:
                            Icon
                            (
                              CupertinoIcons.circle,
                              size: 10,
                              color: textColor,
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Align
                  (
                    alignment: Alignment.centerLeft,
                    child:
                    Padding
                    (
                      padding: EdgeInsets.only(left: 20,),
                      child:
                      Text
                      (
                        _data.title,
                        style:
                        TextStyle(fontSize: 14, color: textColor, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded
          (
            child:
            Container
            (
              //color: Colors.red,
              child:
              Container
              (
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 27,
                child:
                CupertinoButton
                (
                  pressedOpacity: 0.5,
                  padding: EdgeInsets.only(bottom: 2),
                  color: Color(0xFF00FFBF),
                  onPressed: () {

                  },
                  child:
                  Text
                  (
                    StringTable().Table![300026]!,
                    style:
                    const TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShortPlexEventData
{
  String IconUrl = 'https://picsum.photos/250?image=9';
  String Title = '';
  String BG_Url = 'https://picsum.photos/250?image=9';
  DateTime? EndTime;
  Duration? difference;

  void SetTestTime()
  {
    EndTime = DateTime.now().add(Duration(minutes: 3));
    difference = EndTime!.difference(DateTime.now());
  }
}

enum DailyMissionType
{
  SHARE_CONTENT,
  CONTENT_UNLOCK,
  TITLE_SCHOOL,
  RELEASE_NOTI,
  ADS_VIEW,
  ASD_GOODS_BUY,
}

class DailyMissionData
{
  int bounusCount = 1;
  DailyMissionType missionType = DailyMissionType.SHARE_CONTENT;
  int totalMissionCount = 5;
  int missionCompleteCount = 0;
  String title = '타이틀';
  bool isReceive = false;
}
