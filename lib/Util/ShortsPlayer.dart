import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'HttpProtocolManager.dart';

class ShortsPlayer extends StatefulWidget {
  final String shortsUrl;
  final String prevImage;
  const ShortsPlayer({super.key, required this.shortsUrl, required this.prevImage});

  @override
  State<ShortsPlayer> createState() => _ShortsPlayerState();
}

class _ShortsPlayerState extends State<ShortsPlayer> {
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
      alignment: Alignment.center,
      child:
      AspectRatio
      (
        aspectRatio: 9/16,
        child:
        FutureBuilder<VideoPlayerController>
        (
          future: controllerInit(),
          builder: (BuildContext context, AsyncSnapshot<VideoPlayerController> snapshot)
          {
            if (snapshot.connectionState == ConnectionState.done)
            {
              // VideoPlayerController가 초기화된 후에 play() 메서드를 호출합니다.
              // VideoPlayer 위젯을 빌드합니다.
              snapshot.data!.setVolume(1);
              snapshot.data!.setLooping(true);
              snapshot.data!.play();

              return VideoPlayer(snapshot.data!);
            }
            else
            {
              // VideoPlayerController가 초기화되는 동안 로딩 인디케이터를 표시합니다.
              return Image.network(widget.prevImage);
            }
          },
        ),
      ),
    );

  }
}
