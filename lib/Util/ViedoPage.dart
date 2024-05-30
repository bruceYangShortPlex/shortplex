import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'theme.dart';

void main() => runApp
(
  const VideoPage(url: "https://videos.pexels.com/video-files/17687288/17687288-uhd_2160_3840_30fps.mp4",)
);

class VideoPage extends StatefulWidget
{
  const VideoPage
      (
        {super.key, required this.url}
      );

  final String url;

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage>
{
  TargetPlatform? _platform;
  late VideoPlayerController _videoPlayerController1;
  //late VideoPlayerController _videoPlayerController2;
  ChewieController? _chewieController;
  int? bufferDelay;

  @override
  void initState()
  {
    super.initState();
    _platform = TargetPlatform.iOS;

    initializePlayer();
  }

  @override
  void dispose()
  {
    _videoPlayerController1.dispose();
    //_videoPlayerController2.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async
  {
    _videoPlayerController1 =
        VideoPlayerController.networkUrl(Uri.parse(widget.url));
    //_videoPlayerController2 = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    await Future.wait([
      _videoPlayerController1.initialize(),
      //_videoPlayerController2.initialize()
    ]);
    _createChewieController();
    setState(() {});
  }

  void SetShowControlPanel(bool _visible)
  {
    _chewieController = _chewieController?.copyWith(showControls: _visible);
  }

  void _createChewieController()
  {
    // final subtitles = [
    //     Subtitle(
    //       index: 0,
    //       start: Duration.zero,
    //       end: const Duration(seconds: 10),
    //       text: 'Hello from subtitles',
    //     ),
    //     Subtitle(
    //       index: 0,
    //       start: const Duration(seconds: 10),
    //       end: const Duration(seconds: 20),
    //       text: 'Whats up? :)',
    //     ),
    //   ];

    // final subtitles = [
    //   Subtitle(
    //     index: 0,
    //     start: Duration.zero,
    //     end: const Duration(seconds: 10),
    //     text: const TextSpan(
    //       children: [
    //         TextSpan(
    //           text: 'Hello',
    //           style: TextStyle(color: Colors.red, fontSize: 22),
    //         ),
    //         TextSpan(
    //           text: ' from ',
    //           style: TextStyle(color: Colors.green, fontSize: 20),
    //         ),
    //         TextSpan(
    //           text: 'subtitles',
    //           style: TextStyle(color: Colors.blue, fontSize: 18),
    //         )
    //       ],
    //     ),
    //   ),
    //   Subtitle(
    //     index: 0,
    //     start: const Duration(seconds: 10),
    //     end: const Duration(seconds: 20),
    //     text: 'Whats up? :)',
    //     // text: const TextSpan(
    //     //   text: 'Whats up? :)',
    //     //   style: TextStyle(color: Colors.amber, fontSize: 22, fontStyle: FontStyle.italic),
    //     // ),
    //   ),
    // ];
    _chewieController =
      ChewieController
      (
        videoPlayerController: _videoPlayerController1,
        autoPlay: true,
        looping: false,
        aspectRatio: 9 / 16,
        fullScreenByDefault: true,
        //showControls: false,
        progressIndicatorDelay:
        bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,
        // additionalOptions: (context)
        // {
        //   return <OptionItem>
        //   [
        //     OptionItem
        //     (
        //       onTap: toggleVideo,
        //       iconData: Icons.live_tv_sharp,
        //       title: 'Toggle Video Src',
        //     ),
        //   ];
        // },
      //subtitle: Subtitles(subtitles),
      //   subtitleBuilder: (context, dynamic subtitle) => Container(
      //   padding: const EdgeInsets.all(10.0),
      //   child: subtitle is InlineSpan
      //       ? RichText(
      //     text: subtitle,
      //   )
      //       : Text(
      //     subtitle.toString(),
      //     style: const TextStyle(color: Colors.black),
      //   ),
      // ),

      hideControlsTimer: const Duration(seconds: 3),

      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      //autoInitialize: true,
    );
  }

  // int currPlayIndex = 0;
  // Future<void> toggleVideo() async
  // {
  //   await _videoPlayerController1.pause();
  //   currPlayIndex += 1;
  //   if (currPlayIndex >= srcs.length) {
  //     currPlayIndex = 0;
  //   }
  //   await initializePlayer();
  // }

  Widget player() =>
  Expanded
  (
    child:
    Center
    (
      child: _chewieController != null &&
          _chewieController!.videoPlayerController.value.isInitialized
          ?
      Chewie
      (
        controller: _chewieController!,
      )
      : const
      Column
      (
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        [
          CircularProgressIndicator(),
        ],
      ),
    ),
  );

  Widget mainWidget(BuildContext context)=>
  SafeArea
  (
    child:
    MaterialApp
    (
      theme: AppTheme.dark.copyWith(platform: _platform ?? Theme.of(context).platform,),
      home:
      Scaffold
      (
        backgroundColor: Colors.black,
        body:
        Container
        (
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child:
          player(),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context)
  {
    return mainWidget(context);
  }
}