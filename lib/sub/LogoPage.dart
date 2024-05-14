import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shortplex/Util/LoginMananger.dart';
import 'CupertinoMain.dart';

class LogoPage extends StatefulWidget {
  @override
  _LogoPageState createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  // String text = '';
  // final String fullText = 'SHORTPLEX';

  Completer<void> completer = Completer<void>();

  Future<void> waitUntilCondition() async
  {
    // Completer가 완료될 때까지 대기합니다.
    await completer.future;

    await Future.delayed(Duration(seconds: 1));

    var loginMananger = Get.find<LoginMananger>();
    print('login Check Start / loginMananger.isCheckComplete : ${loginMananger.isCheckComplete}');
    await Future.doWhile(() async => !loginMananger.isCheckComplete);
    print('login Check End');
    // 조건이 충족되면 실행할 함수를 호출합니다.
    Get.off(() => CupertinoMain(), transition: Transition.noTransition,); //duration: Duration(seconds: 1));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1)).then((value) => completer.complete());
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    await waitUntilCondition();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      backgroundColor: Colors.black,
      body: Align
        (
        alignment: Alignment.center,
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [LogoImage(),],
        ),
      ),
    );
  }

  Widget LogoImage() => Column(children:
  [
    Image.asset(
      'assets/images/shortplex.png',
      width: 82.w,
      height: 100.w,
      fit: BoxFit.contain,),
    SizedBox(height: 25,),
    Image.asset('assets/images/Shortplex_text_logo.png',width: 140.w, height: 21.w, fit: BoxFit.contain,),
    SizedBox(height: 15,),
  ],);
}


