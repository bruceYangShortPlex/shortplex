import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shortplex/Util/google_login.dart';
import 'package:shortplex/Util/social_login.dart';

class LoginMananger
{
  final Social_Login _social_login;

  LoginMananger(this._social_login);

  User? user;

  get token => user != null ? user?.uid : _social_login.token;
  get isLogin => user != null ? true : _social_login.isLogin;

  Future<bool> LogIn() async
  {
    try {
      await _social_login.Login();
    }
    catch (e)
    {
      print('Login Failed : ${e}');
    }
    user = FirebaseAuth.instance.currentUser;
    return isLogin;
  }

  Future<bool> LogOut() async
  {
    if (!isLogin) {
      print('already logout return');
      return true;
    }
    await FirebaseAuth.instance.signOut();
    await _social_login.Logout();
    user = null;

    return isLogin;
  }

  Future<bool> Check() async
  {
    user = FirebaseAuth.instance.currentUser;
    print('user : ${user}');
    print('user uid : ${user?.uid}');
    return user != null;
  }
}