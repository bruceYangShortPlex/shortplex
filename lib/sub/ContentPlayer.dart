import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../Util/ShortplexTools.dart';
import '../table/StringTable.dart';
import 'ContentInfoPage.dart';
import 'ReplyPage.dart';

enum ContentPlayButtonType
{
  COMMENT,
  CHECK,
  SHARE,
  CONTENT_INFO,
}

class ContentPlayer extends StatefulWidget {
  @override
  _ContentPlayerState createState() => _ContentPlayerState();
}

class _ContentPlayerState extends State<ContentPlayer> with SingleTickerProviderStateMixin
{
  late VideoPlayerController videoController;
  // Add a variable to handle the time of video playback
  double currentTime = 0.0;
  int commentCount = 0;
  int usedPopcorn = 0;

  late AnimationController tweenController;
  bool controlUIVisible = false;

  @override
  void initState()
  {
    videoController = VideoPlayerController.networkUrl(
        Uri.parse("https://videos.pexels.com/video-files/17687288/17687288-uhd_2160_3840_30fps.mp4"))
      ..initialize().then((_) {
        setState(() {
          videoController.play();
        });
      });

    tweenController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Add a listener to update the current time variable
    videoController.addListener(()
    {
      if (videoController.value.position >= videoController.value.duration)
      {
        // 동영상 재생이 끝났을 때 실행할 로직
        print("동영상 재생이 끝났습니다.");
      }

      setState(()
      {
        currentTime = videoController.value.position.inSeconds.toDouble();
      });
    });

    // setState(() {
    //   _visible = true;
    // });

    usedPopcorn = 3;

    Future.delayed(Duration(milliseconds: 500)).then((_)
    {
      if (usedPopcorn != 0)
        usedPopcornAnnounce();
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent)
      {
        print('call end page');
        onEndOfPage();
      }
    });

    for(int i = 0; i < 11; ++i)
    {
      var commentData = EpisodeCommentData
      (
        name: '황후마마가 돌아왔다.',
        commant: '이건 재미있다. 무조건 된다고 생각한다.',
        date: '24.09.06',
        episodeNumber: '11',
        iconUrl: '',
        ID: i,
        isLikeCheck: i % 2 == 0,
        likeCount: '12',
        replyCount: '3',
        isOwner: i == 0,
        isBest: true,
      );
      episodeCommentList.add(commentData);
    }

