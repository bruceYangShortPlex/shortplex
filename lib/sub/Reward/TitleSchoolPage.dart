import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shortplex/sub/Reward/TitleSchoolHistoryPage.dart';
import 'package:shortplex/table/UserData.dart';

import '../../Util/ShortplexTools.dart';
import '../../table/StringTable.dart';
import '../ContentInfoPage.dart';
import '../UserInfo/LoginPage.dart';


void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await StringTable().InitTable();
  Get.lazyPut(() => UserData());
  runApp(const TitleSchoolPage());
}

enum TitleSchoolPageType
{
  INFO,
  COMMENT,
}

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

  String titleCommenter = '홍길동';
  String titleComment = '아버지를 아버지라 부르지 못하고 형을 형이라 부르지 못하는김에 좀 털자';
  int titleCommentReplyCount = 2000;
  TitleSchoolPageType pageType = TitleSchoolPageType.INFO;

  //comment 관련
  var rankedCommentList = <EpisodeCommentData>[];
  var commentList = <EpisodeCommentData>[];
  var scrollController = ScrollController();
  var totalCommentCount = 0;
  CommentSortType commentSortType = CommentSortType.created_at;


  TextEditingController textEditingController = TextEditingController();
  FocusNode textFocusNode = FocusNode();

  void startTimer()
  {
    schoolTimer = Timer.periodic(const Duration(minutes: 1), (Timer timer)
    {
        if (mounted)
        {
          endTimeDifference = endTimeDifference! - const Duration(minutes: 1);
          if (endTimeDifference! < Duration.zero)
          {
            timer.cancel();
            endTimeDifference = Duration.zero;
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

  void onEndOfPage() async
  {
    if (pageType != TitleSchoolPageType.COMMENT)
      return;

    try
    {
      //여기서 리스트 요청하고 만들고 해야한다.
      // Replace with your method to fetch data from the server.
      final newItems = await Future.delayed(Duration(seconds: 1),
              ()
          {

            for(int i = 0; i < 10; ++i)
            {
              var commentData = EpisodeCommentData
              (
                name: '황후마마가 돌아왔다.',
                comment: '이건 재미있다. 무조건 된다고 생각한다.',
                date: '24.09.06',
                episodeNumber: '',
                iconUrl: '',
                ID: i.toString(),
                isLikeCheck: i % 2 == 0,
                likeCount: '12',
                replyCount: '3',
                isDelete: i == 0,
                commentType: CommentType.NORMAL, parentID: '',
                isEdit: false,
                userID: '',
              );
              commentList.add(commentData);
            }
            setState(()
            {

            });

          }
      );
    }
    catch (e)
    {
      print(e);
    }
  }

  @override
  void initState()
  {
    super.initState();
    endTime = DateTime.now().add(Duration(minutes: 3));
    endTimeDifference = endTime!.difference(DateTime.now());

    // FocusNode에 리스너 추가
    textFocusNode.addListener(()
    {
      if (textFocusNode.hasFocus)
      {
        if (UserData.to.isLogin.value == false)
        {
          textFocusNode.unfocus();

          showDialogTwoButton(StringTable().Table![600018]!, '',
                  ()
              {
                Get.to(() => LoginPage());
              });
        }
      }
      else
      {
        // CupertinoTextField가 포커스를 잃었을 때 실행할 코드
        textEditingController.text = '';
      }
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        onEndOfPage();
      }
    });

    for(int i = 0; i < 10; ++i)
    {
      var commentData = EpisodeCommentData
        (
        name: '황후마마가 돌아왔다.',
        comment: '이건 재미있다. 무조건 된다고 생각한다.',
        date: '24.09.06',
        episodeNumber: '',
        iconUrl: '',
        ID: i.toString(),
        isLikeCheck: i % 2 == 0,
        likeCount: '12',
        replyCount: '3',
        isDelete: i == 0,
        commentType: CommentType.TOP10,
        parentID: '',
        isEdit: false,
        userID: '',
      );
      rankedCommentList.add(commentData);
    }

    for(int i = 0; i < 6; ++i)
    {
      var commentData = EpisodeCommentData
        (
        name: '황후마마가 돌아왔다.',
        comment: '이건 재미있다. 무조건 된다고 생각한다.',
        date: '24.09.06',
        episodeNumber: '',
        iconUrl: '',
        ID: i.toString(),
        isLikeCheck: i % 2 == 0,
        likeCount: '12',
        replyCount: '3',
        isDelete: i == 0,
        commentType: CommentType.NORMAL,
        parentID: '',
        isEdit: false,
        userID: '',
      );
      commentList.add(commentData);
    }

    startTimer();
  }

  @override
  void dispose() {
    schoolTimer.cancel();
    textFocusNode.dispose();
    textEditingController.dispose();
    scrollController.dispose();
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
                  physics: pageType == TitleSchoolPageType.INFO ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
                  controller: scrollController,
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
                                                  formatDuration(
                                                      endTimeDifference!).$1,
                                                  formatDuration(
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
                                  child: Container
                                    (
                                    height: 260,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 30,),
                          pageType == TitleSchoolPageType.INFO ?
                          info() : titleSchoolCommnet(),
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
              pageType = TitleSchoolPageType.COMMENT;
              scrollController.jumpTo(0);
              setState(() {

              });
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
                                      StringTable().Table![300037]!,
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
                                      titleCommenter,
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
    pageType == TitleSchoolPageType.COMMENT ?
    Obx(()
    {
      return
      VirtualKeybord(StringTable().Table![100041]!, textEditingController, textFocusNode,
      !UserData.to.isLogin.value,
      0, ()
      {

      },);
    })
    :
    Align
    (
      alignment: Alignment.bottomCenter,
      child:
      GestureDetector
      (
        onTap: ()
        {
          pageType = TitleSchoolPageType.COMMENT;
          scrollController.jumpTo(0);
          setState(() {

          });
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

  Widget titleSchoolCommnet()
  {
    return
    Container
    (
      height: 400,
      child:
        Column
        (
          children:
          [
            SizedBox
              (
              width: 390,
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
                      padding: EdgeInsets.only(left: 30, bottom: 1),
                      child:
                      Text
                        (
                        '${StringTable().Table![100026]!} (${totalCommentCount})',
                        style:
                        TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                      ),
                    ),
                  ),
                  GestureDetector
                    (
                    onTap: ()
                    {
                      setState(()
                      {
                        commentSortType = CommentSortType.likes;
                      });
                    },
                    child: Container
                      (
                      width: 73,
                      height: 26,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF1E1E1E),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1.50, color: commentSortType == CommentSortType.likes ? const Color(0xFF00FFBF) : const Color(0xFF878787)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(bottom: 1),
                      child:
                      Text
                        (
                        StringTable().Table![100035]!,
                        style:
                        TextStyle(fontSize: 11, color: commentSortType == CommentSortType.likes ? Colors.white : const Color(0xFF878787), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  GestureDetector
                    (
                    onTap: ()
                    {
                      setState(()
                      {
                        commentSortType = CommentSortType.created_at;
                      });
                    },
                    child: Container
                      (
                      width: 73,
                      height: 26,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF1E1E1E),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1.50, color: commentSortType == CommentSortType.created_at ? Color(0xFF00FFBF) : Color(0xFF878787)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(bottom: 1),
                      child:
                      Text
                        (
                        StringTable().Table![100036]!,
                        style:
                        TextStyle(fontSize: 11, color: commentSortType == CommentSortType.created_at ? Colors.white : const Color(0xFF878787), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Expanded
            (
              child:
              SingleChildScrollView
              (
                child:
                Column
                  (
                  children:
                  [
                    const SizedBox(height: 10,),
                    Stack
                      (
                      alignment: Alignment.topCenter,
                      children:
                      [
                        Container
                          (
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(top: 20),
                            child:
                            Image.asset('assets/images/Reward/reward_Top10_BG.png',width: 390, height: 1024,)
                        ),
                        Container
                          (
                          height: 300,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black, Colors.transparent],
                            ),
                          ),
                        ),
                        Padding
                          (
                          padding: EdgeInsets.only(top: 744),
                          child:
                          Container
                            (
                            height: 300,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.black, Colors.transparent],
                              ),
                            ),
                          ),
                        ),
                        Column
                          (
                          children:
                          [
                            Image.asset('assets/images/Reward/reward_Top10_text.png'),
                            const SizedBox(height: 20,),
                            for(var data in rankedCommentList)
                              CommentWidget
                                (
                                data,
                                false,
                                    (id)
                                {
                                  //TODO : 좋아요 버튼 처리
                                  print(id);
                                },
                                    (id)
                                {
                                  //TODO : 댓글의 답글 열기 버튼 처리
              
                                },
                                    (id)
                                {
                                  //TODO : 수정하기 버튼 처리
              
                                },
                                    (id)
                                {
                                  //TODO : 삭제 버튼 처리
                                },
                              ),
                          ],
                        )
              
                      ],
                    ),
                    const SizedBox(height: 40,),
                    Stack
                      (
                      alignment: Alignment.center,
                      children:
                      [
                        Divider(height: 10, color: Colors.white, indent: 10, endIndent: 10, thickness: 1,),
                        Container
                          (
                          color: Colors.black,
                          padding: EdgeInsets.only(bottom: 3, left: 10, right: 10),
                          child:
                          Text
                            (
                            textAlign: TextAlign.center,
                            StringTable().Table![300038]!,
                            style:
                            TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30,),
                    for(int i = 0; i < commentList.length; ++i)
                      CommentWidget
                        (
                        commentList[i],
                        false,
                            (id)
                        {
                          //TODO : 좋아요 버튼 처리
                          print(id);
                        },
                            (id)
                        {
                          //TODO : 댓글의 답글 열기 버튼 처리
              
                        },
                            (id)
                        {
                          //TODO : 수정하기 버튼 처리
              
                        },
                            (id)
                        {
                          //TODO : 삭제 버튼 처리
                        },
                      ),
                    const SizedBox(height: 40,),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return mainWidget(context);
  }
}
