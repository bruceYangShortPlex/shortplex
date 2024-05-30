import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../Util/ShortplexTools.dart';
import '../table/StringTable.dart';

class ContentPlayer extends StatefulWidget {
  @override
  _ContentPlayerState createState() => _ContentPlayerState();
}

class _ContentPlayerState extends State<ContentPlayer> with SingleTickerProviderStateMixin
{
  late VideoPlayerController controller;
  // Add a variable to handle the time of video playback
  double currentTime = 0.0;
  int commentCount = 0;
  int usedPopcorn = 0;

  late AnimationController tweenController;
  bool _visible = false;

  @override
  void initState()
  {
    super.initState();

    controller = VideoPlayerController.networkUrl(
        Uri.parse("https://videos.pexels.com/video-files/17687288/17687288-uhd_2160_3840_30fps.mp4"))
      ..initialize().then((_) {
        setState(() {
          controller.play();
        });
      });

    tweenController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Add a listener to update the current time variable
    controller.addListener(()
    {
      if (controller.value.position >= controller.value.duration)
      {
        // 동영상 재생이 끝났을 때 실행할 로직
        print("동영상 재생이 끝났습니다.");
      }

      setState(()
      {
        currentTime = controller.value.position.inSeconds.toDouble();
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

  Widget contentUIButtons(String _buttonLabel, IconData _buttonIcon)
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
                  if (controller.value.isPlaying)
                    controller.pause();
                  else
                    controller.play();
                },
                child: Container
                (
                  alignment: Alignment.center,
                  padding: controller.value.isPlaying ? EdgeInsets.only(left: 0) : EdgeInsets.only(left: 5),
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
                    controller.value.isPlaying ? CupertinoIcons.pause_solid :
                    CupertinoIcons.play_arrow_solid, size: 40, color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          contentUIButtons('$commentCount', CupertinoIcons.ellipses_bubble),
          contentUIButtons(StringTable().Table![100023]!, CupertinoIcons.heart),
          contentUIButtons(StringTable().Table![100024]!, CupertinoIcons.share),
          contentUIButtons(StringTable().Table![100043]!, CupertinoIcons.info),
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
                max: controller.value.duration.inSeconds.toDouble(),
                onChanged: (value)
                {
                  setState(()
                  {
                    currentTime = value;
                    controller.seekTo(Duration(seconds: value.toInt()));
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
              '${formatDuration(controller.value.position)} / ${formatDuration(controller.value.duration)}',
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
          controller.value.isInitialized
              ?
          GestureDetector
          (
            onTap:
            ()
            {
              if (tweenController.status == AnimationStatus.completed)
              {
                tweenController.reverse();
                setState(() {
                  _visible = false;
                });
              }
              else
              {
                tweenController.forward();
                setState(() {
                  _visible = true;
                });
              }
              print('on tap screen');
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
                    aspectRatio: controller.value.aspectRatio,
                    child:
                    VideoPlayer(controller),
                  ),
                ),
                FadeTransition
                (
                  opacity: tweenController,
                  child:
                  IgnorePointer
                  (
                    ignoring: _visible == false,
                    child:
                    controlUI(context),
                  ),
                ),
              ],
            ),
          )
          :
          Center
          (
            child:
            //controlUI(context),
            CircularProgressIndicator()
          ),
            )
      )
        );
    //);
  }

  @override
  void dispose()
  {
    controller.dispose();
    tweenController.dispose();
    super.dispose();
  }
}