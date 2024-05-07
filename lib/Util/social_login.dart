abstract class Social_Login
{
  late String token;
  late bool isLogin;
  Future<bool> Login();
  Future<bool> Logout();
  Future<bool> LoginCheck();
}