import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shortplex/sub/Home/HomeData.dart';
import '../../Network/Comment_Res.dart';
import '../../Util/HttpProtocolManager.dart';
import '../../Util/ShortplexTools.dart';
import '../../table/StringTable.dart';
import '../../table/UserData.dart';
import '../ContentInfoPage.dart';
import '../ReplyPage.dart';
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
  CommentSortType commentSortType = CommentSortType.likes;

  TextEditingController textEditingController = TextEditingController();
  FocusNode textFocusNode = FocusNode();

  int downCompletePage = 0;
  int maxPage = 0;
  String academyID = '';

  // int downReplyPage = 0;
  // int maxReplyPage = 0;
  // List<EpisodeCommentData> replyList = <EpisodeCommentData>[];
  // EpisodeCommentData? commentData;
  // String editReplyID = '';
  // int totalCommentReplyCount = 0;
  // bool isActiveReply = false;

  Future getRankComment() async
  {
    if (rankedCommentList.length < 10)
    {
      await HttpProtocolManager.to.Get_TitleSchoolComments(
          academyID, 0, CommentSortType.likes.name).then((value)
      {
        if (value == null) {
          return;
        }

        var commentRes = value;
        var rankCommentStartIndex = rankedCommentList.length;
        //top10
        for (int i = rankCommentStartIndex; i < 10; ++i)
        {
          if (i >= commentRes.data!.items!.length) {
            break;
          }

          var item = commentRes.data!.items![i];

          var commentData = EpisodeCommentData
          (
            name: item.displayname,
            comment: item.content,
            date: GetReleaseTime(item.createdAt!),
            episodeNumber: item.episode_no.toString(),
            iconUrl: item.photourl ?? '',
            ID: item.id!,
            isLikeCheck: item.whoami!.isNotEmpty &&
            item.whoami == UserData.to.userId && item.ilike > 0,
            likeCount: item.likes ?? '0',
            replyCount: item.replies ?? '0',
            isDelete: UserData.to.userId == item.userId,
            commentType: CommentType.NORMAL,
            parentID: item.key!,
            isEdit: false,
            userID: item.userId,
          );

          if (commentData.parentID != academyID)
          {
            if (kDebugMode) {
              print(' !!!!!!!!!!!!!!!!! Wrong ID !!!!!!!!!!!!!!!!!!!!!!!!!!');
            }
          }

          setState(()
          {
            rankedCommentList.add(commentData);
          });
        }
      });
    }
  }

  void getCommentsData([bool _refresh = false])
  {
    if (_refresh)
    {
      for(int i = 0; i < downCompletePage; ++i)
      {
        getComment(i);
      }
    }
    else
    {
      if (downCompletePage > maxPage) {
        return;
      }
      getComment(downCompletePage).then((value) => downCompletePage++);
    }
  }

  Future getComment(int _page) async
  {
    try
    {
      await getRankComment();

      await HttpProtocolManager.to.Get_TitleSchoolComments(academyID, _page, commentSortType.name).then((value)
      {
        maxPage = value!.data!.maxPage;
        commentRefresh(value, false);
      });
    }
    catch(e)
    {
      print('send Comment error : $e');
    }
  }

  void deleteComment(String _id)
  {
    try
    {
      HttpProtocolManager.to.Send_delete_comment(academyID, _id).then((value)
      {
        if (value == null) {
          return;
        }

        totalCommentCount = value.data!.total;

        for(var item  in value.data!.items!)
        {
          print('receive delete id : ${item.id}');

          for(int i = 0; i < rankedCommentList.length; ++i)
          {
            if (rankedCommentList[i].ID == item.id)
            {
              rankedCommentList.removeAt(i);
              //print('delete complete id : ${item.id}');
              setState(() {

              });
              return;
            }
          }

          for(int i = 0; i < commentList.length; ++i)
          {
            if (commentList[i].ID == item.id)
            {
              commentList.removeAt(i);

              //print('delete complete id : ${item.id}');
              setState(() {

              });
              return;
            }
          }
        }
      });
    }
    catch(e)
    {
      print('send Comment error : $e');
    }
  }

  void commentRefresh(CommentRes? _data, bool _isReply)
  {
    if (_data == null)
    {
      print("CommentRefresh data null return");
      return;
    }
    var findComment = false;
    for (var item in _data.data!.items!)
    {
      //var selectList = _isReply ? replyList : commentList;

      //rank에 들어있는건 빼줌.
      if (_isReply == false && commentSortType == CommentSortType.likes)
      {
        findComment = false;
        for(var rankItem in rankedCommentList)
        {
          if (commentList.any((element) => element.ID == rankItem.ID))
          {
            findComment = true;
            break;
          }
        }

        if (findComment) {
          continue;
        }
      }

      if (commentList.any((element) => element.ID == item.id))
      {
        for(int i = 0 ; i < commentList.length; ++i)
        {
          if (commentList[i].ID == item.id)
          {
            commentList[i].name = item.displayname;
            commentList[i].comment = item.content;
            commentList[i].date = GetReleaseTime(item.createdAt!);
            commentList[i].episodeNumber = item.episode_no.toString();
            commentList[i].iconUrl = item.photourl;
            commentList[i].isLikeCheck = item.whoami!.isNotEmpty && item.whoami == UserData.to.userId && item.ilike > 0;
            commentList[i].likeCount = item.likes;
            commentList[i].replyCount = item.replies;
            commentList[i].isDelete = UserData.to.userId ==  item.userId;
            commentList[i].commentType = item.rank > 0 && item.rank < 3 ? CommentType.BEST : CommentType.NORMAL;
            commentList[i].parentID = item.key;
            commentList[i].isEdit = false;
            commentList[i].userID = item.userId;
          }
        }
        continue;
      }

      var commentData = EpisodeCommentData
      (
        name: item.displayname!,
        comment: item.content ?? '',
        date: item.createdAt != null ? GetReleaseTime(item.createdAt!) : '00.00.00',
        episodeNumber: '',
        iconUrl: item.photourl,
        ID: item.id!,
        isLikeCheck: item.whoami!.isNotEmpty && item.whoami == UserData.to.userId && item.ilike > 0,
        likeCount: item.likes,
        replyCount: '${item.replies}',
        isDelete: UserData.to.userId == item.userId,
        commentType: CommentType.NORMAL,
        parentID: item.key,
        isEdit: UserData.to.userId == item.userId,
        userID: item.userId,
      );

      setState(() {
        commentList.add(commentData);
      });
    }

    setState(()
    {
      // if (_isReply)
      // {
      //   totalCommentReplyCount = _data.data!.total;
      // }
      // else
      // {
        totalCommentCount = _data.data!.total;
      //}
    });
  }

  // void getRepliesData([bool _refresh = false])
  // {
  //   if (_refresh)
  //   {
  //     for(int i = 0; i < downReplyPage; ++i)
  //     {
  //       getReplies(i);
  //     }
  //   }
  //   else
  //   {
  //     if (downReplyPage > maxReplyPage)
  //     {
  //       return;
  //     }
  //
  //     getReplies(downReplyPage).then((value) => downReplyPage++);
  //   }
  // }

  // Future getReplies(int _page) async
  // {
  //   try
  //   {
  //     HttpProtocolManager.to.Get_RepliesData(academyID, commentData!.ID, _page).then((value)
  //     {
  //       maxReplyPage = value!.data!.maxPage;
  //       commentRefresh(value, true);
  //       print('Get Replies Complete');
  //     });
  //   }
  //   catch(e)
  //   {
  //     print('send Comment error : $e');
  //   }
  // }

  Future getInfo() async
  {
    await HttpProtocolManager.to.Get_TitleSchoolInfo().then((value)
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

          });
        }
        academyID = item.id;

        getCommentsData();

        break;
      }
    });
  }

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
          scrollController.position.maxScrollExtent)
      {
        onEndOfPage();
      }
    });

    super.initState();

    getInfo();
  }

  void onEndOfPage() async
  {
    // if (isActiveReply)
    // {
    //   if (totalCommentReplyCount > replyList.length)
    //   {
    //     getRepliesData();
    //   }
    // }
    // else
    // {
      if (totalCommentCount > (commentList.length + rankedCommentList.length))
      {
        getCommentsData();
      }
    //}
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
                titleSchoolComment(),
                bottomKeyboard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget titleSchoolComment()
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
              width: MediaQuery.of(context).size.width,
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
                      if (commentSortType == CommentSortType.likes)
                      {
                        return;
                      }
                      //좋아요순 누름.
                      setState(()
                      {
                        commentSortType = CommentSortType.likes;
                        downCompletePage = 0;
                        commentList.clear();
                        getCommentsData();
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
                      if (commentSortType == CommentSortType.created_at) {
                        return;
                      }
                      //최신순 누름.
                      setState(()
                      {
                        commentSortType = CommentSortType.created_at;
                        downCompletePage = 0;
                        commentList.clear();
                        getCommentsData();
                      });
                    },
                    child:
                    Container
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
                                  if (HttpProtocolManager.to.connecting)
                                  {
                                    return;
                                  }

                                  if (UserData.to.isLogin.value == false)
                                  {
                                    showDialogTwoButton(StringTable().Table![600018]!, '',
                                            ()
                                        {
                                          Get.to(() => LoginPage());
                                        });
                                    return;
                                  }

                                  //var item = episodeCommentList.firstWhere((element) => element.ID == id);
                                  var value = data.isLikeCheck! ? -1 : 1;
                                  HttpProtocolManager.to.Send_Stat(id, value, Comment_CD_Type.academy, Stat_Type.like)
                                      .then((value)
                                  {
                                    for(var item in value!.data!)
                                    {
                                      if (data.ID == item.key)
                                      {
                                        HttpProtocolManager.to.Get_Comment(data.parentID!, data.ID).then((value1)
                                        {
                                          if (value1 == null)
                                          {
                                             return;
                                          }
                                          var resData = value1.data!.items!.firstWhere((element) => element.id == id);
                                          if (UserData.to.userId == resData.whoami)
                                          {
                                            setState(()
                                            {
                                              data.likeCount = resData.likes;
                                              data.isLikeCheck = resData.whoami!.isNotEmpty && resData.whoami == UserData.to.userId && resData.ilike > 0;
                                            });
                                          }
                                        },);
                                        break;
                                      }
                                    }
                                  });
                                },
                                (id)
                                {
                                  if (data == id)
                                  {
                                    data.isAcademy = true;
                                    UserData.to.commentChange.value = '';
                                    Get.to(() => const ReplyPage(),
                                        arguments: data);
                                  }
                                },
                                (id)
                                {
                                  //TODO : 수정하기 버튼 처리
                                },
                                (id)
                                {
                                  deleteComment(id);
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
                          if (HttpProtocolManager.to.connecting)
                          {
                            return;
                          }

                          if (UserData.to.isLogin.value == false)
                          {
                            showDialogTwoButton(StringTable().Table![600018]!, '',
                              ()
                            {
                              Get.to(() => LoginPage());
                            });
                            return;
                          }

                          //var item = episodeCommentList.firstWhere((element) => element.ID == id);
                          var value = commentList[i].isLikeCheck! ? -1 : 1;
                          HttpProtocolManager.to.Send_Stat(id, value, Comment_CD_Type.academy, Stat_Type.like)
                              .then((value)
                          {
                            for(var item in value!.data!)
                            {
                              if (commentList[i].ID == item.key)
                              {
                                HttpProtocolManager.to.Get_Comment(commentList[i].parentID!, commentList[i].ID).then((value1)
                                {
                                  if (value1 == null)
                                  {
                                    return;
                                  }
                                  var resData = value1.data!.items!.firstWhere((element) => element.id == id);
                                  if (UserData.to.userId == resData.whoami)
                                  {
                                    setState(()
                                    {
                                      commentList[i].likeCount = resData.likes;
                                      commentList[i].isLikeCheck = resData.whoami!.isNotEmpty && resData.whoami == UserData.to.userId && resData.ilike > 0;
                                    });
                                  }
                                },);
                                break;
                              }
                            }
                          });
                        },
                        (id)
                        {
                          if (commentList[i].ID == id)
                          {
                            commentList[i].isAcademy = true;
                            UserData.to.commentChange.value = '';
                            Get.to(() => const ReplyPage(),
                                arguments: commentList[i]);
                          }
                        },
                        (id)
                        {
                          //TODO : 수정하기 버튼 처리


                        },
                        (id)
                        {
                          deleteComment(id);
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
