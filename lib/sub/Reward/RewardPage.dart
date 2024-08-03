import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shortplex/Util/AdsManager.dart';
import 'package:shortplex/Util/HttpProtocolManager.dart';
import 'package:shortplex/sub/Home/SearchPage.dart';
import 'package:shortplex/sub/Reward/BonusPage.dart';
import 'package:shortplex/sub/Reward/RewardHistoryPage.dart';
import 'package:shortplex/sub/Reward/TitleSchoolPage.dart';

import '../../Util/ShortplexTools.dart';
import '../../table/StringTable.dart';
import '../../table/UserData.dart';
import '../Home/HomeData.dart';
import '../UserInfo/LoginPage.dart';

// void main() async
// {
//   WidgetsFlutterBinding.ensureInitialized();
//   Get.lazyPut(() => UserData());
//   await StringTable().InitTable();
//   runApp(const RewardPage());
// }

class RewardPage extends StatefulWidget
{
  const RewardPage({super.key});

  @override
  State<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage>
{
  late Timer eventTimer;
  late TextEditingController textEditingController;
  late FocusNode textFieldFocusNode;

  var eventList = <ShortPlexEventData>[];
  var eventTimerList = <ShortPlexEventData>[];

  bool isInteractionDisabled = false;

  String referralCode = ''; //나의 코드
  String sendCode = '';
  String bonusCount = '0'; // 내가 받은 보너스
  String invitaionCount = '0'; //나를 추천한 / 내가 초대한 친구의 명수.
  bool buttonDisable = false;
  int bonusRate = 10;
  String titleSchoolImageUrl = '';

  getBonusEventInfo()
  {
    HttpProtocolManager.to.Get_BonusPageInfo().then((value)
    {
      if (value == null) {
        return;
      }

      if (value.data!.expiredAt.isNotEmpty)
      {
        for(var item in eventList)
        {
          if (item.eventPage == EventPageType.BONUS)
          {
            var end = DateTime.parse(value.data!.expiredAt);
            bool hasPassed =  DateTime.now().isAfter(end);
            if (hasPassed == false)
            {
              item.EndTime = end;
              item.difference = end.difference(DateTime.now());
            }
            else
            {
              item.EndTime = null;
              item.difference = null;

              if (kDebugMode) {
                print('remove event list bonus');
              }
              eventList.remove(item);
            }
          }
        }
      }
    },);
  }

  void startTimer()
  {
    eventTimer = Timer.periodic(const Duration(minutes: 1), (Timer timer)
    {
        if (mounted)
        {
          setState(()
          {
            for(var item in eventTimerList)
            {
              if (item.EndTime == null)
              {
                eventTimerList.remove(item);
                continue;
              }

              item.difference = item.difference! - const Duration(minutes: 1);
              if (item.difference! <= Duration.zero)
              {
                item.difference = Duration.zero;
                eventTimerList.remove(item);
              }
              //print('Time left: ${formatDuration(item.difference!).$1}:${formatDuration(item.difference!).$2}');
            }
          });

          if (eventTimerList.isEmpty) {
            timer.cancel();
          }
        }
        else
        {
          timer.cancel();
        }
      },
    );
  }

  void onFocusChange() {
    if (!textFieldFocusNode.hasFocus && textEditingController.text.isEmpty) {
      setState(() {
        textEditingController.text = StringTable().Table![300013]!;
      });
    }
  }

  getInvitaionInfo()
  {
    if (UserData.to.isLogin.value == false) {
      return;
    }

    HttpProtocolManager.to.Get_InvitationInfo().then((value)
    {
      if (value == null) {
        return;
      }

      for(var item in value.data!.info!)
      {
        if (item.userId == UserData.to.userId)
        {
          setState(()
          {
            bonusCount = item.bonus.toString();
            invitaionCount = item.followerUserCnt;
            referralCode = item.referralCode;
            sendCode = item.followingDisplayname;
            if (sendCode.isNotEmpty)
            {
              textEditingController.text = sendCode;
            }
          });
          break;
        }
      }
    });
  }

  @override
  void initState()
  {
    textEditingController = TextEditingController(text: StringTable().Table![300013]!,);
    textFieldFocusNode = FocusNode();
    textFieldFocusNode.addListener(onFocusChange);

    titleSchoolImageUrl = HomeData.to.TitleSchoolImageUrl;

    HomeData.to.GetMisstionList();
    getInvitaionInfo();
    super.initState();

    for (int i = 0 ; i < 2; ++i)
    {
      var testData = ShortPlexEventData();
      if (i % 2 == 0)
      {
        testData.Title = '팝콘 거시기 해보즈아';
        testData.eventPage = EventPageType.BONUS;
        testData.SetTestTime();
      }
      else
      {
        testData.eventPage = EventPageType.SEARCH;
      }
      testData.Title = '왭하드 테이블에서 받든지 서버에서 받든지';

      eventList.add(testData);
      eventTimerList.add(testData);
    }

    //getBonusEventInfo();

    startTimer();

    //친구초대 보너스율.
    HttpProtocolManager.to.Get_InvitationRwardInfo().then((value)
    {
      if (value == null)
      {
        return;
      }

      for(var item in value.data!.items!)
      {
        setState(() {
          bonusRate = item.bonusrate;
        });
        break;
      }
    },);

    HttpProtocolManager.to.Get_TitleSchoolInfo().then((value)
    {
      if (value == null) {
        return;
      }

      for(var item in value.data!.items!)
      {
        if (HomeData.to.TitleSchoolImageUrl != item.imageUrl)
        {
          HomeData.to.TitleSchoolImageUrl = item.imageUrl;
          setState(() {
            titleSchoolImageUrl = item.imageUrl;
          });
        }
        break;
      }
    });
  }

  @override
  void dispose() {
    eventTimer.cancel();
    textFieldFocusNode.removeListener(onFocusChange);
    textFieldFocusNode.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return
    AbsorbPointer
    (
      absorbing: isInteractionDisabled,
      child: mainWidget(context),
    );
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
                  TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                ),
                Image.asset
                (
                  alignment: Alignment.center,
                  width: 32,
                  height: 32,
                  'assets/images/user/my_bonus.png',
                  fit: BoxFit.fitHeight,
                ),
                Text
                (
                  '${UserData.to.GetPopupcornCount().$2}',
                  style:
                  TextStyle(fontSize: 15, color: Color(0xFF00FFBF), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
              TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
    GestureDetector
    (
      onTap: ()
      {
        if (_data.eventPage == EventPageType.SEARCH)
        {
          Get.to(() => SearchPage(), arguments: SearchGroupType.EVENT);
        }
        else if (_data.eventPage == EventPageType.BONUS)
        {
          Get.to(() => BonusPage());
        }
      },
      child:
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
                      padding: EdgeInsets.only(top: 2, left: 8, right: 8, bottom: 32),
                      child:
                      FittedBox
                      (
                        alignment: Alignment.topCenter,
                        child:
                        Text
                        (
                          _data.EndTime != null ? SetTableStringArgument(800007, [SubstringDuration(_data.difference!).$1,SubstringDuration(_data.difference!).$2]) : '',
                          style:
                          TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
                        color: Color(0xFF00FFBF),
                      ),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child:
                  Stack
                  (
                    children:
                    [
                      Container
                      (
                        width: 356,
                        height: 60,
                        decoration: ShapeDecoration(
                          color: Color(0xFF1E1E1E),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 2,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Color(0xFF00FFBF),
                            ),
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
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
                            TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
              TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
            ),
          ),
          SizedBox(height: 10,),
          Container
          (
            // width: 390,
            // height: 160,
            //color: Colors.grey,
            child:
            Stack
            (
              alignment: Alignment.center,
              children:
              [
                Image.asset
                (
                  'assets/images/Reward/reward_acabemy_image.png',
                ),
                Positioned
                (
                  left: 20,
                  top: 12,
                  child:
                  Container
                  (
                    //color: Colors.blue,
                    width: 200,
                    height: 40,
                    child:
                    Text
                    (
                      StringTable().Table![300003]!,
                      style:
                      TextStyle(fontSize: 14, color: Colors.black, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                    ),
                  ),
                ),
                Positioned
                (
                  right: 20,
                  bottom: 18,
                  child:
                  Container
                  (
                    width: 250,
                    height: 32,
                    alignment: Alignment.center,
                    ///color: Colors.yellow,
                    child:
                    Text
                    (
                      StringTable().Table![300055]!,
                      style:
                      TextStyle(fontSize: 14, color: Colors.black, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                    ),
                  ),
                ),
              ],
            ),
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
              TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
            ),
          ),
          SizedBox(height: 10,),
          Container
          (
            width: 310,
            height: 209,
            //color: Colors.red,
            child:
            titleSchoolImageUrl.isEmpty ? SizedBox() :
            Image.network(titleSchoolImageUrl),
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
                        TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
                flex: 3,
                child:
                Padding
                (
                  padding: EdgeInsets.only(bottom: 2),
                  child: Text
                  (
                    StringTable().Table![300006]!,
                    style:
                    TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
                  //color: Colors.red,
                  child:
                  Text
                  (
                    StringTable().Table![300007]!,
                    style:
                    TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
                      Get.to(() => RewardHistory(PageTitle: StringTable().Table![300007]!, historyType: WalletHistoryType.REWARD,));
                    }
                ),
              )
            ],
          ),
          Container
          (
            width: 390,
            height: 160,
            //color: Colors.grey,
            child:
            Stack
            (
              alignment: Alignment.center,
              children:
              [
                Image.asset('assets/images/Reward/reward_share_image.png'),
                Positioned
                (
                  top: 6,
                  child: Container
                  (
                    height: 40,
                    width: 300,
                    //color: Colors.red,
                    child: Text
                    (
                      textAlign: TextAlign.center,
                      SetTableStringArgument(300008, [bonusRate.toString()]),
                      style:
                      TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                    ),
                  ),
                ),
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
                        child:
                        Container(
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
                                child:
                                Text
                                (
                                  StringTable().Table![100024]!,
                                  style:
                                  TextStyle(fontSize: 10, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
                              invitaionCount,
                              style:
                              TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
                            TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
                            bonusCount,
                            style:
                            TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
                            TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
            Container
            (
              width: 323,
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
                        TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
                        readOnly: sendCode.isNotEmpty,
                        padding: const EdgeInsets.only(top: 3, left: 20),
                        controller: textEditingController,
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontFamily: 'NotoSans', fontSize: 13, color: Colors.grey, fontWeight: FontWeight.normal),
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
                        onTap: buttonDisable ? null : ()
                        {
                          if (UserData.to.isLogin.value == false)
                          {
                            textFieldFocusNode.unfocus();
                            showDialogTwoButton(StringTable().Table![600018]!, '',
                            ()
                            {
                              Get.to(() => LoginPage());
                            });
                            return;
                          }

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
                          textFieldFocusNode.unfocus();

                          if (textEditingController.text.isEmpty || textEditingController.text == referralCode)
                          {
                            print('afdas');
                            ShowCustomSnackbar( StringTable().Table![300057]! ,SnackPosition.TOP);
                            return;
                          }

                          HttpProtocolManager.to.Send_InvitationCode(textEditingController.text).then((value)
                          {
                            if(value.$1.isNotEmpty)
                            {
                              var stringIndex = 0;
                              if (value.$1.contains('Cannot accept more following'))
                              {
                                stringIndex = 300051;
                              }
                              else
                              {
                                print('Send_InvitationCode res.code ${value.$1}');
                                stringIndex = 300057;
                              }

                              ShowCustomSnackbar(StringTable().Table![stringIndex]!,SnackPosition.TOP);
                            }
                            else
                            {
                              if (value.$2)
                              {
                                getInvitaionInfo();

                                HttpProtocolManager.to.Get_WalletBalance().then((value1)
                                {
                                  if (value1 == null)
                                  {
                                    print('Send invitation after Get_WalletBalance is null!');
                                    return;
                                  }

                                  for(var item in value1.data!.items!)
                                  {
                                    if (item.userId == UserData.to.userId)
                                    {
                                      String message = UserData.to.MoneyUpdate(item.popcorns,item.bonus);
                                      if (message.isNotEmpty)
                                      {
                                        ShowCustomSnackbar(message, SnackPosition.TOP);
                                      }
                                      break;
                                    }
                                  }
                                },);
                              }
                              else
                              {
                                setState(() {
                                  sendCode = '';
                                });
                              }
                            }
                          },);
                        },
                      ),
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
              padding: const EdgeInsets.only(left: 40),
              child:
              Text
              (
                sendCode.isEmpty ? StringTable().Table![300012]! : sendCode,
                style:
                TextStyle(fontSize: 10, color: Color(0xFF00FFBF), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
              ),
            ),
          ),
          SizedBox(height: 10,),
            Container
            (
              width: 323,
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
                        TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
                            referralCode,
                            style:
                            TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                          ),
                          IconButton
                          (
                            padding: EdgeInsets.only(bottom: 2),
                            alignment: Alignment.center,
                            onPressed: ()
                            {
                              Clipboard.setData(ClipboardData(text: referralCode));
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
              const TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
            ),
          ),
          SizedBox(height: 10,),
          Obx(()
          {
            return
            Column
            (
              children:
              [
                for(var item in HomeData.to.DailyMissionList)
                  Padding
                  (
                    padding: const EdgeInsets.only(bottom: 20),
                    child:
                    dailyMissionItem(item),
                  ),
              ],
            );
          }),
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
                  const TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
    //print('_data.totalMissionCount : ${_data.totalMissionCount} / _data.missionCompleteCount : ${_data.missionCompleteCount} / missionCount : $missionCount');

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
                    child:
                    Row
                    (
                      children:
                      [
                        Image.asset
                        (
                          alignment: Alignment.center,
                          width: 20,
                          height: 20,
                          'assets/images/user/my_bonus.png',
                          fit: BoxFit.scaleDown,
                        ),
                        SizedBox(width: 5,),
                        Text
                        (
                          SetTableStringArgument(400061, ['${_data.bounusCount}']),
                          style:
                          TextStyle(fontSize: 14, color: textColor, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                        ),
                        SizedBox(width: 5,),

                        // for(int i = 0; i < _data.missionCompleteCount; ++i)
                        //   Padding
                        //   (
                        //     padding: EdgeInsets.only(left: 2),
                        //     child:
                        //     Icon(CupertinoIcons.circle_fill, size: 10, color: textColor,)
                        //   ),

                        // for(int i = 0; i < missionCount; ++i)
                        //   Padding
                        //   (
                        //     padding: EdgeInsets.only(left: 2),
                        //     child:
                        //     Icon
                        //     (
                        //       CupertinoIcons.circle,
                        //       size: 10,
                        //       color: textColor,
                        //     ),
                        //   ),
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
                        TextStyle(fontSize: 14, color: textColor, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
                  onPressed: ()
                  {
                    setState(() {
                      isInteractionDisabled = true;
                    });

                    AdManager.loadRewardedAd((reward) =>
                    {
                      print('print reward $reward'),
                      isInteractionDisabled = false,
                    });

                    print('print ads');
                  },
                  child:
                  Text
                  (
                    StringTable().Table![300026]!,
                    style:
                    const TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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

enum EventPageType
{
  NONE,
  SEARCH,
  BONUS,
}

class ShortPlexEventData
{
  String IconUrl = 'https://picsum.photos/250?image=9';
  String Title = '';
  DateTime? EndTime;
  Duration? difference;
  EventPageType eventPage = EventPageType.NONE;

  void SetTestTime()
  {
    EndTime = DateTime.now().add(Duration(minutes: 3));
    difference = EndTime!.difference(DateTime.now());
  }
}

class DailyMissionData
{
  int bounusCount = 1;
  DailyMissionType missionType = DailyMissionType.SHARE_CONTENT;
  int totalMissionCount = 5;
  int missionCompleteCount = 0;
  String title = '타이틀';
  bool isReceive = false;
  bool isVisible = true;

  SetMissionType(String _nameCD)
  {
    if (_nameCD == '300016')
    {
      missionType = DailyMissionType.SHARE_CONTENT;
    }
    else if (_nameCD == '300017' ||  _nameCD == '300018' || _nameCD == '300019')
    {
      missionType = DailyMissionType.CONTENT_UNLOCK;
    }
    else if (_nameCD == '300020')
    {
      missionType = DailyMissionType.TITLE_SCHOOL;
    }
    else if (_nameCD == '300022')
    {
      missionType = DailyMissionType.RELEASE_NOTI;
    }
    else if (_nameCD == '300023' ||  _nameCD == '300024' || _nameCD == '300025')
    {
      missionType = DailyMissionType.ADS_VIEW;
    }
    else if (_nameCD == '300021')
    {
      missionType = DailyMissionType.ASD_GOODS_BUY;
    }
    else
    {
      if (kDebugMode) {
        print('not found mission type : $_nameCD');
      }
      missionType = DailyMissionType.NONE;
    }
  }
}


