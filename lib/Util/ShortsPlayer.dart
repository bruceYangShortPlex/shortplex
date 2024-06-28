import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shortplex/table/UserData.dart';
import 'package:video_player/video_player.dart';

import 'HttpProtocolManager.dart';

class ShortsPlayer extends StatefulWidget {
  final String shortsUrl;
  final String prevImage;
  const ShortsPlayer({super.key, required this.shortsUrl, required this.prevImage});

  @override
  State<ShortsPlayer> createState() => _ShortsPlayerState();
}

class _ShortsPlayerState extends State<ShortsPlayer>
{
  late VideoPlayerController videoPlayerController;

  @override
  void initState()
  {
    super.initState();
  }

  Future<VideoPlayerController> controllerInit() async
  {
    var url = await HttpProtocolManager.to.Get_streamUrl(widget.shortsUrl);
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));
    await videoPlayerController.initialize();
    return videoPlayerController;
  }

  @override
  void dispose()
  {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return
    Container
    (
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child:
      FutureBuilder<VideoPlayerController>
      (
        future: controllerInit(),
        builder: (BuildContext context, AsyncSnapshot<VideoPlayerController> snapshot)
        {
          if (snapshot.connectionState == ConnectionState.done)
          {
            return
            Obx(()
            {
              if (UserData.to.isOpenPopup.value)
              {
                if (snapshot.data!.value.isPlaying) {
                  snapshot.data!.pause();
                }
              }
              else
                {
                  if (snapshot.data!.value.isPlaying) {
                    snapshot.data!.pause();
                  }
                  else
                    {
                      snapshot.data!.setVolume(1);
                      snapshot.data!.setLooping(true);
                      snapshot.data!.play();
                    }
                }

              return
              VideoPlayer(snapshot.data!);
            },);
          }
          else
          {
            // VideoPlayerController가 초기화되는 동안 로딩 인디케이터를 표시합니다.
            return Image.network(widget.prevImage);
          }
        },
      ),
    );
  }
}
