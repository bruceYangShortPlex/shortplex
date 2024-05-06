import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return

      // Scaffold(
      //   body: Align(
      //     alignment: Alignment.bottomCenter,
      //     child: Padding(
      //       padding: EdgeInsets.only(bottom: 50.0), // 원하는 거리를 설정하세요.
      //       child: ElevatedButton(
      //         onPressed: () {
      //           // 버튼이 눌렸을 때 수행할 작업을 여기에 작성하세요.
      //         },
      //         child: Text('버튼'),
      //       ),
      //     ),
      //   ),
      // );

      CupertinoApp(
        home: Padding(
        padding: const EdgeInsets.only(bottom: 200),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              IconButton(
                onPressed: () {
                  print('click1');
                },
                icon: Image.asset('assets/images/kakao_login.kor.png'),
              ),
              SizedBox(height: 5,),
              IconButton(
                onPressed: () {
                  print('click2');
                },
                icon: Image.asset('assets/images/kakao_login.kor.png'),
              ),
                SizedBox(height: 5,),
              IconButton(
                onPressed: () {
                  print('click3');
                },
                icon: Image.asset('assets/images/kakao_login.kor.png'),
              ),
                SizedBox(height: 5,),
              IconButton(
                onPressed: () {
                  print('click4');
                },
                icon: Image.asset('assets/images/kakao_login.kor.png'),
              )
            ],
          ),
        ),

    );
  }
}
