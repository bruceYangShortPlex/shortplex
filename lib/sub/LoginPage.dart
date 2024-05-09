import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shortplex/Util/LoginMananger.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _buttonEnabled = true;

  var loginManager = Get.find<LoginMananger>();

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: CupertinoNavigationBarBackButton(
            onPressed: () {
              Get.back();
            },
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: !loginManager.isLogin,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: _buttonEnabled
                            ? () async {
                                _buttonEnabled = false;
                                var result =
                                    await loginManager.LogIn(LoginType.kakao);
                                if (result) {
                                  //var token = Get.find<Kakao_Login>().token;
                                  //서버에 주고 로그인.
                                }
                                _buttonEnabled = true;

                                setState(() {});
                              }
                            : null,
                        icon: Image.asset('assets/images/Kakao_PNG.png'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      IconButton(
                        onPressed: _buttonEnabled
                            ? () async {
                                _buttonEnabled = false;
                                var result =
                                    await loginManager.LogIn();
                                if (result) {
                                  //var token = Get.find<Google_Login>().token;
                                  //서버에 주고 로그인.
                                }
                                _buttonEnabled = true;

                                setState(() {});
                              }
                            : null,
                        icon: Image.asset('assets/images/Google_PNG.png'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      IconButton(
                        onPressed: () {
                          print('click3');
                        },
                        icon: Image.asset('assets/images/kakao_login.kor.png'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      IconButton(
                        onPressed: () {
                          print('click4');
                        },
                        icon: Image.asset('assets/images/kakao_login.kor.png'),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: loginManager.isLogin,
                  child: IconButton(
                    onPressed: _buttonEnabled
                        ? () async {
                            await loginManager.LogOut();
                            _buttonEnabled = true;
                            setState(() {});
                            print('Logout');
                          }
                        : null,
                    icon: Image.asset('assets/images/kakao_login.kor.png'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

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
  }
}
