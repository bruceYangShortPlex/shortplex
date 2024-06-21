import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(VideoPlayerApp());

class VideoPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player Demo',
      home: Container(
          padding: EdgeInsets.all(100),
          color: Colors.black,
          child: VideoPlayerScreen()),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen>
{
  late VideoPlayerController _controller1;
  late VideoPlayerController _controller2;
  late VideoPlayerController _controller3;

  late VideoPlayerController _controller;
  late double _playBackTime;

  //The values that are passed when changing quality
  late Duration newCurrentPosition;

  String defaultStream = 'https://archive.org/download/Damas_BB_28F8B535_D_406/DaMaS.mp4';
  String stream2 = 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
  String stream3 = 'https://archive.org/download/mblbhs/mblbhs.mp4';

  @override
  void initState() {
    _controller = VideoPlayerController.networkUrl(Uri.parse(defaultStream));
    _controller.addListener(() {
      setState(() {
        _playBackTime = _controller1.value.position.inSeconds.toDouble();
      });
    });

    super.initState();
  }

  @override
  void dispose() {

    _controller?.pause()?.then((_) {
      _controller.dispose();
    });
    super.dispose();
  }

  Future<bool> _clearPrevious() async {
    await _controller?.pause();
    return true;
  }

  Future<void> _initializePlay(String videoPath) async {
    _controller = VideoPlayerController.networkUrl(Uri.parse(videoPath));
    _controller.addListener(() {
      setState(() {
        _playBackTime = _controller.value.position.inSeconds.toDouble();
      });
    });
  }

  void _getValuesAndPlay(String videoPath) {
    newCurrentPosition = _controller.value.position;
    _startPlay(videoPath);
    print(newCurrentPosition.toString());
  }

  Future<void> _startPlay(String videoPath) async {

    Future.delayed(const Duration(milliseconds: 200), () {
      _clearPrevious().then((_) {
        _initializePlay(videoPath);
      });
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return  Stack(
            children: <Widget>[
              Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  // Use the VideoPlayer widget to display the video.
                  child: VideoPlayer(_controller),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.black54,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: FloatingActionButton(
                          onPressed: () {
                            // Wrap the play or pause in a call to `setState`. This ensures the
                            // correct icon is shown.
                            setState(() {
                              // If the video is playing, pause it.
                              if (_controller.value.isPlaying) {
                                _controller.pause();
                              } else {
                                // If the video is paused, play it.
                                _controller.play();
                              }
                            });
                          },
                          // Display the correct icon depending on the state of the player.
                          child: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          _controller.value.position
                              .toString()
                              .split('.')
                              .first
                              .padLeft(8, "0"),
                        ),
                      ),
                      Container(
                        child: ElevatedButton(
                          //color: Colors.yellow,
                          onPressed: () {
                            _getValuesAndPlay(defaultStream);
                          },
                          child: Text('Default Stream'),
                        ),
                      ),
                      Container(
                        child: ElevatedButton(
                          //color: Colors.red,
                          onPressed: () {
                            _getValuesAndPlay(stream2);
                          },
                          child: Text('Video Stream 2'),
                        ),
                      ),
                      Container(
                        child: ElevatedButton(
                          //color: Colors.green,
                          onPressed: () {
                            _getValuesAndPlay(stream3);

                            print('Green Button');
                          },
                          child: Text('Video Stream 3'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );

  }
}