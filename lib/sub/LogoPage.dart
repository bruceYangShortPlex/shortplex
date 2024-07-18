import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'CupertinoMain.dart';

class LogoPage extends StatefulWidget {
  @override
  _LogoPageState createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> with TickerProviderStateMixin
{
  // String text = '';
  // final String fullText = 'SHORTPLEX';

  //Completer<void> completer = Completer<void>();

  late final GifController gifController;

  Future<void> waitUntilCondition() async
  {
    // Completer가 완료될 때까지 대기합니다.
    //await completer.future;

    //로고씬에서 1초 머무르자.
    await Future.delayed(Duration(seconds: 1));

    //var loginMananger = Get.find<LoginMananger>();
    //print('login Check Start / loginMananger.isCheckComplete : ${loginMananger.isCheckComplete}');
    //await Future.doWhile(() async => !loginMananger.isCheckComplete);
    //print('login Check End');
    // 조건이 충족되면 실행할 함수를 호출합니다.
    Get.off(() => CupertinoMain(), transition: Transition.noTransition,); //duration: Duration(seconds: 1));
  }

  @override
  void initState()
  {
    gifController = GifController(vsync: this);
    super.initState();
    //Future.delayed(Duration(seconds: 1)).then((value) => completer.complete());

    gifController.addListener(()
    {
      if (gifController.status == AnimationStatus.completed )
      {
        if (kDebugMode)
        {
          print('logo play complete');
        }

        Get.off(() => CupertinoMain(), transition: Transition.noTransition,);
      }
    },);
  }

  // @override
  // void didChangeDependencies() async
  // {
  //   super.didChangeDependencies();
  //
  //   await waitUntilCondition();
  // }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      backgroundColor: Colors.black,
      body:
      Container
      (
        padding: const EdgeInsets.all(39),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.transparent,
        child:
        Column
        (
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            Gif
            (
              fit: BoxFit.contain,
              //fps: 30,
              duration: const Duration(seconds: 1),
              controller: gifController,
              autostart: Autostart.once,
              //repeat: ImageRepeat.repeat,
              placeholder: (context) =>
              const Center(child: SizedBox()),
              image: const AssetImage('assets/images/main/logo_ani.gif'),
            ),
            // ElevatedButton
            // (
            //   onPressed: ()
            //   {
            //     gifController.forward(from: 0);
            //   },
            //   child: Text('Click')
            // ),
          ],
        )

      )
      // Align
      // (
      //   alignment: Alignment.center,
      //   child:
      //   Column
      //   (
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [LogoImage(),],
      //   ),
      // ),
    );
  }

  Widget LogoImage() => Column(children:
  [
    Image.asset(
      'assets/images/main/shortplex.png',
      width: 82.w,
      height: 100.h,
      fit: BoxFit.contain,),
    SizedBox(height: 25,),
    Image.asset('assets/images/main/Shortplex_text_logo.png',width: 140.w, height: 21.w, fit: BoxFit.contain,),
    SizedBox(height: 15,),
  ],);
}


