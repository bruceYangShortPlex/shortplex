import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shortplex/sub/ShopPage.dart';
import 'package:shortplex/table/UserData.dart';
import 'package:video_player/video_player.dart';

import '../Util/ShortplexTools.dart';
import '../table/StringTable.dart';
import 'ContentInfoPage.dart';
import 'NextContentPlayer.dart';
import 'ReplyPage.dart';

enum ContentPlayButtonType
{
  COMMENT,
  CHECK,
  SHARE,
  CONTENT_INFO,
}

class ContentPlayer extends StatefulWidget
{
  @override
  _ContentPlayerState createState() => _ContentPlayerState();
}

class _ContentPlayerState extends State<ContentPlayer> with TickerProviderStateMixin
{
  VideoPlayerController? videoController;
  // Add a variable to handle the time of video playback
  double currentTime = 0.0;
  int commentCount = 0;
  double tweenDelay = 3;
  double commentScrollOffset = 0;
  late Ticker ticker;

  late AnimationController tweenController;
  bool controlUIVisible = false;
  ContentData? contentData;
  bool isShowContent = false;

  @override
  void initState()
  {
    contentData = Get.arguments as ContentData;
    print('play content ${contentData!.id} / cost ${contentData!.cost}');

    //팝콘이 부족하지 않은지 확인. 콘텐츠 비용은 어디서 받아와야할지 생각해보자.
    if (contentData!.isLock)
    {
      print('check cost');

      var userData = Get.find<UserData>();
      //구독중이면 그냥 다음진행.
      if (userData.isSubscription == false)
      {
        //다음회차의 가격을 알아온다.
        var cost = userData.GetContentCost(contentData!.id!);
        if (userData.popcornCount + userData.bonusCornCount < cost)
        {
          isShowContent = false;
          isShowShop =  true;
          bottomOffset = 0;
          setState(() {

          });
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
    }
    else
    {
      isShowContent = true;
    }


    void VideoControllerInit() {
      var uri = "https://videos.pexels.com/video-files/17687288/17687288-uhd_2160_3840_30fps.mp4";
      videoController = VideoPlayerController.networkUrl(Uri.parse(uri))
        ..initialize().then((_) {
          setState(() {
            if (isShowContent) {
              videoController!.play();
            }
          });
        });

      videoController!.addListener(() {
        if (videoController!.value.position >= videoController!.value.duration) {
          // 동영상 재생이 끝났을 때 실행할 로직
          print("동영상 재생이 끝났습니다.");
        }

        setState(() {
          currentTime = videoController!.value.position.inSeconds.toDouble();
        });
      });
    }

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

    super.initState();
  }

  @override
  void dispose()
  {
    ticker.dispose();
    replyScrollController.dispose();
    videoController!.dispose();
    tweenController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() async
  {
    super.didChangeDependencies();

  }

  void setScrollPosition(double _offset) {
    scrollController.animateTo(
      _offset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
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
                  isShowShop = false;
                  ticker.stop();
                  controlUIVisible = false;
                  isShowReply = false;
                  tweenTime = 300;
                  bottomOffset = 0;
                  tweenController.reverse();
                  setState(()
                  {
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
                      if (isShowContent == true)
                      {
                        print('다음 회차 시부레');
                        Get.off(NextContentPlayer(), arguments: UserData.to.ContentDatas[contentData!.id! + 1]);
                        return;
                      }
                      else {
                        isShowShop = true;
                      }

                      bottomOffset = 0;
                      setState(() {

                      });
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
                  ticker.stop();
                  ticker.start();

                  if (videoController!.value.isPlaying)
                    videoController!.pause();
                  else
                    videoController!.play();
                },
                child: Container
                (
                  alignment: Alignment.center,
                  padding: videoController!.value.isPlaying ? EdgeInsets.only(left: 0) : EdgeInsets.only(left: 5),
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
                    videoController!.value.isPlaying ? CupertinoIcons.pause_solid :
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
                max: videoController!.value.duration.inSeconds.toDouble(),
                onChanged: (value)
                {
                  ticker.stop();
                  ticker.start();
                  setState(()
                  {
                    currentTime = value;
                    videoController!.seekTo(Duration(seconds: value.toInt()));
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
              '${formatDuration(videoController!.value.position)} / ${formatDuration(videoController!.value.duration)}',
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
                  backgroundColor: Colors.black,
                  child:
                  videoController != null &&
                  videoController!.value.isInitialized
                      ?
                  GestureDetector
                    (
                    onTap:
                        () {
                      if (bottomOffset == 0) {
                        bottomOffset = -840.h;
                        setState(() {

                        });
                        return;
                      }

                      if (tweenController.status == AnimationStatus.completed) {
                        tweenController.reverse();
                        ticker.stop();
                        setState(() {
                          controlUIVisible = false;
                        });
                      }
                      else {
                        tweenController.forward();
                        ticker.start();
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
                            aspectRatio: videoController!.value.aspectRatio,
                            child:
                            VideoPlayer(videoController!),
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
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              IconButton
                                (
                                onPressed: () {
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
                            false,
                            (id)
                        {
                          //TODO : 좋아요 버튼 처리
                          print(id);
                        },
                            (id)
                        {
                          commentData = episodeCommentList[i];
                          isShowReply = true;
                          commentScrollOffset = scrollController.offset;
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
                print('on tap reply off');
                setState(()
                {
                   setScrollPosition(commentScrollOffset);
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
              print('replyList.length : ${replyList.length}');
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
              print('episodeCommentList.length : ${episodeCommentList.length}');
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
                                  style: TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                                ),
                                SizedBox(height: 8,),
                                Text
                                (
                                  SetTableStringArgument(400025, ['${contentData!.cost}', '${UserData.to.popcornCount + UserData.to.bonusCornCount}'])
                                  ,
                                  style: TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
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
                          child: Container
                          (
                            alignment: Alignment.topLeft,
                            //color: Colors.green,
                            child:
                            Stack
                            ( alignment: Alignment.center,
                              children:
                              [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Container
                                  (
                                    width: 32,
                                    height: 32,
                                    color: Colors.grey,
                                  ),
                                ),
                                Padding
                                (
                                  padding: const EdgeInsets.only(top: 50),
                                  child:
                                  Text
                                  (
                                    StringTable().Table![400026]!,
                                    style: TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ShopGoods(false),
              Row
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
                      style: TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                    ),
                  ),

                ],
              )
            ],
          ),
      ),
    );
  }

  bool isChecked = true;
  Widget toggleButton() =>
      Transform.scale
        (
        scale: 0.7,
        child:
        CupertinoSwitch
          (
          value: isChecked,
          activeColor: Color(0xFF00FFBF),
          onChanged: (bool? value)
          {
            //TODO : 서버에 알리기
            setState(()
            {
              isChecked = value ?? false;
            });
          },
        ),
      );
}