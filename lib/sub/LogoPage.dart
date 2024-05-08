import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'CupertinoMain.dart';

class LogoPage extends StatefulWidget {
  @override
  _LogoPageState createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  String text = '';
  final String fullText = 'SHORT FLEX';

  Completer<void> completer = Completer<void>();

  Future<void> waitUntilCondition() async {
    // Completer가 완료될 때까지 대기합니다.
    await completer.future;

    // 조건이 충족되면 실행할 함수를 호출합니다.
    Get.off(() => CupertinoMain(), transition: Transition.fadeIn, duration: Duration(seconds: 1));
  }

  @override
  void initState() {
    super.initState();
    //Future.delayed(Duration(seconds: 2));
    for (int i = 0; i < fullText.length; i++) {
      Future.delayed(Duration(milliseconds: 500 * (i + 2)), () {
        setState(() {
          text += fullText[i];
          if (text.length == fullText.length)
          {
            Future.delayed(Duration(seconds: 2));
            completer.complete();
          }
        });
      });
    }

    // WidgetsBinding.instance.addPostFrameCallback((_)
    // {
    //
    // });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    await waitUntilCondition();
  }

  @override
  Widget build(BuildContext context)
  {
    // Timer(Duration(seconds: 7), ()
    // {
    //   Get.off(() => CupertinoMain(), transition: Transition.fadeIn, duration: Duration(seconds: 1));
    // });

    return Scaffold
      (
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/shortplex.png',
                width: 200,
                height: 100,
                fit: BoxFit.contain,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'NotoSans', fontWeight: FontWeight.w100, fontSize: 30, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
