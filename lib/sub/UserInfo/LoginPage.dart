import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shortplex/Util/LoginMananger.dart';
import 'package:shortplex/table/StringTable.dart';

import '../../table/UserData.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _buttonEnabled = true;

  var loginManager = Get.find<LoginMananger>();

  @override
  Widget build(BuildContext context)
  {
    return
      CupertinoApp
      (
        home: CupertinoPageScaffold
        (
          backgroundColor: Colors.black,
          navigationBar:
          CupertinoNavigationBar(backgroundColor: Colors.transparent,
            leading:
            CupertinoNavigationBarBackButton
            (
                color: Colors.white,
                //previousPageTitle: StringTable().Table![100019],
                onPressed: ()
                {
                  Get.back();
                },
            ),
          ),
          child: Align(
            alignment: Alignment.topCenter,
              child : Stack(  children:
              [
                Container( width: 390.w,
                height: 844.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-0.00, 1.00),
                    end: Alignment(0, -1),
                    colors: [Colors.black, Colors.black54],
                  ),
                ),),
                Container(
                    width: 390.w,
                    height: 844.h,
                    decoration:
                    BoxDecoration
                    (
                      gradient: LinearGradient(
                      begin: Alignment(1, 1),
                      end: Alignment(1, -3),
                      colors: [Color(0x000F60), Color(0xFF00FFBF),],
                    ),
                  ),
                ),
                Container
                (
                    child: Align(alignment: Alignment.center,
                      child:
                      Column
                      (
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:
                        [
                          LogoImage(),
                          Text(StringTable().Table![400062]!,style: TextStyle(color: Colors.white, fontSize: 16),),
                          Text(StringTable().Table![400063]!,style: TextStyle(color: Colors.white, fontSize: 16),),
                          SizedBox(height: 50,),
                          _LoginButtons(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
    Image.asset('assets/images/main/Shortplex_text_logo.png',width: 140.w, height: 21.h, fit: BoxFit.contain,),
    SizedBox(height: 15,),
  ],);


  Widget loginButton(String _imagePath, LoginType _type, int _stringTableID) =>
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          width: 200,
          height: 50,
          child: CupertinoButton(
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    _imagePath,
                  ),
                  Text(
                    StringTable().Table![_stringTableID]!,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontFamily: 'NotoSans',
                        fontWeight: FontWeight.w200),
                  )
                ],
              ),
              onPressed: _buttonEnabled
                  ? () async {
                      _buttonEnabled = false;
                      var result = await loginManager.LogIn(_type);
                      if (result) {
                        //var token = Get.find<Kakao_Login>().token;
                        //서버에 주고 로그인.
                      }
                      _buttonEnabled = true;
                    }
                  : null),
        ),
      );

  Widget _LoginButtons() =>
      Obx(() => UserData.to.isLogin.value == true
          ? IconButton(
              onPressed: _buttonEnabled
                  ? () async {
                      await loginManager.LogOut();
                      _buttonEnabled = true;
                      print('Logout');
                    }
                  : null,
              icon: Icon(Icons.cable_outlined),
            )
          : Column(
              children: [
                loginButton(
                    'assets/images/Public/Kakao_PNG.png', LoginType.kakao, 400064),
                loginButton('assets/images/Public/Facebook_PNG.png',
                    LoginType.facebook, 400066),
                loginButton(
                    'assets/images/Public/Google_PNG.png', LoginType.google, 400067),
                loginButton(
                    'assets/images/Public/Apple_PNG.png', LoginType.apple, 400068),

              ],
            ));
}

// Obx(() => Get.find<UserData>().photoUrl.value.isEmpty ? Container(color: Colors.black,) : Image.network('${Get.find<UserData>().photoUrl.value}', fit: BoxFit.cover),
// ),
