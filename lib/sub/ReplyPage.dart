import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shortplex/Network/Comment_Res.dart';
import '../Util/HttpProtocolManager.dart';
import '../Util/ShortplexTools.dart';
import '../table/StringTable.dart';
import '../table/UserData.dart';
import 'ContentInfoPage.dart';
import 'UserInfo/LoginPage.dart';

class ReplyPage extends StatefulWidget
{
  const ReplyPage({super.key});

  @override
  State<ReplyPage> createState() => _ReplyPageState();
}

class _ReplyPageState extends State<ReplyPage>
{
  ContentData? contentData;
  String replyID = '';
  List<EpisodeCommentData> replyList = <EpisodeCommentData>[];
  var scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  FocusNode textFocusNode = FocusNode();
  bool prevLogin = false;

  var commentData = EpisodeCommentData
  (
    name: '',
    comment: '',
    date: '',
    episodeNumber: '',
    iconUrl: '',
    ID: '',
    isLikeCheck: false,
    likeCount: '',
    replyCount: '',
    isDelete: false,
    commentType: CommentType.NORMAL,
    parentID: '',
    isEdit: false,
    userID: '',
  );

  int totalCount = 0;
  int downReplyPage = 0;
  int maxReplyPage = 0;

  void GetRepliesData([bool _refresh = false])
  {
    if (_refresh)
    {
      for(int i = 0; i < downReplyPage; ++i)
      {
        GetReplies(i);
      }
    }
    else
    {
      if (downReplyPage > maxReplyPage)
      {
        return;
      }

      GetReplies(downReplyPage).then((value) => downReplyPage++);
    }
  }

  Future GetReplies(int _page) async
  {
    try
    {
      HttpProtocolManager.to.Get_RepliesData(commentData.parentID!, commentData.ID, _page).then((value)
      {
        if (value == null)
        {
          if (kDebugMode) {
            print('GetReplies value null RETURN');
          }
          return;
        }
        totalCount = value.data!.total;
        maxReplyPage = value.data!.maxPage;
        SetRepliesData(value);
        if (kDebugMode) {
          print('Get Replies Complete');
        }
      });
    }
    catch(e)
    {
      if (kDebugMode) {
        print('send Comment error : $e');
      }
    }
  }

  void SetRepliesData(CommentRes _value)
  {
    for(var item in _value.data!.items!)
    {
      if (replyList.any((element) => element.ID == item.id))
      {
        var refreshData = replyList.firstWhere((element) => element.ID == item.id);
        refreshData.name = item.displayname;
        refreshData.comment = item.content;
        refreshData.date = ConvertCommentDate(item.createdAt!);
        refreshData.episodeNumber = item.episode_no.toString();
        refreshData.iconUrl = item.photourl;
        refreshData.isLikeCheck = item.whoami!.isNotEmpty && item.whoami == UserData.to.userId && item.ilike > 0;
        refreshData.likeCount = item.likes;
        refreshData.replyCount = item.replies;
        refreshData.isDelete = UserData.to.userId ==  item.userId;
        refreshData.commentType = item.rank > 0 && item.rank < 3 ? CommentType.BEST : CommentType.NORMAL;
        refreshData.parentID = item.key;
        refreshData.isEdit = UserData.to.userId == item.userId;
        refreshData.userID = item.userId;
        continue;
      }

      var data = EpisodeCommentData
      (
        name: item.displayname,
        comment: item.content,
        date: item.createdAt != null ? ConvertCommentDate(item.createdAt!) : '',
        episodeNumber: '',
        iconUrl: item.photourl,
        ID: item.id!,
        isLikeCheck: item.whoami!.isNotEmpty && item.whoami == UserData.to.userId && item.ilike > 0,
        likeCount: item.likes,
        replyCount: item.replies,
        isDelete: UserData.to.userId ==  item.userId,
        commentType: CommentType.NORMAL,
        parentID: commentData.ID,
        isEdit: UserData.to.userId == item.userId,
        userID: item.userId,
      );
      replyList.add(data);
    }

    setState(() {

    });
  }

