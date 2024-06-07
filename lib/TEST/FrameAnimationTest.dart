import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimationPage(),
    );
  }
}

enum AnimationStatType
{
  START,
  LOOP,
  END,
}

class AnimationPage extends StatefulWidget {
  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;
  late Animation<int> _animation;
  int _frameIndex = 0;
  AnimationStatType animationStatType = AnimationStatType.START;

  List<String> _firstAnimationFrames =
  [
    'assets/images/Reward/event_popcorn/Reward_event_popcorn_play_1.png',
    'assets/images/Reward/event_popcorn/Reward_event_popcorn_play_1.png',
    'assets/images/Reward/event_popcorn/Reward_event_popcorn_play_2.png',
    'assets/images/Reward/event_popcorn/Reward_event_popcorn_play_3.png',
    'assets/images/Reward/event_popcorn/Reward_event_popcorn_play_4.png',
    'assets/images/Reward/event_popcorn/Reward_event_popcorn_play_5.png',
  ];

  List<String> _loopAnimationFrames =
  [
    'assets/images/Reward/event_popcorn/Reward_event_popcorn_play_6.png',
    'assets/images/Reward/event_popcorn/Reward_event_popcorn_play_7.png',
    'assets/images/Reward/event_popcorn/Reward_event_popcorn_play_8.png',
    'assets/images/Reward/event_popcorn/Reward_event_popcorn_play_9.png',
    'assets/images/Reward/event_popcorn/Reward_event_popcorn_play_10.png',
  ];

  List<String> _secondAnimationFrames = [
    'assets/images/Reward/event_popcorn/Reward_event_popcorn_play_11.png',
    'assets/images/Reward/event_popcorn/Reward_event_popcorn_play_12.png',
    'assets/images/Reward/event_popcorn/Reward_event_popcorn_play_13.png',
    'assets/images/Reward/event_popcorn/Reward_event_popcorn_play_14.png',
    'assets/images/Reward/event_popcorn/Reward_event_popcorn_play_15.png',
    'assets/images/Reward/event_popcorn/Reward_event_popcorn_play_16.png',
    'assets/images/Reward/event_popcorn/Reward_event_popcorn_play_17.png',
    'assets/images/Reward/event_popcorn/Reward_event_popcorn_play_18.png',
    'assets/images/Reward/event_popcorn/Reward_event_popcorn_play_19.png',
    'assets/images/Reward/event_popcorn/Reward_event_popcorn_play_20.png',
    'assets/images/Reward/event_popcorn/Reward_event_popcorn_play_21.png',
    'assets/images/Reward/event_popcorn/Reward_event_popcorn_play_22.png',
    'assets/images/Reward/event_popcorn/Reward_event_popcorn_play_23.png',
    'assets/images/Reward/event_popcorn/Reward_event_popcorn_play_24.png',
    'assets/images/Reward/event_popcorn/Reward_event_popcorn_play_25.png',
  ];

  @override
  void initState() {
    super.initState();
    _startFirstAnimation();
  }

  void _startFirstAnimation()
  {
    animationStatType = AnimationStatType.START;

    _controller1 = AnimationController(
      duration: Duration(milliseconds: 500), // Adjust the duration as needed
      vsync: this,
    );

    _frameIndex = 0;

    _animation = IntTween(begin: 0, end: _firstAnimationFrames.length - 1).animate(_controller1)
      ..addListener(() {
        setState(()
        {
          print(_animation.value);
          _frameIndex = _animation.value;
        });
      })
      ..addStatusListener((status)
      {
        if (status == AnimationStatus.completed)
        {
          print('play loop');
          _playLoopAnimation();
          return;
        }
      });

    _controller1.forward();
  }

  void _playLoopAnimation()
  {
    animationStatType = AnimationStatType.LOOP;
    _controller1.stop();

    _frameIndex = 0;

    _controller2 = AnimationController
    (
      duration: Duration(milliseconds: 500), // Adjust the duration as needed
      vsync: this,
    );

    _animation = IntTween(begin: 0, end: _loopAnimationFrames.length - 1).animate(_controller2)
      ..addListener(() {
        setState(() {
          _frameIndex = _animation.value;
        });
      })
      ..addStatusListener((status)
      {
        if (status == AnimationStatus.completed)
        {
          print('repeat');
          _controller2.repeat();
          return;
        }
      });

    _controller2.forward();
  }

  void _playSecondAnimation() {
    _controller2.stop();
    animationStatType = AnimationStatType.END;
    _frameIndex = 0;
    _controller3 = AnimationController(
      duration: Duration(milliseconds: 1000), // Adjust the duration as needed
      vsync: this,
    );

    _animation = IntTween(begin: 0, end: _secondAnimationFrames.length - 1).animate(_controller3)
      ..addListener(() {
        setState(() {
          _frameIndex = _animation.value;
        });
      })
      ..addStatusListener((status)
      {
        if (status == AnimationStatus.completed) {
          _controller3.stop();
         return;
        }
      });

    _controller3.forward();
  }

  @override
  void dispose() {
    _controller2.dispose();
    _controller3.dispose();
    _controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String currentFrame = animationStatType == AnimationStatType.START ? _firstAnimationFrames[_frameIndex]
    :animationStatType == AnimationStatType.LOOP ? _loopAnimationFrames[_frameIndex] : _secondAnimationFrames[_frameIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(currentFrame),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _playSecondAnimation,
              child: Text('Play Second Animation'),
            ),
          ],
        ),
      ),
    );
  }
}
