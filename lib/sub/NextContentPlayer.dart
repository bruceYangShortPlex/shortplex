import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shortplex/Network/Comment_Res.dart';
import 'package:shortplex/Network/Content_Res.dart';
import 'package:shortplex/Util/HttpProtocolManager.dart';
import 'package:shortplex/sub/UserInfo/LoginPage.dart';
import 'package:shortplex/sub/UserInfo/ShopPage.dart';
import 'package:shortplex/table/UserData.dart';
import 'package:video_player/video_player.dart';

import '../Util/ShortplexTools.dart';
import '../table/StringTable.dart';
import 'ContentInfoPage.dart';
import 'ContentPlayer.dart';
import 'CupertinoMain.dart';
import 'NextContentPlayer.dart';
import 'ReplyPage.dart';

class NextContentPlayer extends StatefulWidget
{
  @override
  _NextContentPlayer createState() => _NextContentPlayer();
}

class _NextContentPlayer extends State<NextContentPlayer> with TickerProviderStateMixin
{
  late VideoPlayerController videoController;
  // Add a variable to handle the time of video playback
  double currentTime = 0.0;
  int commentCount = 0;
  double tweenDelay = 3;
  double commentScrollOffset = 0;
  late Ticker ticker;

  late AnimationController tweenController;
  bool controlUIVisible = false;
  late List<Episode> episodeList;
  int selectedEpisodeNo = 0;
  bool isShowContent = false;
  TextEditingController textEditingController = TextEditingController();
  FocusNode textFocusNode = FocusNode();

  late String playUrl;
  Episode? episodeData;

  void VideoControllerInit()
  {
    var uri = playUrl;//"https://videos.pexels.com/video-files/17687288/17687288-uhd_2160_3840_30fps.mp4";
    videoController = VideoPlayerController.networkUrl(Uri.parse(uri))
      ..initialize().then((_) {
        setState(() {
          if (isShowContent) {
            videoController.play();
          }
        });
      });

    videoController.addListener(() {
      if (videoController.value.position >= videoController.value.duration)
      {
        // 동영상 재생이 끝났을 때 실행할 로직
        print("동영상 재생이 끝났습니다.");
        if (selectedEpisodeNo < episodeList.length)
        {
          Get.off(ContentPlayer(), arguments: [selectedEpisodeNo + 1, episodeList]);
          return;
        }
      }

      setState(() {
        currentTime = videoController.value.position.inSeconds.toDouble();
      });
    });
  }

  @override
  void initState()
  {
    selectedEpisodeNo = Get.arguments[0];
    episodeList = Get.arguments[1];

    try
    {
      episodeData = episodeList.firstWhere((item) => item.no == selectedEpisodeNo);
    }
    catch(e)
    {
      print(e);
    }

    print('play content ${episodeData!.no}');
    playUrl = "https://www.quadra-system.com/api/v1/vod/stream/${episodeData!.episodeFhd}";
    //팝콘이 부족하지 않은지 확인. 콘텐츠 비용은 어디서 받아와야할지 생각해보자.
    //이번회차의 가격을 알아온다.
    if (episodeData!.cost != 0 && episodeData!.isLock)
    {
      //구독중이면 그냥 다음진행.
      if (UserData.to.isSubscription == false)
      {
        if (UserData.to.popcornCount + UserData.to.bonusCornCount < episodeData!.cost)
        {
          isShowContent = false;
          isShowShop =  true;
          bottomOffset = 0;
          tweenTime = 300;
          setState(()
          {

          });
        }
        else
        {
          //팝콘은 충분한데 자동결제가 아닌사람.
          if (UserData.to.autoPlay == false)
          {
            WidgetsBinding.instance.addPostFrameCallback((_)
            {
              // 이곳에 빌드 후에 실행할 코드를 작성하세요.
              showDialogTwoButton(StringTable().Table![100038]!, StringTable().Table![100039]!, ()
              {
                //서버에 통신하고 처리되면 거시기한다.
                isShowContent = true;
                VideoControllerInit();
                setState(() {

                });
              },
                    () {
                  Get.back();
                },);
            });

            isShowContent = false;
          }
          else
          {
            isShowContent = true;
          }
        }
      }
      else
      {
        isShowContent = true;
      }
    }
    else
    {
      isShowContent = true;
    }

    //print('check cost isShowContent : $isShowContent');

    if (isShowContent == true)
    {
      VideoControllerInit();
    }

    tweenController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Add a listener to update the current time variable
    Future.delayed(Duration(milliseconds: 500)).then((_)
    {
      if (UserData.to.usedPopcorn != 0) {
        ShowCustomSnackbar(StringTable().Table![100047]!, SnackPosition.BOTTOM);
        UserData.to.usedPopcorn = 0;
      }
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent)
      {
        print('call end page');
        onEndOfPage();
      }
    });

