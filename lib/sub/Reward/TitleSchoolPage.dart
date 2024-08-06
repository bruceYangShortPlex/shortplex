import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shortplex/sub/Reward/TitleSchoolCommentPage.dart';
import 'package:shortplex/sub/Reward/TitleSchoolHistoryPage.dart';
import 'package:shortplex/table/UserData.dart';

import '../../Util/HttpProtocolManager.dart';
import '../../Util/ShortplexTools.dart';
import '../../table/StringTable.dart';
import '../ContentInfoPage.dart';
import '../Home/HomeData.dart';
import '../UserInfo/LoginPage.dart';

// void main() async
// {
//   WidgetsFlutterBinding.ensureInitialized();
//   await StringTable().InitTable();
//   Get.lazyPut(() => UserData());
//   runApp(const TitleSchoolPage());
// }

class TitleSchoolPage extends StatefulWidget {
  const TitleSchoolPage({super.key});

  @override
  State<TitleSchoolPage> createState() => _TitleSchoolPageState();
}

class _TitleSchoolPageState extends State<TitleSchoolPage>
{
  late Timer schoolTimer;
  DateTime? endTime;
  Duration? endTimeDifference;
  int bonusCount = 10;

  String commentDisplayName = '';
  String titleComment = '';
  int titleCommentReplyCount = 0;
  String titleSchoolImageUrl = '';

  void startTimer()
  {
    if (endTimeDifference == Duration.zero)
    {
      return;
    }

    schoolTimer = Timer.periodic(const Duration(minutes: 1), (Timer timer)
    {
        if (mounted)
        {
          endTimeDifference = endTimeDifference! - const Duration(minutes: 1);
          if (endTimeDifference! < Duration.zero)
          {
            timer.cancel();
            endTimeDifference = Duration.zero;
            initDayData();
          }
          setState(()
          {

          });
        }
        else
        {
          timer.cancel();
        }
      },
    );
  }

  initDayData()
  {
    var now = DateTime.now();
    endTime = DateTime(now.year, now.month, now.day + 1, 0, 0, 0);
    endTimeDifference = endTime!.difference(DateTime.now());

    HttpProtocolManager.to.Get_TitleSchoolInfo().then((value)
    {
      if (value == null) {
        return;
      }

      for(var item in value.data!.items!)
      {
        if (HomeData.to.titleSchoolImageUrl != item.imageUrl)
        {
          HomeData.to.titleSchoolImageUrl = item.imageUrl;
          setState(() {
            titleSchoolImageUrl = item.imageUrl;
          });
        }

        getBestComment(item.id);

        break;
      }
    });
  }

  getBestComment(String _academyID)
  {
    HttpProtocolManager.to.Get_TitleSchoolComments(_academyID, 0, CommentSortType.likes.name).then((value)
    {
      if (value == null)
      {
        if (kDebugMode) {
          print('comment null');
        }
        return;
      }

      if (value.data!.items!.isEmpty)
      {
        if (kDebugMode) {
          print('comment isEmpty');
        }
        return;
      }

      var item = value.data!.items![0];

      var likeCount = 0;
      if (int.tryParse(item.likes!) != null)
      {
        likeCount = int.parse(item.likes!);
      }

      setState(() {
        titleCommentReplyCount = likeCount;
        commentDisplayName = item.displayname!;
        titleComment = item.content!;
      });
    },);
  }

  @override
  void initState()
  {
    titleSchoolImageUrl = HomeData.to.titleSchoolImageUrl;
    initDayData();

    startTimer();

    super.initState();
  }

  @override
  void dispose() {
    schoolTimer.cancel();
    super.dispose();
  }

