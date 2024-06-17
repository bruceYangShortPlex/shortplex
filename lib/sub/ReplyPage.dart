import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
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
  String replyID = '';
  List<EpisodeCommentData> replyList = <EpisodeCommentData>[];
  var scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  FocusNode textFocusNode = FocusNode();

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
  );

  int totalCount = 0;
  void GetRepliesData() async
  {
    try
    {
      await HttpProtocolManager.to.get_RepliesData(commentData.parentID!, commentData.ID).then((value)
      {
        var commentRes = value;
        totalCount = commentRes!.data!.total;
        for(var item in commentRes.data!.items!)
        {
          var data = EpisodeCommentData
          (
            name: item.displayname ?? '',
            comment: item.content,
            date: item.createdAt != null ? ConvertCommentDate(item.createdAt!) : '',
            episodeNumber: '',
            iconUrl: item.photourl ?? '',
            ID: item.id!,
            isLikeCheck: false,
            likeCount: item.likes ?? '0',
            replyCount: item.replies ?? '0',
            isDelete: UserData.to.userId ==  item.userId,
            commentType: CommentType.NORMAL,
            parentID: commentData.ID,
            isEdit: false,
          );
          replyList.add(data);
        }

        setState(() {

        });
      });
    }
    catch(e)
    {
      print('GetCommentData Catch $e');
    }
  }

  void TestReplies()
  {
    for(int i = 0 ; i < 10; ++i)
    {
      var data = EpisodeCommentData
      (
        name: '홍길동 $i',
        comment: '이렇쿵 저렇쿵 알아서 잘해보자쿵.',
        date: DateTime.now().toString(),
        episodeNumber: '',
        iconUrl: '',
        ID: i.toString(),
        isLikeCheck: false,
        likeCount: '0',
        replyCount: '0',
        isDelete: true,
        commentType: CommentType.NORMAL,
        parentID: commentData.ID,
        isEdit: true,
      );
      replyList.add(data);
    }
  }

  @override
  void initState()
  {
    super.initState();
    commentData = Get.arguments;
    print('data 1 : $commentData');

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
      //TODO:Page로 불러오기 나오면 작업.
      if (totalCount > replyList.length)
      {

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
        await HttpProtocolManager.to.send_edit_reply
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
        await HttpProtocolManager.to.send_Reply(
            commentData.parentID!, textEditingController.text, commentData.ID, Comment_CD_Type.episode).then((value)
        {
          CommentUpdate();
          print('send_Reply result $value');
          connecting = false;
        });
      }
    }
    catch(e)
    {
      connecting = false;
      print('send send_Reply error : $e');
    }
  }

  void CommentUpdate() async
  {
    try
    {
      await HttpProtocolManager.to.get_Comment(commentData.parentID!).then((value)
      {
        for(var item in value!.data!.items!)
        {
          if (item.id == commentData.ID)
          {
            commentData.replyCount = item.replies;
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
      await HttpProtocolManager.to.send_delete_reply(commentData.parentID!,commentData.ID, _replyID).then((value)
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
              ReplyPopup(scrollController, commentData, replyList,
              (id)
              {
                replyID = id;
                var item = replyList.firstWhere((element) => element.ID == id);
                textEditingController.text = item.comment!;
                FocusScope.of(context).requestFocus(textFocusNode);
                setState(() {

                });
              },
              (id)
              {
                //삭제
                DeleteReply(id);
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

                                var item = replyList.firstWhere((element) => element.ID == replyID);
                                if (item.comment != null && item.comment == textEditingController.text)
                                {
                                  return;
                                }
                                SendReply();
                              });
              })
            ],
          ),
        ),
      ),
      ),
    ),
  );
}

Widget ReplyPopup(ScrollController _scrollController,
    EpisodeCommentData _commentData, List<EpisodeCommentData> _replyList, Function(String) _callbackEdit,  Function(String) _callbackDelete, [double _padding = 60])
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
              (p0) {},
              (p0) {},
                  (id)
              {

              },
              (p0) {},
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
                            (p0)
                            {

                            },
                            (p0)
                            {

                            },
                            (id)
                            {
                              //TODO : 수정하기 버튼 처리
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