    ticker = createTicker((elapsed)
    {
      if (elapsed.inSeconds > 3)
      {
        ticker.stop();
        if(controlUIVisible = true)
        {
          controlUIVisible = false;
          tweenController.reverse();
          setState(() {

          });
        }
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
        textEditingController.text = '';
        isEdit = false;
        editReplyID = '';
      }
    });

    GetComment();

    super.initState();
  }

  @override
  void dispose()
  {
    textFocusNode.dispose();
    textEditingController.dispose();
    ticker.dispose();
    replyScrollController.dispose();
    if (isShowContent) {
      videoController.dispose();
    }
    tweenController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() async
  {
    super.didChangeDependencies();
  }

  void SendComment() async
  {
    try
    {
      connecting = true;
      if (isEdit)
      {
        await HttpProtocolManager.to.send_edit_comment
          (
            episodeData!.id!, textEditingController.text, commentData!.ID,
            Comment_CD_Type.episode).then((value)
        {
          for(var item in value!.data!.items!)
          {
            for(int i = 0 ; i < episodeCommentList.length; ++i)
            {
              if (episodeCommentList[i].ID == item.id && episodeCommentList[i].comment != item.content)
              {
                episodeCommentList[i].comment = item.content;
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
        await HttpProtocolManager.to.send_Comment(
            episodeData!.id!, textEditingController.text, '', Comment_CD_Type.episode).then((value)
        {
          CommentRefresh(value, false);
          connecting = false;
        });
      }
    }
    catch(e)
    {
      connecting = false;
      print('send Comment error : $e');
    }
  }

  String replyID = '';
  void SendReply() async
  {
    try
    {
      connecting = true;
      if (isEdit)
      {
        await HttpProtocolManager.to.send_edit_reply(
            episodeData!.id!, textEditingController.text, commentData!.ID, editReplyID, Comment_CD_Type.episode).then((value) {
          CommentRefresh(value, true);
          print('send_Reply result $value');
          connecting = false;
        });
      }
      else
      {
        await HttpProtocolManager.to.send_Reply(
            episodeData!.id!, textEditingController.text, commentData!.ID, Comment_CD_Type.episode).then((value) {
          CommentRefresh(value, true);
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

  void GetComment() async
  {
    try
    {
      print('Get Comment');
      await HttpProtocolManager.to.get_Comment(episodeData!.id!).then((value)
      {
        CommentRefresh(value, false);
      });
    }
    catch(e)
    {
      print('send Comment error : $e');
    }
  }

  void CommentRefresh(CommentRes? _data, bool _isReply)
  {
    print('Receive Comment');

    if (_data == null)
    {
      print("CommentRefresh data null return");
      return;
    }

    for (var item in _data.data!.items!)
    {
      //print('item.id : ${item.id}');

      var selectList = _isReply ? replyList : episodeCommentList;
      if (selectList.any((element) => element.ID == item.id))
      {
        print('already data continue');
        continue;
      }

      String? displayname = item.displayname;
      if(displayname == null)
      {
        if ( item.userId == UserData.to.userId)
        {
          displayname = UserData.to.name.value;
        }
        else
        {
          print('Not Found displayname !!!');
        }
      }

      var commentData = EpisodeCommentData
        (
        name: displayname,
        comment: item.content ?? '',
        date: item.createdAt != null ? ConvertCommentDate(item.createdAt!) : '00.00.00',
        episodeNumber: '',
        iconUrl: '',
        ID: item.id!,
        isLikeCheck: false,
        likeCount: '0',
        replyCount: '${item.replies}',
        isDelete: UserData.to.userId == item.userId,
        commentType: CommentType.NORMAL,
        parentID: episodeData!.id!,
        isEdit: UserData.to.userId == item.userId,
      );
      selectList.add(commentData);
      setState(() {

      });
    }
    commentCount = episodeCommentList.length;
    setState(() {

    });
  }

  void DeleteComment(String _id) async
  {
    try
    {
      await HttpProtocolManager.to.send_delete_comment(episodeData!.id!, _id).then((value)
      {
        for(var item  in value!.data!.items!)
        {
          print('receive delete id : ${item.id}');
          for(int i = 0; i < episodeCommentList.length; ++i)
          {
            if (episodeCommentList[i].ID == item.id)
            {
              episodeCommentList.removeAt(i);
              commentCount = episodeCommentList.length;
              print('delete complete id : ${item.id}');
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

  void DeleteReply(String _replyID) async
  {
    try
    {
      await HttpProtocolManager.to.send_delete_reply(episodeData!.id!,commentData!.ID, _replyID).then((value)
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


  void GetRepliesData() async
  {
    replyList.clear();
    setState(() {

    });
    try
    {
      await HttpProtocolManager.to.get_RepliesData(episodeData!.id!, commentData!.ID).then((value)
      {
        CommentRefresh(value, true);
        print('Get Replies Complete');
      });
    }
    catch(e)
    {
      print('GetCommentData Catch $e');
    }

    print('Get Replies');
  }

  void setScrollPosition(double _offset) {
    scrollController.animateTo(
      _offset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Widget contentUIButtons(String _buttonLabel, IconData _buttonIcon, ContentUI_ButtonType _type)
  {
    return
      Container
        (
        //color: Colors.white,
        alignment: Alignment.centerRight,
        width: MediaQuery.of(context).size.width,
        child:
        Padding
          (
          padding: const EdgeInsets.only(top:2, bottom: 10.0, right: 25),
          child: GestureDetector
            (
            onTap: ()
            {
              if (showCheck() == false)
              {
                return;
              }

              switch(_type)
              {
                case ContentUI_ButtonType.COMMENT:
                  {
                    isShowShop = false;
                    ticker.stop();
                    controlUIVisible = false;
                    isShowReply = false;
                    tweenTime = 300;
                    bottomOffset = 0;
                    tweenController.reverse();
                    setState(() {

                    });
                    GetComment();
                  }
                  break;
                case ContentUI_ButtonType.CONTENT_INFO:
                  {
                    Get.to(() => ContentInfoPage());
                  }
                  break;
                case ContentUI_ButtonType.CHECK:
                  {
                    episodeData!.isCheck = !episodeData!.isCheck;
                    setState(() {

                    });
                  }
                  break;
                default:
                  print('to do type $_type');
                  break;
              }
              print('contentUIButtons tap');
            },
            child:
            Opacity
              (
              opacity: 0.70,
              child:
              Container
                (
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
                      child: Icon(_buttonIcon, size: 22, color:Colors.white),
                    ),
                    Padding
                      (
                      padding: const EdgeInsets.only(top: 18),
                      child: Text
                        (
                        _buttonLabel,
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
      );
  }

  bool showCheck()
  {
    if (isShowContent == false)
    {
      bottomOffset = 0;
      setState(() {

      });
    }

    return isShowContent;
  }

  Widget controlUI(BuildContext context)
  {
    return
      Container
        (
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        //color: Colors.blue,
        //alignment: Alignment.bottomCenter,
        child:
        Column
          (
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
          [
            Expanded
              (
              child:
              Container
                (
                alignment: Alignment.topCenter,
                width: MediaQuery.of(context).size.width,
                //height: 50,
                //color: Colors.blue,
                child:
                Row
                  (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                  [
                    CupertinoNavigationBarBackButton
                      (
                      color: Colors.white,
                      onPressed: ()
                      {
                        //print(Get.isPopGestureEnable);
                        Get.back();
                      },
                    ),
                    Visibility
                      (
                      visible: selectedEpisodeNo < episodeList.length,
                      child:
                      IconButton
                        (
                        onPressed: ()
                        {
                          if (showCheck() == false)
                          {
                            return;
                          }

                          Get.off(ContentPlayer(), arguments: [selectedEpisodeNo + 1, episodeList]);
                          print('다음회차 보기 누름');
                        },
                        icon: Icon(Icons.skip_next), color: Colors.white, iconSize: 33,
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
                alignment: Alignment.center,
                child: GestureDetector
                  (
                  onTap: ()
                  {
                    if (showCheck() == false)
                    {
                      return;
                    }

                    ticker.stop();
                    ticker.start();

                    if (videoController.value.isInitialized)
                    {
                      if (videoController.value.isPlaying) {
                        videoController.pause();
                      }
                      else {
                        videoController.play();
                      }
                    }
                  },
                  child:
                  Container
                    (
                    alignment: Alignment.center,
                    padding: isShowContent && videoController.value.isInitialized && videoController.value.isPlaying ? EdgeInsets.only(left: 0) : EdgeInsets.only(left: 5,),
                    width: 75,
                    height: 75,
                    decoration: ShapeDecoration(
                      color: Colors.black.withOpacity(0.7),
                      shape: OvalBorder(
                        side: BorderSide(
                          width: 2,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0xFF00FFBF),
                        ),
                      ),
                    ),
                    child:
                    Icon
                      (
                      isShowContent && videoController.value.isInitialized && videoController.value.isPlaying ? CupertinoIcons.pause_solid :
                      CupertinoIcons.play_arrow_solid, size: 40, color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            contentUIButtons('$commentCount', CupertinoIcons.ellipses_bubble, ContentUI_ButtonType.COMMENT),
            contentUIButtons(StringTable().Table![100023]!, episodeData!.isCheck ? CupertinoIcons.heart_solid : CupertinoIcons.heart, ContentUI_ButtonType.CHECK),
            contentUIButtons(StringTable().Table![100024]!, CupertinoIcons.share, ContentUI_ButtonType.SHARE),
            contentUIButtons(StringTable().Table![100043]!, CupertinoIcons.info, ContentUI_ButtonType.CONTENT_INFO),
            Container
              (
              color: Colors.black.withOpacity(0.9),
              child:
              SizedBox
                (
                width: MediaQuery.of(context).size.width,
                child:
                isShowContent && videoController.value.isInitialized ?
                CupertinoSlider
                  (
                  value: currentTime,
                  min: 0.0,
                  max: videoController.value.duration.inSeconds.toDouble(),
                  onChanged: (value)
                  {
                    ticker.stop();
                    ticker.start();
                    setState(()
                    {
                      currentTime = value;
                      videoController.seekTo(Duration(seconds: value.toInt()));
                    });
                  },
                ) : Container(),
              ),
            ),
            Container
              (
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 30),
              height: 40,
              alignment: Alignment.topLeft,
              color: Colors.black.withOpacity(0.9),
              child:
              Text
                (
                isShowContent && videoController.value.isInitialized ?
                '${formatDuration(videoController.value.position).$2}:${formatDuration(videoController.value.position).$3} / ${formatDuration(videoController.value.duration).$2}:${formatDuration(videoController.value.duration).$3}' : '00:00 / 00:00',
                style:
                TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
              ),
            ),
          ],
        ),
      );
  }

  @override
  Widget build(BuildContext context)
  {
    try {
      return
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
                    child:
                    GestureDetector
                      (
                      onTap:
                          ()
                      {
                        if (isShowContent == false || bottomOffset == 0) {
                          return;
                        }

                        if (tweenController.status == AnimationStatus.completed) {
                          tweenController.reverse();
                          ticker.stop();
                          setState(() {
                            controlUIVisible = false;
                          });
                        }
                        else
                        {
                          tweenController.forward();
                          ticker.stop();
                          ticker.start();
                          setState(()
                          {
                            controlUIVisible = true;
                          });
                        }
                      },
                      child:
                      Stack
                        (
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>
                        [
                          Center
                            (
                            child:
                            AspectRatio
                              (
                              aspectRatio: 9/16,
                              child:
                              isShowContent == true && videoController.value.isInitialized == true ?
                              VideoPlayer(videoController) :
                              Center
                                (
                                  child:
                                  CircularProgressIndicator()
                              ),
                            ),
                          ),
                          FadeTransition
                            (
                            opacity: tweenController,
                            child:
                            IgnorePointer
                              (
                              ignoring: controlUIVisible == false,
                              child:
                              controlUI(context),
                            ),
                          ),
                          bottomCanvas(),
                          //contentComment(),
                        ],
                      ),
                    )
                )
            )
        );
    }
    catch(e)
    {
      print(e);
      return
        Container
          (
          child:
          CupertinoNavigationBarBackButton
            (
            color: Colors.white,
            onPressed: ()
            {
              Get.back();
            },
          ),
        );
    }
  }

  bool connecting = false;
  double bottomOffset = -840.h;
  int tweenTime = 0;
  Widget bottomCanvas()
  {
    return
      TweenAnimationBuilder<double>
        (
        tween: Tween<double>(begin: 0, end: bottomOffset),
        duration: Duration(milliseconds: tweenTime),
        builder: (BuildContext context, double offset, Widget? child)
        {
          return
            Positioned
              (
              bottom: offset,
              left: 0,
              right: 0,
              child:
              Stack
                (
                children:
                [
                  Padding
                    (
                    padding: EdgeInsets.only(top: 275.h),
                    child:
                    Container
                      (
                      height: 70,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0, -1),
                          end: Alignment(0, 1),
                          colors: [Colors.transparent, Colors.black],
                        ),
                        //border: Border.all(width: 1),
                      ),
                    ),
                  ),
                  Container
                    (
                    width: MediaQuery.of(context).size.width,
                    height: 840.h,
                    //color: Colors.transparent,
                    alignment: Alignment.bottomCenter,
                    child:
                    Container
                      (
                        width: 390.w,
                        height: 500.h,
                        color: Colors.black,
                        child:
                        isShowShop ?
                        showShop() :
                        Stack
                          (
                          children:
                          [
                            isShowReply == false ?
                            contentComment() : commentReply(),
                            IgnorePointer
                              (
                              ignoring: connecting,
                              child:
                              Obx(()
                              {
                                return
                                  VirtualKeybord(StringTable().Table![100041]!, textEditingController, textFocusNode,
                                    !UserData.to.isLogin.value, MediaQuery.of(context).viewInsets.bottom,
                                        ()
                                    {
                                      print('comment complete ${textEditingController.text}');

                                      if (textEditingController.text.isEmpty)
                                      {
                                        return;
                                      }

                                      if (commentData != null && textEditingController.text == commentData!.comment)
                                      {
                                        return;
                                      }

                                      if (isShowReply)
                                      {
                                        SendReply();
                                      }
                                      else
                                      {
                                        SendComment();
                                      }
                                    },);
                              }),
                            )
                          ],
                        )
                    ),
                  ),
                  GestureDetector
                    (
                    onTap: ()
                    {
                      if (bottomOffset == 0)
                      {
                        if (isShowContent == false)
                        {
                          tweenController.forward();
                          ticker.stop();
                          controlUIVisible = true;
                        }

                        textFocusNode.unfocus();
                        bottomOffset = -840.h;
                        setState(()
                        {

                        });
                      }
                    },
                    child:
                    Container
                      (
                      height: 320.h,
                      color: Colors.transparent,
                      //color: Colors.blue,
                    ),
                  ),
                ],
              ),
            );
        },
      );
  }

  //comment 관련
  var episodeCommentList = <EpisodeCommentData>[];
  var scrollController = ScrollController();
  var replyScrollController = ScrollController();
  var totalCommentCount = 0;
  CommentSortType commentSortType = CommentSortType.LATEST;

  Widget contentComment()
  {
    return
      Padding
        (
        padding: const EdgeInsets.only(top: 10),
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
                        commentSortType = CommentSortType.LIKE;
                      });
                    },
                    child: Container
                      (
                      width: 73,
                      height: 26,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF1E1E1E),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1.50, color: commentSortType == CommentSortType.LIKE ? const Color(0xFF00FFBF) : const Color(0xFF878787)),
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
                        TextStyle(fontSize: 11, color: commentSortType == CommentSortType.LIKE ? Colors.white : const Color(0xFF878787), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
                        commentSortType = CommentSortType.LATEST;
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
                          side: BorderSide(width: 1.50, color: commentSortType == CommentSortType.LATEST ? Color(0xFF00FFBF) : Color(0xFF878787)),
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
                        TextStyle(fontSize: 11, color: commentSortType == CommentSortType.LATEST ? Colors.white : const Color(0xFF878787), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container
              (
              height: 455.h,
              //color: Colors.green,
              child:
              SingleChildScrollView
                (
                  controller: scrollController,
                  child:
                  Column
                    (
                      children:
                      [
                        for(int i = 0; i < episodeCommentList.length; ++i)
                          CommentWidget
                            (
                            episodeCommentList[i],
                            false,
                                (id)
                            {
                              //TODO : 좋아요 버튼 처리
                              print(id);
                            },
                                (id)
                            {
                              //답글 보기.
                              commentData = episodeCommentList[i];
                              isShowReply = true;
                              //commentScrollOffset = scrollController.offset;
                              GetRepliesData();
                            },
                                (id)
                            {
                              //TODO : 수정하기 버튼 처리
                              print('edit start');
                              commentData = episodeCommentList[i];
                              textEditingController.text = commentData!.comment!;
                              FocusScope.of(context).requestFocus(textFocusNode);
                              isEdit = true;
                            },
                                (id)
                            {
                              //TODO : 삭제 버튼 처리
                              DeleteComment(id);
                            },
                          ),
                      ]
                  )
              ),
            )
          ],
        ),
      );
  }

  bool isShowReply = false;
  bool isEdit = false;
  List<EpisodeCommentData> replyList = <EpisodeCommentData>[];
  EpisodeCommentData? commentData;
  String editReplyID = '';

  Widget commentReply()
  {
    return
      Container
        (
        height: 550.h,
        //color: Colors.green,
        child:
        Column
          (
          mainAxisAlignment: MainAxisAlignment.start,
          children:
          [
            Container
              (
              height: 50,
              alignment: Alignment.centerLeft,
              child:
              CupertinoNavigationBarBackButton
                (
                color: Colors.white,
                onPressed: ()
                {
                  isShowReply = false;
                  print('on tap reply off');
                  setState(()
                  {
                    //setScrollPosition(commentScrollOffset);
                  });
                },
              ),
            ),
            Expanded
              (
              child:
              ReplyPopup(scrollController, commentData!, replyList,
                      (id)
                  {
                    //수정하기,
                    editReplyID = id;
                    isEdit = true;
                    var item = replyList.firstWhere((element) => element.ID == id);
                    textEditingController.text = item.comment!;
                    FocusScope.of(context).requestFocus(textFocusNode);
                  },
                      (id)
                  {
                    DeleteReply(id);
                  },
                  20),
            )
          ],
        ),
      );
  }

  void onEndOfPage() async
  {
    try
    {
      if (isShowReply)
      {

      }
      else
      {
        GetComment();
      }
    }
    catch (e)
    {
      print(e);
    }
  }

  bool isShowShop = false;
  Widget showShop()
  {
    return
      Padding
        (
        padding: EdgeInsets.only(top: 30),
        child:
        SingleChildScrollView
          (
          child:
          Column
            (
            children:
            [
              Padding
                (
                padding: EdgeInsets.only(top: 20),
                child:
                Container
                  (
                  height: 85,
                  //color: Colors.white,
                  child:
                  Row
                    (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                    [
                      Expanded
                        (
                        flex: 3,
                        child:
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Container
                            (
                              alignment: Alignment.centerLeft,
                              //color: Colors.blue,
                              child:
                              Column
                                (
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                [
                                  Text
                                    (
                                    StringTable().Table![400024]!,
                                    style: TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                                  ),
                                  SizedBox(height: 8,),
                                  Text
                                    (
                                    SetTableStringArgument(400025, ['${episodeData!.cost}', '${UserData.to.popcornCount + UserData.to.bonusCornCount}'])
                                    ,
                                    style: TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                                  ),
                                ],
                              )
                          ),
                        ),
                      ),
                      Expanded
                        (
                        child:
                        Padding
                          (
                          padding: const EdgeInsets.only(right: 30),
                          child:
                          Container
                            (
                            alignment: Alignment.topLeft,
                            //color: Colors.green,
                            child:
                            GestureDetector
                              (
                              onTap: ()
                              {
                                MainBottomNavgationBarController.to.selectedIndex.value = 3;
                                Get.back();
                              },
                              child: Stack
                                (
                                alignment: Alignment.center,
                                children:
                                [
                                  Padding
                                    (
                                    padding: EdgeInsets.only(bottom: 20),
                                    child:

                                    Container
                                      (
                                      width: 40,
                                      height: 21,
                                      decoration: ShapeDecoration(
                                        color: Color(0xFF1E1E1E),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(width: 1, color: Color(0xFF00FFBF)),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                      child:
                                      FittedBox
                                        (
                                        alignment: Alignment.center,
                                        child:
                                        Text
                                          (
                                          'FREE',
                                          style: TextStyle(fontSize: 15, color: Color(0xFF00FFBF), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                                        ),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Padding
                                    (
                                    padding: const EdgeInsets.only(top: 50),
                                    child:
                                    Text
                                      (
                                      StringTable().Table![400026]!,
                                      style: TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ShopGoods(false),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row
                  (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    toggleButton(),
                    Padding
                      (
                      padding: EdgeInsets.only(bottom: 2),
                      child:
                      Text
                        (
                        StringTable().Table![400027]!,
                        style:
                        TextStyle
                          (
                          fontSize: 12, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      );
  }

  Widget toggleButton() =>
      Transform.scale
        (
        scale: 0.7,
        child:
        CupertinoSwitch
          (
          value: UserData.to.autoPlay,
          activeColor: Color(0xFF00FFBF),
          onChanged: (bool? value)
          {
            //TODO : 서버에 알리기
            setState(()
            {
              UserData.to.autoPlay = value ?? false;
            });
          },
        ),
      );
}