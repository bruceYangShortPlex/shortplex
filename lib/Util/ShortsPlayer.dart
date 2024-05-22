import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ShortsPlayer extends StatefulWidget {
  final String shortsUrl;
  const ShortsPlayer({Key? key, required this.shortsUrl}) : super(key: key);

  @override
  State<ShortsPlayer> createState() => _ShortsPlayerState();
}

class _ShortsPlayerState extends State<ShortsPlayer> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState()
  {
    super.initState();
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.shortsUrl))
      ..initialize().then((value) {
        videoPlayerController.play();
        videoPlayerController.setLooping(true);
        videoPlayerController.setVolume(1);
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
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
        Container
        (
          alignment: Alignment.center,
          //color: Colors.blue,
          child:
          VideoPlayer(videoPlayerController),
        ),

      ),
    );

  }
}
