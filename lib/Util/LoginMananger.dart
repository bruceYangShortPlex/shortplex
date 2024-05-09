import 'package:firebase_auth/firebase_auth.dart' as firebaseUser;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as KakaoUser;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shortplex/Util/google_login.dart';
import 'package:shortplex/Util/social_login.dart';

class LoginMananger
{
  final Social_Login _social_login;

  LoginMananger(this._social_login);

  firebaseUser.User? User;
  KakaoUser.User? kakaoUser;

  get token => User != null ? User?.uid : _social_login.token;
  bool get isLogin
  {
    if (User == null && _social_login == null)
    {
      return false;
    }

    return User != null? true : _social_login.isLogin;
  }

  Future<bool> LogIn() async
  {
    try {
      await _social_login?.Login();
    }
    catch (e)
    {
      print('Login Failed : ${e}');
    }
    User = FirebaseAuth.instance.currentUser;
    return isLogin;
  }

  Future<bool> LogOut() async
  {
    if (!isLogin) {
      print('already logout return');
      return true;
    }
    await FirebaseAuth.instance.signOut();
    await _social_login?.Logout();
    User = null;

    return isLogin;
  }

  Future<bool> Check() async
  {
    User = FirebaseAuth.instance.currentUser;
    print('user : ${User}');
    print('user uid : ${User?.uid}');
    if (User == null)
    {
      //카카오체크해야한다.

      return await _social_login.LoginCheck();
    }

    KakaoSdk.init(nativeAppKey: 'fb25da9b9589891ac497820e14c180d7');

    return User != null;
  }
}