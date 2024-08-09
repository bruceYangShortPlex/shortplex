import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gif/gif.dart';
import 'package:shortplex/Util/HttpProtocolManager.dart';
import 'package:shortplex/sub/UserInfo/ShopPage.dart';

import '../../Network/BonusGame_Res.dart';
import '../../Util/ShortplexTools.dart';
import '../../table/Event2Table.dart';
import '../../table/StringTable.dart';
import '../../table/UserData.dart';


enum PopcornAnimationState
{
  START,
  END,
}

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
  int remainCount = 0;
  int stackCount = 0;
  late Timer eventTimer;
  DateTime? endTime;
  Duration? difference;
  bool isOpenInfo = false;
  bool isOpenResult = false;
  int bonusResult = 2;
  var pageList = <Widget>[];
  late AnimationController tweenController;
  late AnimationController tweenController2;
  var prevState1 = AnimationStatus.completed;
  var prevState2 = AnimationStatus.completed;
  String ticketID = '';
  Prize? serverTable;
  String resultBonus = '';
  String resultRate = '';
  int prevPopcornCount = 0;

  void startTimer()
  {
    if (endTime == null)
    {
      return;
    }

    bool hasPassed =  DateTime.now().isAfter(endTime!);

    if (hasPassed)
    {
      if (kDebugMode) {
        print('종료 시간이 지났습니다.');
      }
      endTime = null;
      return;
    }

    difference = endTime!.difference(DateTime.now());
    eventTimer = Timer.periodic(const Duration(minutes: 1), (Timer timer)
    {
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

  Future getInfo() async
  {
    //현재 플레이 가능한 티켓수.
    playCount = 0;
    //이미 사용해서 올라간 단계
    stackCount = 0;

    var usedCount = 0;
    await HttpProtocolManager.to.Get_BonusPageInfo().then((value)
    {
      if (value == null)
      {
        return;
      }

      if (value.data!.expiredAt.isNotEmpty)
      {
        endTime = DateTime.parse(value.data!.expiredAt);
      }

      if (kDebugMode)
      {
        var table = value.data!.prize;
        if (table != null && table.step1 != null)
        {
          for (var item in table.step1!)
          {
            print('Server Table data bonus : ${item.bonus}');
          }
        }
      }

      serverTable = value.data!.prize;

      for(var item in value.data!.items!)
      {
        if (item.userId != UserData.to.userId)
        {
          if (kDebugMode) {
            print('continue');
          }
          continue;
        }

        print('item.bonus / ${item.bonus}');
        //사용하지 않은거.
        if (item.bonus == 0)
        {
          ticketID = item.id;
          ++playCount;
        }
        else
        {
          ++usedCount;
        }

        ++stackCount;
        if(stackCount >= Event2table().tableData.length)
        {
          stackCount = Event2table().tableData.length - 1;
        }
      }

      startTimer();
      setState(()
      {
        remainCount = Event2table().tableData.length - (playCount + usedCount);
        createBonusInfoScroll();
      });
    },);
  }

  @override
  void initState()
  {
    prevPopcornCount = UserData.to.popcornCount.value;
    Get.lazyPut(() => Event2table());

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
    createBonusInfoScroll();
    getInfo();

    //팝콘에니메이션 이벤트 리스너.
    controller1.addListener(()
    {
      if (controller1.status == AnimationStatus.completed )
      {
          isOpenResult = true;
          tweenController.forward(from: 0);
          setState(() {

          });

          if (kDebugMode) {
            print('popcorn animation compelte');
          }

          HttpProtocolManager.to.Get_WalletBalance().then((walletBalanceValue)
          {
            if (walletBalanceValue == null) {
              return;
            }

            for(var item in walletBalanceValue.data!.items!)
            {
              if (item.userId == UserData.to.userId)
              {
                UserData.to.MoneyUpdate(item.popcorns,item.bonus);
                break;
              }
            }
          },);

          getInfo();
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
    pageList.clear();
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

  var trans = false;
  double scaleRatio = 0;
  double destHeigh = 0;
  Widget mainWidget(BuildContext context)
  {
    double screenHSize = MediaQuery.of(context).size.height; // 사용 가능한 화면 높이
    double statusBarHeight = MediaQuery.of(context).padding.top; // 상태 표시줄 높이
    double navigationBarHeight = MediaQuery.of(context).padding.bottom; // 내비게이션 바 높이
    var screen_height = screenHSize + statusBarHeight + navigationBarHeight; // 전체 화면 높이
    destHeigh = 700 / 844 * screen_height;
    scaleRatio = destHeigh / 650;
    var remainSpace = screen_height - (700 * scaleRatio); //650 + 50 을 뺀다.

    // if (kDebugMode) {
    //   print('screen_height : $screen_height');
    //   print('screen_width : ${MediaQuery.of(context).size.width}');
    //   print('scaleRatio : $scaleRatio');
    //   print('remainSpace : $remainSpace');
    // }

    double bottomOffset = 0;
    if (remainSpace >= 0)
    {
      bottomOffset = remainSpace > 0 ? remainSpace * 0.25 : 0;
    }

    if (screen_height < 700)
    {
      trans = true;
    }

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
            padding: trans ? EdgeInsets.zero : EdgeInsets.only(bottom: bottomOffset),
            child:
            trans ?
            SingleChildScrollView
            (
              physics: NeverScrollableScrollPhysics(),
              child:
              Container
              (
                padding: EdgeInsets.only(bottom: 10),
                //color: Colors.red,
                child:
                Column
                (
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                  [
                    Transform.scale
                    (
                      //alignment: Alignment.bottomCenter,
                      scale: scaleRatio,
                      child:
                      Stack
                      (
                        //alignment: Alignment.bottomCenter,
                        children:
                        [
                          remainTimer(),
                          Padding
                          (
                            padding : const EdgeInsets.only(top: 26),
                            child:
                            popcornAnimation()),

                          Padding
                          (
                            padding: const EdgeInsets.only(left: 24, top: 26),
                              child: bounusInfoPageView()
                          ),
                          bonusResultPopup(),
                          infoPopup(),
                        ],
                      ),
                    ),
                  ],
                )
              
              ),
            )
            :
            Transform.scale
            (
              alignment: Alignment.bottomCenter,
              scale: scaleRatio,
              child:
              Stack
              (
                alignment: Alignment.bottomCenter,
                children:
                [
                  remainTimer(),
                  popcornAnimation(),
                  bounusInfoPageView(),
                  bonusResultPopup(),
                  infoPopup(),
                ],
              ),
            ),
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
    Row
    (
      mainAxisAlignment: MainAxisAlignment.center,
      children:
      [
        Container
        (
          //color: Colors.white,
          width: 310,
          height: trans ? destHeigh / scaleRatio :  650,
          alignment: Alignment.topRight,
          child:
          Container
          (
            width: 130,
            height: 60,
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
              padding: const EdgeInsets.only(top: 4, left: 8, right: 8, bottom: 32),
              child:
              Text
              (
                //textAlign: TextAlign.center,
                endTime != null ? SetTableStringArgument(800007, [SubstringDuration(difference!).$1,SubstringDuration(difference!).$2]) : '',
                style:
                TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
              ),
            ),
          ),
        ),
      ],


    );
  }

  Widget bounusInfoPageView()
  {
    return
    Container
    (
      width: 314,
      height: 622,
      //color: Colors.red,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(top: 34),
      //alignment: ,
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
    );
  }

  Widget popcornAnimation()
  {
    var tableData = Event2table().tableData[stackCount];

    //print('stackCount : $stackCount');

    return
    Container
    (
      alignment: Alignment.bottomCenter,
      child:
      Stack
      (
        alignment: Alignment.center,
        children:
        [
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
                    const Center(child: SizedBox()),
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
            Obx
            (()
            {
              if (UserData.to.popcornCount.value != prevPopcornCount)
              {
                prevPopcornCount = UserData.to.popcornCount.value;
                getInfo();
              }

              return
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
                        SetTableStringArgument(800012, ['${tableData.condition}']),
                        style:
                        TextStyle(fontSize: 13,
                          color: Colors.white,
                          fontFamily: 'NotoSans',
                          fontWeight: FontWeight.w500,),
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
                            StringTable().Table![800005]!,
                            style:
                            TextStyle(fontSize: 11,
                              color: remainCount > 0
                                  ? Color(0xFF00FFBF)
                                  : Colors.grey,
                              fontFamily: 'NotoSans',
                              fontWeight: FontWeight.bold,),
                          ),
                          Text
                            (
                            '$remainCount',
                            style:
                            TextStyle(fontSize: 25,
                              color: remainCount > 0
                                  ? Color(0xFF00FFBF)
                                  : Colors.grey,
                              fontFamily: 'NotoSans',
                              fontWeight: FontWeight.bold,),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
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
                      if (playCount <= 0 || ticketID.isEmpty) {
                        return;
                      }

                      setState(() {
                        --playCount;
                      });

                      HttpProtocolManager.to.Send_BonusPlay(ticketID).then((value)
                      {
                        if (value == null) {
                          return;
                        }

                        print('value.userId : ${value.userId} / UserData.to.userId : ${UserData.to.userId}');
                        print('ticketID : ${ticketID} / value.id : ${value.id}');

                        if (value.userId == UserData.to.userId && ticketID == value.id)
                        {
                          print('used ticket id : ${value.id}');

                          setState(() {
                            bonusResult = getResultIndex(value.conditionSum, value.bonus);
                            resultBonus = value.bonus.toString();
                            resultRate = value.percentage.split('.')[0];
                          });

                          print('bonusResult : $bonusResult');
                          print('resultBonus : $resultBonus');
                          print('resultRate : $resultRate');


                          ticketID = '';
                        }

                        if (animationState == PopcornAnimationState.START)
                        {
                          animationState = PopcornAnimationState.END;
                          setState(()
                          {
                            controller1.forward(from: 0);
                          });
                        }
                      },);
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
                            StringTable().Table![800009]!,
                            style:
                            TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                          ),
                          Text
                          (
                            SetTableStringArgument(800010, ['$playCount']),
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
          color: Colors.black54,
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

  int getResultIndex(int _condition_sum, int _bonus)
  {
    var index = 1;
    if (serverTable == null || serverTable!.step1 == null)
    {
      if (kDebugMode) {
        print('table is null');
      }
      return index;
    }

    List<BonusTableData> table = serverTable!.step1!;
    if (_condition_sum == 60)
    {
      table = serverTable!.step2!;
    }
    else if (_condition_sum == 140)
    {
      table = serverTable!.step3!;
    }
    else if (_condition_sum == 340)
    {
      table = serverTable!.step4!;
    }
    else
    {
      print('not found table');
    }

    for(var item in table)
    {
      if (item.bonus < _bonus)
      {
        ++index;
      }
    }

    return index;
  }

  Widget bonusResultPopup()
  {
    //var resultBonus = getResultPoint(bonusResult);

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
                  padding: const EdgeInsets.only(top: 40),
                  alignment: Alignment.center,
                  child:
                  Text
                  (
                    SetTableStringArgument(400061, [resultBonus]),
                    style:
                    const TextStyle(fontSize: 24, color: Color(0xFF00FFBF), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                  ),
                ),
                Container
                (
                  padding: const EdgeInsets.only(top: 110),
                  alignment: Alignment.center,
                  child:
                  Text
                  (
                    SetTableStringArgument(800008, [resultRate]),
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
      return (BonusCalculator(tableData.condition, tableData.rate1), tableData.chance1.toInt());
    }
    if (_result == 1)
    {
      return (BonusCalculator(tableData.condition, tableData.rate2), tableData.chance2.toInt());
    }
    if (_result == 2)
    {
      return (BonusCalculator(tableData.condition, tableData.rate3), tableData.chance3.toInt());
    }
    if (_result == 3)
    {
      return (BonusCalculator(tableData.condition, tableData.rate4), tableData.chance4.toInt());
    }
    if (_result == 4)
    {
      return (BonusCalculator(tableData.condition, tableData.rate5), tableData.chance5.toInt());
    }
    if (_result == 5)
    {
      return (BonusCalculator(tableData.condition, tableData.rate6), tableData.chance6.toInt());
    }
    if (_result == 6)
    {
      return (BonusCalculator(tableData.condition, tableData.rate7), tableData.chance7.toInt());
    }
    if (_result == 7)
    {
      return (BonusCalculator(tableData.condition, tableData.rate8), tableData.chance8.toInt());
    }

    return (0,0);
  }
}
