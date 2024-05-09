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

  Future<bool> LogIn() async
  {
    return await _social_login.Login();
  }

  Future<bool> LogOut() async
  {
    await FirebaseAuth.instance.signOut();

    return await _social_login.Logout();
  }

  Future<bool> Check() async
  {
    user = FirebaseAuth.instance.currentUser;
    if (user != null)
    {
      return true;
    }

    return await _social_login.LoginCheck();
  }

}