    for(int i = 0; i < 10; ++i)
    {
      var commentData = EpisodeCommentData
      (
        name: '황후마마가 돌아왔다.',
        commant: '이건 재미있다. 무조건 된다고 생각한다.',
        date: '24.09.06',
        episodeNumber: '11',
        iconUrl: '',
        ID: i,
        isLikeCheck: i % 2 == 0,
        likeCount: '12',
        replyCount: '3',
        isOwner: i == 0,
        isBest: true,
      );
      replyList.add(commentData);
    }
    super.initState();
  }

  @override
  void dispose()
  {
    videoController.dispose();
    tweenController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  SnackbarController usedPopcornAnnounce()
  {
    return
    Get.snackbar
    (
      '',
      '',
      padding: EdgeInsets.only(bottom: 30),
      messageText:
      Center(
        child: Text(StringTable().Table![100047]!,
          style:
          TextStyle(fontSize: 16, color: Colors.blue, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),),
      ),
      //colorText: Colors.blue,
      backgroundColor: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
    );
  }

  @override
  void didChangeDependencies() async
  {
    super.didChangeDependencies();

  }

  Widget contentUIButtons(String _buttonLabel, IconData _buttonIcon, ContentPlayButtonType _type)
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
            switch(_type)
            {
              case ContentPlayButtonType.COMMENT:
                {
                  tweenController.reverse();
                  setState(()
                  {
                    controlUIVisible = false;
                    isShowReply = false;
                    tweenTime = 300;
                    bottomOffset = 0;
                  });
                }
                break;
              default:
                print('to do type $_type');
                break;
            }
            print('tap');
          },
          child: Opacity
          (
            opacity: 0.70,
            child: Container(
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
                      TextStyle(fontSize: 10, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
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
                  IconButton
                  (
                    onPressed: ()
                    {
                      //Get.off();
                      print('다음회차 보기 누름');
                    },
                    icon: Icon(Icons.skip_next), color: Colors.white, iconSize: 33,
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
                  if (videoController.value.isPlaying)
                    videoController.pause();
                  else
                    videoController.play();
                },
                child: Container
                (
                  alignment: Alignment.center,
                  padding: videoController.value.isPlaying ? EdgeInsets.only(left: 0) : EdgeInsets.only(left: 5),
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
                    videoController.value.isPlaying ? CupertinoIcons.pause_solid :
                    CupertinoIcons.play_arrow_solid, size: 40, color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          contentUIButtons('$commentCount', CupertinoIcons.ellipses_bubble, ContentPlayButtonType.COMMENT),
          contentUIButtons(StringTable().Table![100023]!, CupertinoIcons.heart, ContentPlayButtonType.CHECK),
          contentUIButtons(StringTable().Table![100024]!, CupertinoIcons.share, ContentPlayButtonType.SHARE),
          contentUIButtons(StringTable().Table![100043]!, CupertinoIcons.info, ContentPlayButtonType.CONTENT_INFO),
          Container
          (
            color: Colors.black.withOpacity(0.9),
            child:
            SizedBox
            (
              width: MediaQuery.of(context).size.width,
              child:
              CupertinoSlider
              (
                value: currentTime,
                min: 0.0,
                max: videoController.value.duration.inSeconds.toDouble(),
                onChanged: (value)
                {
                  setState(()
                  {
                    currentTime = value;
                    videoController.seekTo(Duration(seconds: value.toInt()));
                  });
                },
              ),
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
              '${formatDuration(videoController.value.position)} / ${formatDuration(videoController.value.duration)}',
              style:
              TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context)
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
          child:
          videoController.value.isInitialized
              ?
          GestureDetector
          (
            onTap:
            ()
            {
              if (bottomOffset == 0) {
                bottomOffset = -840.h;
                setState(() {

                });
                return;
              }

              if (tweenController.status == AnimationStatus.completed)
              {
                tweenController.reverse();
                setState(() {
                  controlUIVisible = false;
                });
              }
              else
              {
                tweenController.forward();
                setState(() {
                  controlUIVisible = true;
                });
              }
              print('on tap screen 1');
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
                    aspectRatio: videoController.value.aspectRatio,
                    child:
                    VideoPlayer(videoController),
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
                commentCanvas(),
                //contentComment(),
              ],
            ),
          )
          :
          Stack
          (
            children:
            [
              Align
              (
                alignment: Alignment.topCenter,
                child:
                Container
                (
                  height: 50,
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
                          Get.back();
                        },
                      ),
                      IconButton
                      (
                        onPressed: ()
                        {
                          //Get.off();
                          print('다음회차 보기 누름');
                        },
                        icon: Icon(Icons.skip_next), color: Colors.white, iconSize: 33,
                      )
                    ],
                  ),
                ),
              ),
              Center
              (
                child:
                //controlUI(context),
                CircularProgressIndicator()
              ),
            ],
          )
        )
      )
    );
  }

  double bottomOffset = -840.h;
  int tweenTime = 0;
  Widget commentCanvas()
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
          GestureDetector
          (
            onTap: ()
            {
              if (bottomOffset == 0)
              {
                setState(() {
                  bottomOffset = -840.h;
                });
              }
            },
            child:
            Stack
            (
              children:
              [
                Padding
                (
                  padding: const EdgeInsets.only(top: 250),
                  child: Container
                  (
                    width: 390.w,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [Colors.black.withOpacity(0), Colors.black],
                      ),
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
                    height: 550.h,
                    color: Colors.black,
                    child:
                    isShowReply == false ?
                    contentComment() : commentReply(),
                  ),
                ),
              ],
            ),

          ),
        );
      },
    );
  }

  //comment 관련
  var episodeCommentList = <EpisodeCommentData>[];
  var scrollController = ScrollController();
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
                        TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
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
                        TextStyle(fontSize: 11, color: commentSortType == CommentSortType.LIKE ? Colors.white : const Color(0xFF878787), fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
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
                        TextStyle(fontSize: 11, color: commentSortType == CommentSortType.LATEST ? Colors.white : const Color(0xFF878787), fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
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
              height: 505.h,
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
                        episodeCommentList[i].ID,
                        episodeCommentList[i].iconUrl!,
                        episodeCommentList[i].episodeNumber!,
                        episodeCommentList[i].date!,
                        episodeCommentList[i].name!,
                        episodeCommentList[i].isLikeCheck!,
                        episodeCommentList[i].commant!,
                        episodeCommentList[i].likeCount!,
                        episodeCommentList[i].replyCount!,
                        episodeCommentList[i].isOwner!,
                        episodeCommentList[i].isBest!,
                            (id)
                        {
                          //TODO : 좋아요 버튼 처리
                          print(id);
                        },
                            (id)
                        {
                          commentData = episodeCommentList[i];
                          //TODO : 답글 보기 처리.
                          isShowReply = true;
                          setState(() {

                          });
                          //Get.to(() => ReplyPage(), arguments: episodeCommentList[i]);
                        },
                            (id)
                        {
                          //TODO : 삭제 버튼 처리
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

  //TODO : Reply
  bool isShowReply = false;
  List<EpisodeCommentData> replyList = <EpisodeCommentData>[];
  EpisodeCommentData? commentData;

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
                setState(() {

                });
              },
            ),
          ),
          Expanded
          (
            child:
            ReplyPopup(scrollController, commentData!, replyList, 20),
          )
        ],
      ),
    );
  }

  void onEndOfPage() async
  {
    try
    {
      //여기서 리스트 요청하고 만들고 해야한다.
      // Replace with your method to fetch data from the server.
        await Future.delayed(Duration(seconds: 1),
        ()
        {
            print('update !');
            if (isShowReply)
            {

            }
            else
            {
              for(int i = 0; i < 10; ++i)
              {
                var commentData = EpisodeCommentData
                  (
                  name: '황후마마가 돌아왔다.',
                  commant: '이건 재미있다. 무조건 된다고 생각한다.',
                  date: '24.09.06',
                  episodeNumber: '11',
                  iconUrl: '',
                  ID: i,
                  isLikeCheck: i % 2 == 0,
                  likeCount: '12',
                  replyCount: '3',
                  isOwner: i == 0,
                  isBest: true,
                );
                episodeCommentList.add(commentData);
              }
            }

            print('episodeCommentList.length : ${episodeCommentList.length}');

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
}