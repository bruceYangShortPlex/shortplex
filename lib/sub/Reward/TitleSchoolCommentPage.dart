import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shortplex/sub/Home/HomeData.dart';
import '../../Util/ShortplexTools.dart';
import '../../table/StringTable.dart';
import '../../table/UserData.dart';
import '../ContentInfoPage.dart';
import '../UserInfo/LoginPage.dart';

// void main() async
// {
//   WidgetsFlutterBinding.ensureInitialized();
//   await StringTable().InitTable();
//   runApp(const TitleSchoolCommentPage());
// }

class TitleSchoolCommentPage extends StatefulWidget {
  const TitleSchoolCommentPage({super.key});

  @override
  State<TitleSchoolCommentPage> createState() => _TitleSchoolCommentPageState();
}

class _TitleSchoolCommentPageState extends State<TitleSchoolCommentPage>
{
  var scrollController = ScrollController();

  //comment 관련
  var rankedCommentList = <EpisodeCommentData>[];
  var commentList = <EpisodeCommentData>[];
  var totalCommentCount = 0;
  CommentSortType commentSortType = CommentSortType.created_at;

  TextEditingController textEditingController = TextEditingController();
  FocusNode textFocusNode = FocusNode();

  @override
  void initState()
  {
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

    super.initState();

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
  }

  void onEndOfPage() async
  {
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
  void dispose()
  {
    textFocusNode.dispose();
    textEditingController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return mainWidget(context);
  }

  Widget mainWidget(BuildContext context)
  {
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
                    StringTable().Table![300004]!,
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
            Column
            (
              children:
              [
                SizedBox(height: 60,),
                Container
                (
                  width: 310,
                  height: 209,
                  //color: Colors.green,
                  child:
                  HomeData.to.TitleSchoolImageUrl.isEmpty ?  SizedBox() :
                  Image.network(HomeData.to.TitleSchoolImageUrl),
                ),
                SizedBox(height: 8,),
                titleSchoolCommnet(),
                bottomKeyboard(),
              ],
            ),
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
        height: MediaQuery.of(context).size.height - 345,
        child:
        Column
          (
          children:
          [
            SizedBox
            (
              width: 390.w,
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

  Widget bottomKeyboard()
  {
    return
    Obx(()
    {
      return
      VirtualKeybord(StringTable().Table![100041]!, textEditingController, textFocusNode,
        !UserData.to.isLogin.value,
        0, ()
        {

        },);
    });
  }
}