  Widget mainWidget(BuildContext context) =>
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
                      StringTable().Table![300002]!,
                      style:
                      TextStyle(fontSize: 15,
                        color: Colors.white,
                        fontFamily: 'NotoSans',
                        fontWeight: FontWeight.bold,),
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
            Stack
            (
              children:
              [
                SingleChildScrollView
                (
                  //controller: scrollController,
                  child:
                  Container
                  (
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      //height: MediaQuery.of(context).size.height,
                      //color: Colors.blue,
                      child:
                      Column
                      (
                        children:
                        [
                          Padding
                          (
                            padding: const EdgeInsets.only(left: 35, top: 60),
                            child:
                            Container
                            (
                              width: 390,
                              alignment: Alignment.centerLeft,
                              child:
                              Text
                                (
                                StringTable().Table![300004]!,
                                style:
                                TextStyle(fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'NotoSans',
                                  fontWeight: FontWeight.bold,),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container
                          (
                            width: 390,
                            height: 287,
                            //color: Colors.blue,
                            child:
                            Stack
                            (
                              children:
                              [
                                Align
                                (
                                  alignment: Alignment.topRight,
                                  child:
                                  Padding
                                    (
                                    padding: const EdgeInsets.only(right: 30),
                                    child:
                                    Container
                                    (
                                      alignment: Alignment.topCenter,
                                      width: 130,
                                      height: 55,
                                      decoration: ShapeDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment(0.98, -0.18),
                                          end: Alignment(-0.98, 0.18),
                                          colors: [
                                            Color(0xFF033C32),
                                            Color(0xFF0A293E)
                                          ],
                                        ),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1,
                                            strokeAlign: BorderSide
                                                .strokeAlignOutside,
                                            color: Color(0xFF0A2022),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              15),
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
                                            endTime != null
                                                ? SetTableStringArgument(800007,
                                                [
                                                  SubstringDuration(
                                                      endTimeDifference!).$1,
                                                  SubstringDuration(
                                                      endTimeDifference!).$2
                                                ])
                                                : '',
                                            style:
                                            TextStyle(fontSize: 14,
                                              color: Colors.white,
                                              fontFamily: 'NotoSans',
                                              fontWeight: FontWeight.bold,),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align
                                (
                                  alignment: Alignment.bottomCenter,
                                  child: 
                                  Container
                                  (
                                    height: 260,
                                    //color: Colors.grey,
                                    child:
                                    titleSchoolImageUrl.isEmpty ? SizedBox() :
                                    Image.network(titleSchoolImageUrl,),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 30,),
                          info(),
                        ],
                      )
                  ),
                ),
                bottomCommentButton(context),
              ],
            ),
          ),
        ),
      );

  Widget info()
  {
    return
      Column
      (
        children:
        [
          GestureDetector
          (
            onTap: ()
            {
              Get.to(() => const TitleSchoolCommentPage());
            },
            child: Container
            (
              width: 350,
              height: 60,
              decoration: ShapeDecoration(
                color: Color(0xFF242424),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2, color: Color(0xFF00FFBF)),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child:
              Row
              (
                children:
                [
                  SizedBox(width: 20,),
                  profileRect(32, ''),
                  Expanded
                  (
                    child:
                    Container
                    (
                      //color: Colors.grey,
                      child:
                      Column
                      (
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          SizedBox(height: 10,),
                          Row
                          (
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                              Container
                                (
                                width: 40,
                                height: 15,
                                //color: Colors.yellow,
                                //padding: EdgeInsets.zero,
                                alignment: Alignment.center,
                                child:
                                Container
                                (
                                  width: 30,
                                  height: 13,
                                  decoration: ShapeDecoration(
                                    color: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(width: 0.80, color: Color(0xFF00FFBF)),
                                      borderRadius: BorderRadius.circular(3),
                                    ),

                                  ),
                                  padding: EdgeInsets.all(1),
                                  child:
                                  FittedBox
                                  (
                                    alignment: Alignment.topCenter,
                                    child:
                                    Text
                                    (
                                      StringTable().Table![500015]!,
                                      style:
                                      TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                                    ),
                                  ),
                                ),

                              ),
                              Expanded
                              (
                                  child:
                                  Container
                                    (
                                    height: 15,
                                    padding: EdgeInsets.only(bottom: 2),
                                    //color: Colors.blue,
                                    child:
                                    Text
                                    (
                                      commentDisplayName,
                                      style:
                                      TextStyle(fontSize: 10, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                                    ),
                                  )
                              )
                            ],
                          ),
                          SizedBox(height: 5,),
                          Expanded
                            (
                              child:
                              Container
                                (
                                padding: EdgeInsets.only(left: 5),
                                alignment: Alignment.centerLeft,
                                height: 15,
                                //color: Colors.red,
                                child:
                                Text
                                  (
                                  overflow: TextOverflow.ellipsis,
                                  titleComment,
                                  style:
                                  TextStyle(fontSize: 10, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.normal,),
                                ),
                              )
                          ),
                          SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  ),
                  Container
                    (
                    width: 105,
                    //color: Colors.green,
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(8),
                    child:
                    Text
                      (
                      SetStringArgument( '${StringTable().Table![100026]!} ({0})', ['${NumberFormat('#,###').format(titleCommentReplyCount)}']),
                      style:
                      TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 30,),
          Container
            (
            width: 220,
            height: 40,
            decoration: ShapeDecoration(
              color: Color(0xFF242424),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 2),
            child:
            Text
              (
              StringTable().Table![300030]!,
              style:
              TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
            ),
          ),
          SizedBox(height: 30,),
          Container
            (
            width: 220,
            height: 122,
            decoration: ShapeDecoration(
              color: Color(0xFF242424),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.50, color: Color(0xFFA0A0A0)),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child:
            Column
              (
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                Text
                  (
                  StringTable().Table![300031]!,
                  style:
                  TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                ),
                SizedBox(height: 15,),
                Text
                  (
                  StringTable().Table![300032]!,
                  style:
                  TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                ),
                SizedBox(height: 15,),
                Text
                  (
                  StringTable().Table![300033]!,
                  style:
                  TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                ),
              ],
            ),
          ),
          SizedBox(height: 25,),
          Container
            (
            width: 330,
            //color: Colors.grey,
            child:
            Column
              (
              children:
              [
                Text
                  (
                  StringTable().Table![300028]!,
                  style:
                  TextStyle(fontSize: 13, color: Colors.grey, fontFamily: 'NotoSans', fontWeight: FontWeight.w500,),
                ),
                SizedBox(height: 15,),
                Text
                  (
                  SetTableStringArgument(300029, ['$bonusCount']),
                  style:
                  TextStyle(fontSize: 13, color: Colors.grey, fontFamily: 'NotoSans', fontWeight: FontWeight.w500,),
                ),
              ],
            ),
          ),
          SizedBox(height: 30,),
          Divider(height: 10, color: Colors.white38, indent: 10, endIndent: 10, thickness: 1,),
          Container
          (
              width: 330,
              height: 30,
              //color: Colors.grey,
              child:
              Row
              (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                [
                  Text
                    (
                    StringTable().Table![300034]!,
                    style:
                    TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                  ),
                  IconButton
                  (
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 1),
                    color: Colors.white,
                    iconSize: 20,
                    icon: const Icon(Icons.arrow_forward_ios), onPressed: ()
                    {
                      Get.to(() => TitleSchoolHistoryPage());
                    },
                  ),
                ],
              )
          ),
          Divider(height: 10, color: Colors.white38, indent: 10, endIndent: 10, thickness: 1,),
          SizedBox(height: 30,),
          Stack
          (
            alignment: Alignment.center,
            children:
            [
              Divider(height: 10, color: Colors.white.withOpacity(0.6), indent: 10, endIndent: 10, thickness: 1,),
              Container
              (
                color: Colors.black,
                padding: EdgeInsets.only(bottom: 3, left: 10, right: 10),
                child:
                Text
                  (
                  textAlign: TextAlign.center,
                  StringTable().Table![300035]!,
                  style:
                  TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Container
          (
            width: 306,
            child: Text
              (
              //textAlign: TextAlign.left,
              StringTable().Table![300036]!,
              style:
              TextStyle(fontSize: 13, color: Colors.grey, fontFamily: 'NotoSans', fontWeight: FontWeight.w500,),
            ),
          ),
          SizedBox(height: 90,),
        ],
      );
  }

  Widget bottomCommentButton(BuildContext context)
  {
    return
    Align
    (
      alignment: Alignment.bottomCenter,
      child:
      GestureDetector
      (
        onTap: ()
        {
          Get.to(() => const TitleSchoolCommentPage());
        },
        child:
        Container
        (
          height: 44,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child:
          Row
          (
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>
            [
              profileRect(26, ''),
              Expanded
              (
                child:
                Container
                (
                  padding: EdgeInsets.only(left: 20, bottom: 2),
                  alignment: Alignment.centerLeft,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: Color(0xFF1E1E1E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child:
                  Text
                  (
                    StringTable().Table![100041]!,
                    style: TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'NotoSans', fontWeight: FontWeight.w500,),
                  ),
                ),
              ),
              Padding
              (
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: Icon(Icons.send, color: Colors.grey,),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return mainWidget(context);
  }
}
