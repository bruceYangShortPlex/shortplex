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

  @override
  void initState() {
    super.initState();
    //Future.delayed(Duration(seconds: 2));
    for (int i = 0; i < fullText.length; i++) {
      Future.delayed(Duration(milliseconds: 500 * (i + 2)), () {
        setState(() {
          text += fullText[i];
        });
      });
    }

    Timer(Duration(seconds: 7), ()
    {
      Get.off(CuperinoTabBar(), transition: Transition.fadeIn);
    });
  }

  @override
  Widget build(BuildContext context)
  {
    Timer(Duration(seconds: 7), ()
    {
      Get.off(CuperinoTabBar(), transition: Transition.fadeIn, duration: Duration(seconds: 1));
    });

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
