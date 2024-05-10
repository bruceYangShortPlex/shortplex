import 'package:firebase_auth/firebase_auth.dart' as firebaseUser;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as KakaoUser;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shortplex/Util/google_login.dart';
import 'package:shortplex/Util/kakao_login.dart';
import 'package:shortplex/Util/social_login.dart';
import 'package:get/get.dart';
import 'package:shortplex/sub/UserInfoPage.dart';

import '../sub/FirebaseSetting.dart';

enum LoginType
{
  kakao,
  google,
  apple,
  facebook,
}

class LoginMananger
{
  late Social_Login? _social_login;

  bool isCheckComplete = false;

  firebaseUser.User? User;
  KakaoUser.User? kakaoUser;

  get token => User != null ? User?.uid : _social_login?.token;
  bool get isLogin
  {
    if (User == null && _social_login == null)
    {
      return false;
    }

    return User != null? true : _social_login!.isLogin;
  }

  Future<bool> LogIn([LoginType type = LoginType.google]) async
  {
    try
    {
      switch (type)
      {
        case LoginType.kakao:
          _social_login = Get.find<Kakao_Login>();
          break;
        case LoginType.google:
          _social_login = Get.find<Google_Login>();
          break;
        // TODO: Handle this case.
        case LoginType.apple:
          break;
        // TODO: Handle this case.
        case LoginType.facebook:
          break;
        default:
          print('not found case ${type}');
          break;
      }
      await _social_login?.Login();
    }
    catch (e)
    {
      print('Login Failed : ${e}');
    }

    if (type == LoginType.kakao)
    {
      kakaoUser = Get.find<Kakao_Login>().user;
      Get.find<UserData>().name.value = kakaoUser!.kakaoAccount!.profile!.nickname as String;
      Get.find<UserData>().photoUrl.value = kakaoUser!.kakaoAccount!.profile!.profileImageUrl as String;
    }
    else
    {
      User = FirebaseAuth.instance.currentUser;
      Get.find<UserData>().name.value = User!.displayName as String;
      Get.find<UserData>().photoUrl.value = User!.photoURL as String;
    }

    print('token : ${token}');

    return isLogin;
  }

  Future<bool> LogOut() async
  {
    if (!isLogin)
    {
      print('already logout return');
      return true;
    }
    await FirebaseAuth.instance.signOut();
    await _social_login?.Logout();
    User = null;
    kakaoUser = null;
    Get.find<UserData>().InitValue();

    return isLogin;
  }

  Future<bool> Check() async
  {
    await FirebaseSetting().Setup();

    User = FirebaseAuth.instance.currentUser;
    print('user : ${User}');
    if (User == null)
    {
      //카카오체크해야한다.
      KakaoSdk.init(nativeAppKey: 'fb25da9b9589891ac497820e14c180d7');
      _social_login = Get.find<Kakao_Login>();
      await _social_login!.LoginCheck();
      kakaoUser = Get.find<Kakao_Login>().user;

      Get.find<UserData>().name.value = kakaoUser!.kakaoAccount!.profile!.nickname as String;
      Get.find<UserData>().photoUrl.value = kakaoUser!.kakaoAccount!.profile!.profileImageUrl as String;
    }
    else
    {
      Get.find<UserData>().name.value = User!.displayName as String;
      Get.find<UserData>().photoUrl.value = User!.photoURL as String;
    }

    isCheckComplete = true;

    print('token : ${token}');

    return User != null;
  }
}