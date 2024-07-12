import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gif/gif.dart';
import 'package:shortplex/sub/UserInfo/ShopPage.dart';

import '../../Util/ShortplexTools.dart';
import '../../table/Event2Table.dart';
import '../../table/StringTable.dart';
import '../../table/UserData.dart';


enum PopcornAnimationState
{
  START,
  END,
}

// void main() async
// {
//   WidgetsFlutterBinding.ensureInitialized();
//   Get.lazyPut(() => UserData());
//   await Event2table().InitTable();
//   await StringTable().InitTable();
//   runApp(const BonusPage());
// }

class BonusPage extends StatefulWidget
{
  const BonusPage({super.key});

  @override
  State<BonusPage> createState() => _BonusPageState();
}

class _BonusPageState extends State<BonusPage> with TickerProviderStateMixin
{
  late final GifController controller1;
  PopcornAnimationState animationState = PopcornAnimationState.START;
  int playCount = 0;
  late Timer eventTimer;
  DateTime? endTime;
  Duration? difference;
  bool isOpenInfo = false;
  bool isOpenResult = false;
  int stackCount = 0;
  int bonusResult = 2;
  var pageList = <Widget>[];
  late AnimationController tweenController;
  late AnimationController tweenController2;
  var prevState1 = AnimationStatus.completed;
  var prevState2 = AnimationStatus.completed;

  void startTimer()
  {
    endTime = DateTime.now().add(Duration(minutes: 3));
    difference = endTime!.difference(DateTime.now());
    eventTimer = Timer.periodic(const Duration(minutes: 1), (Timer timer)
    {
      if (endTime == null) {
        return;
      }

      if (mounted)
      {
        setState(()
        {
          difference = difference! - const Duration(minutes: 1);
          if (difference! <= Duration.zero)
          {
            difference = Duration.zero;
          }
        });
      }
      else
      {
        timer.cancel();
      }
    },
    );
  }

  @override
  void initState()
  {
    Get.lazyPut(() => Event2table());
    stackCount = 0; //서버에서 받아야한드아..
    controller1 = GifController(vsync: this);

    tweenController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    tweenController2 = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    super.initState();

    startTimer();
    createBonusInfoScroll();

    controller1.addListener(()
    {
      if (controller1.status == AnimationStatus.completed )
      {
          isOpenResult = true;
          tweenController.forward(from: 0);
          setState(() {

          });
      }
    },);


    tweenController.addListener(()
    {
      if (prevState1 == AnimationStatus.reverse && tweenController.status == AnimationStatus.dismissed)
      {
        isOpenResult = false;
        setState(() {

        });
      }
      prevState1 = tweenController.status;
    });

    tweenController2.addListener(()
    {
      if (prevState2 == AnimationStatus.reverse && tweenController2.status == AnimationStatus.dismissed)
      {
        isOpenInfo = false;
        setState(() {

        });
      }
      prevState2 = tweenController2.status;
    });
  }

