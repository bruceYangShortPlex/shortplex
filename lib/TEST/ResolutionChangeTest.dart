import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// void main() async
// {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const ShortsPlayer(shortsUrl: 'https://archive.org/download/Damas_BB_28F8B535_D_406/DaMaS.mp4'));
// }

class ShortsPlayer extends StatefulWidget
{
  final String shortsUrl;
  const ShortsPlayer({Key? key, required this.shortsUrl}) : super(key: key);

  @override
  State<ShortsPlayer> createState() => _ShortsPlayerState();
}

class _ShortsPlayerState extends State<ShortsPlayer>
{
  late VideoPlayerController videoController1;
  late VideoPlayerController videoController2;
  late VideoPlayerController videoController3;

  String defaultStream ='https://archive.org/download/Damas_BB_28F8B535_D_406/DaMaS.mp4';
  String stream2 = 'https://archive.org/download/cCloud_20151126/cCloud.mp4';
  String stream3 = 'https://archive.org/download/mblbhs/mblbhs.mp4';

  double currentTime = 0.0;

  int selectControllerNumber = 0;
  int reserveControllerNumber = 0;

  @override
  void initState()
  {
    super.initState();

    videoController1 = VideoPlayerController.networkUrl(Uri.parse(defaultStream))
      ..initialize().then((value)
      {
        videoController1.setVolume(1);

        if (selectControllerNumber == 0)
        {
        setState(() {

          videoController1.play();
            // videoController1.setLooping(true);

          });
        }
      });

    videoController1.addListener(() {
      if (videoController1.value.position >= videoController1.value.duration)
      {
        // 동영상 재생이 끝났을 때 실행할 로직
        print("동영상 재생이 끝났습니다.");
      }

      setState(()
      {
        if (selectControllerNumber == 0) {
          currentTime = videoController1.value.position.inSeconds.toDouble();
        }
      });
    });
/////////////////////////////
    videoController2 = VideoPlayerController.networkUrl(Uri.parse(defaultStream))
      ..initialize().then((value)
      {
        videoController2.setVolume(1);

        if (selectControllerNumber == 1)
        {
        setState(() {
          videoController2.play();
            //videoController2.setLooping(true);
          });
        }

      });

    videoController2.addListener(() {
      if (videoController2.value.position >= videoController2.value.duration)
      {
        // 동영상 재생이 끝났을 때 실행할 로직
        print("동영상 재생이 끝났습니다.");
      }

      setState(() {
        if (selectControllerNumber==1) {
          currentTime = videoController2.value.position.inSeconds.toDouble();
        }
      });
    });
/////////////////////////
    videoController3 = VideoPlayerController.networkUrl(Uri.parse(defaultStream))
      ..initialize().then((value)
      {
        videoController3.setVolume(1);
        if (selectControllerNumber ==2)
        {
          setState(()
          {
            videoController3.play();
            //videoController3.setLooping(true);
          });
        }
      });

    videoController3.addListener(() {
      if (videoController3.value.position >= videoController3.value.duration)
      {
        // 동영상 재생이 끝났을 때 실행할 로직
        print("동영상 재생이 끝났습니다.");
      }

      setState(()
      {
        if (selectControllerNumber == 2) {
          currentTime = videoController3.value.position.inSeconds.toDouble();
        }
      });
    });
  }

  VideoPlayerController getControlelr()
  {
    if (selectControllerNumber == 0)
    {
      print(0);
      return videoController1;
    }

    if (selectControllerNumber == 2)
    {
      print(1);
      return videoController3;
    }

    return videoController2;
  }

  void setChageController(int _reserve)
  {
    if (selectControllerNumber == _reserve) {
      return;
    }

    // if (getControlelr().value.position == getControlelr().value.duration)
    // {
    //   //영상 끝남
    //   print('영상 끝남');
    //   return;
    // }

    reserveControllerNumber = _reserve;

    if (_reserve == 0)
    {
      videoController1.seekTo(getControlelr().value.position).then((value)
      {
        if (reserveControllerNumber == 0)
        {
           setState(() {
             videoController1.play();
             videoController2.pause();
             videoController3.pause();
             selectControllerNumber = reserveControllerNumber;
           });
        }
      },);
    }

    if (_reserve == 1)
    {
      videoController2.seekTo(getControlelr().value.position).then((value)
      {
        if (reserveControllerNumber == 1)
        {
          setState(() {
            videoController2.play();
            videoController1.pause();
            videoController3.pause();
            selectControllerNumber = reserveControllerNumber;
          });
        }
      },);
    }

    if (_reserve == 2)
    {
      videoController3.seekTo(getControlelr().value.position).then((value)
      {
        if (reserveControllerNumber == 2)
        {
          setState(()
          {
            videoController3.play();
            videoController1.pause();
            videoController2.pause();
            selectControllerNumber = reserveControllerNumber;
          });
        }
      },);
    }
  }

  @override
  void dispose() {
    videoController1.dispose();
    videoController2.dispose();
    videoController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return
    MaterialApp(
      home: Stack
      (
        children:
        [
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
                VideoPlayer(getControlelr()),
              ),
            ),
          ),
      
          Align
          (
            alignment: Alignment.bottomCenter,
            child: Container
            (
              width: MediaQuery.of(context).size.width,
              height: 100,
              color: Colors.transparent,
              child:
              Row
              (
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:
                [
                  ElevatedButton(onPressed: ()
                  {
                    setChageController(0);
                  }, child: Text('1')),
                  ElevatedButton(onPressed: ()
                  {
                    setChageController(1);
                  }, child: Text('2')),
                  ElevatedButton(onPressed: ()
                  {
                    setChageController(2);
                  }, child: Text('3')),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