  @override
  void initState()
  {
    prevLogin = UserData.to.isLogin.value;
    super.initState();
    commentData = Get.arguments;
    GetRepliesData();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        onEndOfPage();
      }
    });

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
        replyID = '';
        textEditingController.text = '';
        print('lost focus');
      }
    });
  }

  @override
  void dispose()
  {
    textEditingController.dispose();
    textFocusNode.dispose();
    scrollController.dispose();
    replyList.clear();
    super.dispose();
  }

  void onEndOfPage() async
  {
    try
    {
      if (totalCount > replyList.length)
      {
        GetRepliesData();
      }
    }
    catch (e)
    {
      print(e);
    }
  }

  bool connecting = false;

  void SendReply() async
  {
    try
    {
      connecting = true;
      if (replyID.isNotEmpty)
      {
        var item = replyList.firstWhere((element) => element.ID == replyID);
        if (item.comment != null && item.comment == textEditingController.text)
        {
          return;
        }

        await HttpProtocolManager.to.Send_edit_reply
          (
            commentData.parentID!, textEditingController.text, commentData.ID, replyID, Comment_CD_Type.episode).then((value) {
          for(var item in value!.data!.items!)
          {
            for(int i = 0 ; i < replyList.length; ++i)
            {
              if (replyList[i].ID == item.id && replyList[i].comment != item.content)
              {
                replyList[i].comment = item.content;
                break;
              }
            }
          }
          setState(() {

          });
          connecting = false;
        });
      }
      else
      {
        await HttpProtocolManager.to.Send_Reply(
            commentData.parentID!, textEditingController.text, commentData.ID, Comment_CD_Type.episode).then((value)
        {
          CommentUpdate();
          if (value == null) {
            return;
          }
          SetRepliesData(value);
          connecting = false;
        });
      }
    }
    catch(e)
    {
      connecting = false;
    }
  }

  void CommentUpdate() async
  {
    UserData.to.commentChange.value = '';
    try
    {
      await HttpProtocolManager.to.Get_Comment(commentData.parentID!, commentData.ID).then((value)
      {
        for(var item in value!.data!.items!)
        {
          if (item.id == commentData.ID)
          {
            UserData.to.commentChange.value = commentData.ID;
            commentData.likeCount = item.likes;
            commentData.isLikeCheck = item.whoami!.isNotEmpty && item.whoami == UserData.to.userId && item.ilike > 0;
            commentData.replyCount = item.replies;
            connecting = false;
            setState(() {

            });
            break;
          }
        }
      });
    }
    catch(e)
    {
      print('send Comment error : $e');
    }
  }

  void DeleteReply(String _replyID) async
  {
    try
    {
      await HttpProtocolManager.to.Send_delete_reply(commentData.parentID!,commentData.ID, _replyID).then((value)
      {
        for(var item  in value!.data!.items!)
        {
          for(int i = 0; i < replyList.length; ++i)
          {
            if (replyList[i].ID == item.id)
            {
              replyList.removeAt(i);
              setState(() {

              });
              break;
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

  @override
  Widget build(BuildContext context)
  {
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
      resizeToAvoidBottomInset: false,
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
                StringTable().Table![100046]!,
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
        Padding
        (
          padding: EdgeInsets.only(top: 10),
          child:
          Stack
          (
            children:
            [
              Obx(()
              {
                if (prevLogin == false && UserData.to.isLogin.value == true)
                {
                  GetRepliesData(true);
                }
                prevLogin = UserData.to.isLogin.value;
                return
                ReplyPopup
                  (
                    scrollController, commentData, replyList,
                    (id)
                    {
                      if (connecting) {
                        return;
                      }

                      //comment에 좋아요 눌렀다.
                      UserData.to.commentChange.value = id;
                      connecting = true;
                      var value = commentData.isLikeCheck! ? -1 : 1;
                      if (kDebugMode) {
                        print('Content Info Page like check value : $value');
                      }
                      HttpProtocolManager.to.Send_Stat(id, value, Stat_Type.like)
                          .then((value)
                      {
                        CommentUpdate();
                     });
                    },
                    (id) {
                      return;
                    },
                    (id)
                    {
                      //좋아요.
                      if (connecting)
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
                      connecting = true;
                      var item = replyList.firstWhere((element) => element.ID == id);
                      var value = item.isLikeCheck! ? -1 : 1;
                      print('comment like check value : $value');
                      HttpProtocolManager.to.Send_Stat(id, value, Stat_Type.like)
                          .then((value)
                      {
                        for(var item in value!.data!)
                        {
                          for(int i = 0 ; i < replyList.length; ++i)
                          {
                            if (replyList[i].ID == item.key)
                            {
                              HttpProtocolManager.to.Get_Reply(commentData.parentID!, replyList[i].parentID!, id).then((value1)
                              {
                                if (value1 == null)
                                {
                                  connecting = false;
                                  return;
                                }
                                var resData = value1.data!.items!.firstWhere((element) => element.id == id);
                                if (UserData.to.userId == resData.whoami)
                                {
                                  print('find');
                                  replyList[i].likeCount = resData.likes;
                                  replyList[i].isLikeCheck = resData.whoami!.isNotEmpty && resData.whoami == UserData.to.userId && resData.ilike > 0;
                                  setState(() {

                                  });
                                }
                                print('complete');
                                connecting = false;
                              },);
                              break;
                            }
                          }
                        }

                      });
                    },
                        (id)
                    {
                      //수정.
                      replyID = id;
                      var item = replyList.firstWhere((element) => element.ID == id);
                      textEditingController.text = item.comment!;
                      FocusScope.of(context).requestFocus(textFocusNode);
                      setState(() {

                      });
                    },
                        (id)
                    {
                      //삭제.
                      DeleteReply(id);
                    });

              }),
              Obx(()
              {
                return
                VirtualKeybord(StringTable().Table![100041]!, textEditingController, textFocusNode,
                              !UserData.to.isLogin.value,
                              MediaQuery.of(context).viewInsets.bottom,  ()
                              {
                                if (kDebugMode) {
                                  print('reply ${textEditingController.text}');
                                }

                                if (textEditingController.text.isEmpty)
                                {
                                  return;
                                }

                                SendReply();
                              });
              }),
            ],
          ),
        ),
      ),
      ),
    ),
  );
}

Widget ReplyPopup(ScrollController _scrollController,
    EpisodeCommentData _commentData, List<EpisodeCommentData> _replyList,Function(String) _callbackCommentLike, Function(String) _callbackCommentDelete, Function(String) _callbackLike, Function(String) _callbackEdit,  Function(String) _callbackDelete, [double _padding = 60])
{

  return
  Padding
  (
    padding: EdgeInsets.only(top: _padding),
    child: Column
    (
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Padding
        (
          padding: const EdgeInsets.only(left: 30),
          child:
          Container
          (
            padding: EdgeInsets.only(top: 5),
            child:
            CommentWidget
            (
              _commentData,
              false,
              (id)
              {
                //좋아요.
                _callbackCommentLike(id);
              },
              (id)
              {
                //답글보기 여기선 사용안함.
              },
              (id)
              {
                //수정.
              },
              (id)
              {
                //삭제.
                _callbackCommentDelete(id);
              },
            ),
          ),
        ),
        Expanded
        (
          child: SingleChildScrollView
          (
            controller: _scrollController,
            child: Column
            (
              children:
              [
                SizedBox(height:  10,),
                for (int i = 0; i < _replyList.length; ++i)
                  Padding(
                    padding: const EdgeInsets.only(left: 80),
                    child: Container(
                      child: CommentWidget
                        (
                        _replyList[i],
                            true,
                            (id)
                            {
                              print('click like');
                              _callbackLike(id);
                            },
                            (p0)
                            {

                            },
                            (id)
                            {
                              print('click edit');
                              _callbackEdit(id);
                            },
                            (id)
                            {
                              _callbackDelete(id);
                            },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