  void createBonusInfoScroll()
  {
    var tableData = Event2table().tableData[stackCount];

    pageList.add(SizedBox(width: 50, height: 50, child: Stack
    (
      children:
      [
        SvgPicture.asset('assets/images/Reward/reward_event_popcorn/reward_event_popcorn_icon_frame.svg',width: 50,height: 50,),
        Image.asset('assets/images/Reward/reward_event_popcorn/reward_bonus1.png', width: 50, height: 50,),
        Container
        (
          width: 50,
          height: 50,
          padding: const EdgeInsets.only(right: 4),
          alignment: Alignment.bottomRight,
          child:
          Text
          (
            '${tableData.chance1}',
            style:
            TextStyle(fontSize: 16, color:Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
          ),
        ),
      ],
    )));
    pageList.add(SizedBox(width: 50, height: 50, child: Stack
    (
      children:
      [
        SvgPicture.asset('assets/images/Reward/reward_event_popcorn/reward_event_popcorn_icon_frame.svg',width: 50,height: 50,),
        Image.asset('assets/images/Reward/reward_event_popcorn/reward_bonus2.png', width: 50, height: 50,),
        Container
        (
          width: 50,
          height: 50,
          padding: const EdgeInsets.only(right: 4),
          alignment: Alignment.bottomRight,
          child:
          Text
            (
            '${tableData.chance2}',
            style:
            TextStyle(fontSize: 16, color:Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
          ),
        ),
      ],
    )));
    pageList.add(SizedBox(width: 50, height: 50, child: Stack
    (
      children:
      [
        SvgPicture.asset('assets/images/Reward/reward_event_popcorn/reward_event_popcorn_icon_frame.svg',width: 50,height: 50,),
        Image.asset('assets/images/Reward/reward_event_popcorn/reward_bonus3.png', width: 50, height: 50,),
        Container
          (
          width: 50,
          height: 50,
          padding: const EdgeInsets.only(right: 4),
          alignment: Alignment.bottomRight,
          child:
          Text
          (
            '${tableData.chance3}',
            style:
            const TextStyle(fontSize: 16, color:Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
          ),
        ),
      ],
    )));
    pageList.add(SizedBox(width: 50, height: 50, child: Stack
    (
      children:
      [
        SvgPicture.asset('assets/images/Reward/reward_event_popcorn/reward_event_popcorn_icon_frame.svg',width: 50,height: 50,),
        Image.asset('assets/images/Reward/reward_event_popcorn/reward_bonus4.png', width: 50, height: 50,),
        Container
          (
          width: 50,
          height: 50,
          padding: const EdgeInsets.only(right: 4),
          alignment: Alignment.bottomRight,
          child:
          Text
            (
            '${tableData.chance4}',
            style:
            const TextStyle(fontSize: 16, color:Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
          ),
        ),
      ],
    )));
    pageList.add(SizedBox(width: 50, height: 50, child: Stack
      (
      children:
      [
        SvgPicture.asset('assets/images/Reward/reward_event_popcorn/reward_event_popcorn_icon_frame.svg',width: 50,height: 50,),
        Image.asset('assets/images/Reward/reward_event_popcorn/reward_bonus5.png', width: 50, height: 50,),
        Container
          (
          width: 50,
          height: 50,
          padding: const EdgeInsets.only(right: 4),
          alignment: Alignment.bottomRight,
          child:
          Text
            (
            '${tableData.chance5}',
            style:
            TextStyle(fontSize: 16, color:Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
          ),
        ),
      ],
    )));
    pageList.add(SizedBox(width: 50, height: 50, child: Stack
      (
      children:
      [
        SvgPicture.asset('assets/images/Reward/reward_event_popcorn/reward_event_popcorn_icon_frame.svg',width: 50,height: 50,),
        Image.asset('assets/images/Reward/reward_event_popcorn/reward_bonus6.png', width: 50, height: 50,),
        Container
          (
          width: 50,
          height: 50,
          padding: const EdgeInsets.only(right: 4),
          alignment: Alignment.bottomRight,
          child:
          Text
            (
            '${tableData.chance6}',
            style:
            const TextStyle(fontSize: 16, color:Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
          ),
        ),
      ],
    )));
    pageList.add(SizedBox(width: 50, height: 50, child: Stack
      (
      children:
      [
        SvgPicture.asset('assets/images/Reward/reward_event_popcorn/reward_event_popcorn_icon_frame.svg',width: 50,height: 50,),
        Image.asset('assets/images/Reward/reward_event_popcorn/reward_bonus7.png', width: 50, height: 50,),
        Container
          (
          width: 50,
          height: 50,
          padding: const EdgeInsets.only(right: 4),
          alignment: Alignment.bottomRight,
          child:
          Text
            (
            '${tableData.chance7}',
            style:
            const TextStyle(fontSize: 16, color:Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
          ),
        ),
      ],
    )));
    pageList.add(SizedBox(width: 50, height: 50, child: Stack
      (
      children:
      [
        SvgPicture.asset('assets/images/Reward/reward_event_popcorn/reward_event_popcorn_icon_frame.svg',width: 50,height: 50,),
        Image.asset('assets/images/Reward/reward_event_popcorn/reward_bonus8.png', width: 50, height: 50,),
        Container
          (
          width: 50,
          height: 50,
          padding: const EdgeInsets.only(right: 4),
          alignment: Alignment.bottomRight,
          child:
          Text
          (
            '${tableData.chance8}',
            style:
            TextStyle(fontSize: 16, color:Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
          ),
        ),
      ],
    )));
  }

  @override
  void dispose()
  {
    tweenController2.dispose();
    tweenController.dispose();
    controller1.dispose();
    super.dispose();
  }

  Widget mainWidget(BuildContext context)
  {
    // print('height : ${MediaQuery.of(context).size.height}');
    // var screen_height = MediaQuery.of(context).size.height;
    // var scaleRatio = screen_height / 840;
    // if (scaleRatio > 1)
    // {
    //   scaleRatio = 1;
    // }
    return
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
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.3,
                  height: 50,
                  //color: Colors.blue,
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                  child:
                  CupertinoNavigationBarBackButton
                    (
                    color: Colors.white,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                Container
                  (
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.3,
                  height: 50,
                  //color: Colors.green,
                  alignment: Alignment.center,
                  child:
                  Text
                    (
                    StringTable().Table![800006]!,
                    style:
                    const TextStyle(
                      fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                  ),
                ),
                Container(width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.3, height: 50,)
              ],
            ),
          ),
          child:
          Container
            (
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            //color: Colors.blue,
            child:
            // Transform.scale
            // (
            //   scale: scaleRatio,
            //   child:
              Stack
              (
                //alignment: Alignment.center,
                children:
                [
                  popcornAnimation(),
                  bounusInfoPageView(),
                  bonusResultPopup(),
                  infoPopup(),
                ],
              ),
            //),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return mainWidget(context);
  }

  Widget remainTimer()
  {
    return
    Container
    (
      width: 310, height: 684,
      alignment: Alignment.topRight,
      child:
      Padding
      (
        padding: const EdgeInsets.only(right: 0),
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
            padding: EdgeInsets.only(top: 4, left: 8, right: 8, bottom: 32),
            child:
            Text
            (
              textAlign: TextAlign.center,
              endTime != null ? SetTableStringArgument(800007, [formatDuration(difference!).$1,formatDuration(difference!).$2]) : '',
              style:
              TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
            ),
          ),
        ),
      ),
    );
  }

  Widget bounusInfoPageView()
  {
    return
    Center
    (
      child:
      Padding
      (
        padding: const EdgeInsets.only(left: 2, bottom: 504),
        child:
        Container
        (
          width: 314,
          height: 60,
          //color: Colors.red,
          child:
          CarouselSlider
          (
            items: pageList,
            // itemCount: pageList.length,
            // itemBuilder: (context, index, realIndex)
            // {
            //   var widget = pageList.length != 0 && index < pageList.length ? topPageItem(pageList[index]) : Container();
            //   return widget;
            // },
            options:
            CarouselOptions
            (
              autoPlayInterval: Duration(milliseconds: 1000),
              autoPlayAnimationDuration : Duration(milliseconds: 1010),
              autoPlayCurve: Curves.linear,
              enlargeFactor: 1,
              enlargeCenterPage: false,
              viewportFraction: 0.2,
              height: 50,
              autoPlay: true,
              //aspectRatio: 1.0,
              initialPage: 0,
              onPageChanged: (index, reason)
              {
              },
            ),
            //items: pageList,
          ),
        ),
      ),
    );
  }

  Widget popcornAnimation()
  {
    var tableData = Event2table().tableData[stackCount];

    return
    Container
    (
      alignment: Alignment.center,
      child:
      Stack
      (
        alignment: Alignment.center,
        children:
        [
          remainTimer(),
          Image.asset('assets/images/Reward/reward_event_popcorn/reward_event_popcorn_bg.png', width: 350, height: 622,),
          Visibility
          (
            visible: playCount > 0,
            child: Image.asset('assets/images/Reward/reward_event_popcorn/reward_event_popcorn_bt.png', width: 350, height: 622,)
          ),
          Padding
          (
            padding: const EdgeInsets.only(bottom: 106, left: 2),
            child:
            SizedBox
            (
              width: 317,
              height: 293,
              child:
              Stack
              (
                children:
                [
                  Gif
                  (
                    fit: BoxFit.contain,
                    //fps: 30,
                    duration: const Duration(milliseconds: 3000),
                    controller: controller1,
                    autostart: Autostart.no,
                    //repeat: ImageRepeat.repeat,
                    placeholder: (context) =>
                    const Center(child: CircularProgressIndicator()),
                    image: const AssetImage('assets/images/Reward/reward_event_popcorn/reward_event_popcorn_play.gif'),
                  ),
                  Visibility
                  (
                    visible: animationState == PopcornAnimationState.START,
                    child:
                    Gif
                    (
                      fit: BoxFit.contain,
                      //fps: 30,
                      autostart: Autostart.once,
                      duration: Duration(milliseconds: 1150),
                      placeholder: (context) =>
                      const Center(child: CircularProgressIndicator()),
                      image: const AssetImage('assets/images/Reward/reward_event_popcorn/reward_event_popcorn_open.gif'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding
          (
            padding: const EdgeInsets.only(top: 286),
            child:
            Container
            (
              width: 320,
              height: 60,
              //color: Colors.red,
              child:
              Row
              (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                [
                  Container
                  (
                    padding: const EdgeInsets.only(left: 8),
                    alignment: Alignment.center,
                    width: 248,
                    height: 60,
                    //color: Colors.green,
                    child:
                    Text
                    (
                      SetTableStringArgument(800012, ['${tableData.condition}','$playCount']),

                      style:
                      TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w500,),
                    ),
                  ),
                  Container
                  (
                    padding: const EdgeInsets.only(top: 6),
                    width: 58,
                    height: 60,
                    //color: Colors.yellow,
                    child:
                    Column
                    (
                      children:
                      [
                        Text
                        (
                          '남은 횟수',
                          style:
                          TextStyle(fontSize: 11, color: playCount > 0 ? Color(0xFF00FFBF) : Colors.grey, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                        ),
                        Text
                        (
                          '$playCount',
                          style:
                          TextStyle(fontSize: 25, color: playCount > 0 ? Color(0xFF00FFBF) : Colors.grey, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding
          (
            padding: const EdgeInsets.only(top: 476),
            child:
            Container
            (
              width: 320,
              height: 50,
              //color: Colors.white,
              child: Row
              (
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:
                [
                  GestureDetector
                  (
                    onTap: ()
                    {
                      isOpenInfo = true;
                      tweenController2.forward(from: 0);
                      setState(() {

                      });
                    },
                    child:
                    Container
                    (
                      alignment: Alignment.center,
                      width:  80,
                      height: 50,
                      //color: Colors.red,
                      child:
                      Text
                      (
                        StringTable().Table![800011]!,
                        style:
                        TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                      ),
                    ),
                  ),
                  GestureDetector
                  (
                    onTap: ()
                    {
                      if (animationState == PopcornAnimationState.START)
                      {
                        animationState = PopcornAnimationState.END;
                        setState(() {
                          controller1.forward(from: 0);
                        });
                      }
                    },
                    child:
                    Container
                    (
                      width:  120,
                      height: 50,
                      //color: Colors.blue,
                      child:
                      Column
                        (
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:
                        [
                          Text
                          (
                            '튀기기',
                            style:
                            TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                          ),
                          Text
                            (
                            '튀기기 횟수 $playCount',
                            style:
                            TextStyle(fontSize: 11, color: Colors.black, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector
                  (
                    onTap: ()
                    {
                      //('on tap start button 2');
                      Get.to(() => ShopPage());
                    },
                    child:
                    Container
                    (
                      alignment: Alignment.center,
                      width:  80,
                      height: 50,
                      //color: Colors.red,
                      child:
                      Text
                      (
                        StringTable().Table![800013]!,
                        style:
                        TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]
      )
    );
  }
  
  Widget infoPopup()
  {
    var tableData = Event2table().tableData[stackCount];

    return
    Visibility
    (
      visible: isOpenInfo,
      child:
      FadeTransition
      (
        opacity: tweenController2,
        child:
        Container
        (
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black45,
          alignment: Alignment.center,
          child:
          Container
          (
            width: 320,
            height: 597,
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: [Color(0xFF043B34), Color(0xFF092D3D)],
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 2, color: Color(0xFF00FFBF)),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child:
            Column
            (
              mainAxisAlignment: MainAxisAlignment.start,
              children:
              [
                Padding
                (
                  padding: EdgeInsets.only(top: 20),
                  child:
                  Container
                  (
                    padding: EdgeInsets.only(bottom: 2),
                    alignment: Alignment.center,
                    width: 120,
                    height: 35,
                    decoration: ShapeDecoration(
                      color: Color(0xFF1E1E1E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child:
                    Text
                    (
                      StringTable().Table![800011]!,
                      style:
                      TextStyle(fontSize: 16, color: Color(0xFF00FFBF), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                InfoPopupItemGroup
                (
                  'assets/images/Reward/reward_event_popcorn/reward_bonus1.png',
                  BonusCalculator(tableData.condition, tableData.rate1),
                  tableData.chance1,
                  'assets/images/Reward/reward_event_popcorn/reward_bonus2.png',
                  BonusCalculator(tableData.condition, tableData.rate2),
                  tableData.chance2
                ),
                SizedBox(height: 20,),
                InfoPopupItemGroup
                (
                  'assets/images/Reward/reward_event_popcorn/reward_bonus3.png',
                  BonusCalculator(tableData.condition, tableData.rate3),
                  tableData.chance3,
                  'assets/images/Reward/reward_event_popcorn/reward_bonus4.png',
                  BonusCalculator(tableData.condition, tableData.rate4),
                  tableData.chance4
                ),
                SizedBox(height: 20,),
                InfoPopupItemGroup
                (
                  'assets/images/Reward/reward_event_popcorn/reward_bonus5.png',
                  BonusCalculator(tableData.condition, tableData.rate5),
                  tableData.chance5,
                  'assets/images/Reward/reward_event_popcorn/reward_bonus6.png',
                  BonusCalculator(tableData.condition, tableData.rate6),
                  tableData.chance6
                ),
                SizedBox(height: 20,),
                InfoPopupItemGroup
                (
                  'assets/images/Reward/reward_event_popcorn/reward_bonus7.png',
                  BonusCalculator(tableData.condition, tableData.rate7),
                  tableData.chance7,
                  'assets/images/Reward/reward_event_popcorn/reward_bonus8.png',
                  BonusCalculator(tableData.condition, tableData.rate8),
                  tableData.chance8
                ),
                SizedBox(height: 5,),
                Text
                (
                  StringTable().Table![800015]!,
                  style:
                  TextStyle(fontSize: 11, color:Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w500,),
                ),
                SizedBox(height: 10,),
                GestureDetector
                (
                  onTap: () {
                    tweenController2.reverse();
                    setState(() {

                    });
                  },
                  child:
                  Container
                  (
                    padding: EdgeInsets.only(bottom: 2),
                    alignment: Alignment.center,
                    width: 164,
                    height: 40,
                    decoration: ShapeDecoration(
                      color: Color(0xFF00FFBF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child:
                    Text
                    (
                      StringTable().Table![800016]!,
                      style:
                      TextStyle(fontSize: 16, color:Colors.black, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget InfoPopupItem(String _bounsIconPath, num _bonusCount, num _bonusPercent)
  {
    return
    Container
    (
      width: 110,
      height: 90,
      //color: Colors.blue,
      child:
      Stack
      (
        children:
        [
            Container
            (
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(top: 26),
              //width: 130,
              //height: 60,
              //color: Colors.grey,
              child:
              Stack
              (
                children:
                [
                  SvgPicture.asset('assets/images/Reward/reward_event_popcorn/reward_event_popcorn_per_frame.svg',),
                  Container
                  (
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.only(bottom: 6),
                    child:
                    Text
                    (
                      SetTableStringArgument(800014, ['$_bonusPercent']),
                      style:
                      TextStyle(fontSize: 18, color:Colors.black, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                    ),
                  ),
                ],
              ),
            ),
            Container
            (
                alignment: Alignment.topCenter,
                child:
                Stack
                (
                  children:
                  [
                    SvgPicture.asset('assets/images/Reward/reward_event_popcorn/reward_event_popcorn_icon_frame.svg',width: 50,height: 50,),
                    Image.asset(_bounsIconPath, width: 50, height: 50,),
                    Container
                    (
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.only(right: 4),
                      alignment: Alignment.bottomRight,
                      child:
                      Text
                      (
                        '+$_bonusCount',
                        style:
                        TextStyle(fontSize: 16, color:Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                      ),
                    ),
                  ],
                )

            ),
        ],
      ),
    );
  }

  Widget InfoPopupItemGroup(String _iconPath1, num _bonusCount1, num _bonusPercent1, String _iconPath2, num _bonusCount2, num _bonusPercent2)
  {
    return
    Container
    (
      child:
      Row
      (
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:
        [
          InfoPopupItem(_iconPath1, _bonusCount1, _bonusPercent1),
          InfoPopupItem(_iconPath2, _bonusCount2, _bonusPercent2),
        ],
      ),
    );
  }

  int BonusCalculator(num _count, num _rate)
  {
    var result = _count * _rate - _count;
    return result.toInt();
  }

  Widget bonusResultPopup()
  {
    var resultBonus = getResultPoint(bonusResult);
    return
    Visibility
    (
      visible: isOpenResult,
      child:
      FadeTransition
      (
        opacity: tweenController,
        child:
        Container
        (
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black45,
          alignment: Alignment.center,
          child:
          Container
          (
            width: 220,
            height: 315,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: [Color(0xFF043B33), Color(0xFF092C3D)],
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 3, color: Color(0xFF00FFBF)),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child:
            Stack
            (
              children:
              [
                SvgPicture.asset('assets/images/Reward/reward_event_popcorn/reward_popcorn_light.svg'),
                Container
                (
                  padding: EdgeInsets.only(left: 2, bottom: 110),
                  alignment: Alignment.center,
                  child:
                  Image.asset('assets/images/Reward/reward_event_popcorn/reward_bonus$bonusResult.png'),
                ),

                Container
                (
                  padding: EdgeInsets.only(top: 40),
                  alignment: Alignment.center,
                  child:
                  Text
                  (
                    SetTableStringArgument(400061, ['${resultBonus.$1}']),
                    style:
                    TextStyle(fontSize: 24, color: Color(0xFF00FFBF), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                  ),
                ),

                Container
                (
                  padding: EdgeInsets.only(top: 110),
                  alignment: Alignment.center,
                  child:
                  Text
                  (
                    SetTableStringArgument(800008, ['${resultBonus.$2}']),
                    style:
                    TextStyle(fontSize: 16, color:Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                  ),
                ),

                Container
                (
                  padding: EdgeInsets.only(bottom: 20),
                  alignment: Alignment.bottomCenter,
                  child:
                  GestureDetector
                  (
                    onTap: ()
                    {
                      tweenController.reverse();
                      animationState = PopcornAnimationState.START;
                      controller1.stop();
                      setState(() {

                      });
                    },
                    child:
                    Container
                    (
                      padding: EdgeInsets.only(bottom: 2),
                      alignment: Alignment.center,
                      width: 164,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: Color(0xFF00FFBF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child:
                      Text
                      (
                        StringTable().Table![800016]!,
                        style:
                        TextStyle(fontSize: 16, color:Colors.black, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                      ),
                    ),
                  ),
                ),
              ]
            ),
          )
        ),
      )
    );
  }

  (int, int) getResultPoint(int _result)
  {
    var tableData = Event2table().tableData[stackCount];

    if (_result == 0)
    {
      return (BonusCalculator(tableData.condition, tableData.rate1), tableData.chance1);
    }
    if (_result == 1)
    {
      return (BonusCalculator(tableData.condition, tableData.rate2), tableData.chance2);
    }
    if (_result == 2)
    {
      return (BonusCalculator(tableData.condition, tableData.rate3), tableData.chance3);
    }
    if (_result == 3)
    {
      return (BonusCalculator(tableData.condition, tableData.rate4), tableData.chance4);
    }
    if (_result == 4)
    {
      return (BonusCalculator(tableData.condition, tableData.rate5), tableData.chance5);
    }
    if (_result == 5)
    {
      return (BonusCalculator(tableData.condition, tableData.rate6), tableData.chance6);
    }
    if (_result == 6)
    {
      return (BonusCalculator(tableData.condition, tableData.rate7), tableData.chance7);
    }
    if (_result == 7)
    {
      return (BonusCalculator(tableData.condition, tableData.rate8), tableData.chance8);
    }

    return (0,0);
  }
}
