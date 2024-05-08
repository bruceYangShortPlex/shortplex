import 'package:shortplex/Util/social_login.dart';

class LoginMananger
{
  final Social_Login _social_login;

  LoginMananger(this._social_login);

  Future<bool> LogIn() async
  {
    return await _social_login.Login();
  }

  Future<bool> LogOut() async
  {
    return await _social_login.Logout();
  }

  Future<bool> Check() async
  {
    return await _social_login.LoginCheck();
  }
}