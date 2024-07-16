import 'package:firebase_auth/firebase_auth.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shortplex/Util/HttpProtocolManager.dart';
import 'package:shortplex/Util/facebook_login.dart';
import 'package:shortplex/Util/google_login.dart';
import 'package:shortplex/Util/kakao_login.dart';
import 'package:shortplex/Util/social_login.dart';
import 'package:get/get.dart';

import '../Network/OAuthLogin.dart';
import 'FirebaseSetting.dart';
import '../table/UserData.dart';

enum LoginType
{
  guest,
  kakao,
  google,
  apple,
  facebook,
}

class LoginMananger
{
  late Social_Login? _social_login;
  bool isCheckComplete = false;
  bool isLogin = false;

  // bool get isLogin
  // {
  //   if (User == null && _social_login == null)
  //   {
  //     return false;
  //   }
  //
  //   return User != null ? true : _social_login!.isLogin;
  // }

  Future<bool> LogIn([LoginType _loginType = LoginType.google]) async
  {
    Get.lazyPut(() => Kakao_Login());
    Get.lazyPut(() => Google_Login());
    Get.lazyPut(()=> FaceBook_Login());
    Get.lazyPut(() => HttpProtocolManager());

    try
    {
      switch (_loginType)
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
        case LoginType.facebook:
          _social_login = Get.find<FaceBook_Login>();
          break;
        default:
          print('not found case ${_loginType}');
          break;
      }

      await _social_login!.Login();
      isLogin = _social_login!.isLogin;
      print('LogIn result : ${isLogin}');
    }
    catch (e)
    {
      print('Login Failed : ${e}');
      return false;
    }

    Send_OAuthLogin(_loginType);
    return isLogin;
  }

  Future<bool> LogOut() async
  {
    if (!UserData.to.isLogin.value)
    {
      print('already logout return');
      return true;
    }

    try
    {
      var userData = Get.find<UserData>();

      if (userData.providerid == 'kakao')
      {
        if (_social_login != null) {
          isLogin = await _social_login!.Logout();
        }
      }
      else
      {
        await FirebaseAuth.instance.signOut();
        isLogin = false;
      }
    }
    catch (e)
    {
      print('Log Out Fail ${e}');
    }

    print('Logout result : ${isLogin}');

    if (!isLogin)
    {
      Get.lazyPut(()=>HttpProtocolManager());
      var logout = await HttpProtocolManager.to.Send_Logout();
      if (logout)
      {
        UserData.to.InitValue();
      }
    }

    return isLogin;
  }

  Future<bool> Check() async
  {
    print('Login Manager Check Start');

    Get.lazyPut(() => Kakao_Login());
    Get.lazyPut(() => Google_Login());
    Get.lazyPut(()=> FaceBook_Login());
    Get.lazyPut(() => HttpProtocolManager());

    await FirebaseSetting().Setup();
    var loginType = LoginType.guest;
    try
    {
      var firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser == null)
      {
        //카카오체크해야한다.
        KakaoSdk.init(nativeAppKey: 'fb25da9b9589891ac497820e14c180d7');
        _social_login = Get.find<Kakao_Login>();
        var result = await _social_login!.LoginCheck();
        if (result) {
          loginType = LoginType.kakao;
        }
        isLogin = _social_login!.isLogin;
      }
      else
      {
        final providerId = firebaseUser.providerData[0].providerId;
        if (providerId == 'google.com')
        {
          loginType = LoginType.google;
        }
        else if (providerId == 'facebook.com')
        {
          loginType = LoginType.facebook;
        }
        else
        {
          print('User signed in with $providerId');
        }

        isLogin = true;
      }
    }
    catch (e)
    {
      print('login check Error : ${e}');
    }

    isCheckComplete = true;

    if (isLogin)
      Send_OAuthLogin(loginType);

    print('Login Manager Check Complete');
    return isLogin;
  }

  Send_OAuthLogin(LoginType loginType) async
  {
    var userData = SetUserData(loginType);
    if (userData.isLogin == false)
    {
      print('is Login false return');
      return;
    }

    var manager = HttpProtocolManager.to;
    var oauthLogin = OAuthLogin
    (
      email: userData.email,
      displayname: userData.name.value,
      photourl: userData.photoUrl.value,
      privacypolicies: userData.privacypolicies,
      providerid: userData.providerid,
      provideruserid: userData.providerUid,
    );

    var result = await manager.Send_OAuthLogin(oauthLogin);
    if (result != null)
    {
      userData.userId = result.userId!;
      userData.id = result.id!;
      print('Login Sucess! ${userData}');
    }

    await manager.Get_UserInfo().then((value)
    {
      //TODO : 유저인포(userinfo) 처리해야한다. //리스트인게 이상함.문의해야.
      if(value != null)
      {

      }
    },);

    userData.isLogin.value = isLogin;
  }

  UserData SetUserData(LoginType _loginType)
  {
    var userData = UserData.to;
    var providerid = _loginType.toString().replaceAll('LoginType.', '');
    userData.providerid = providerid;
    if (_loginType == LoginType.kakao)
    {
      var kakaoUser = Get.find<Kakao_Login>().user;
      userData.name.value = kakaoUser.kakaoAccount!.profile!.nickname!;
      userData.photoUrl.value = kakaoUser.kakaoAccount!.profile!.profileImageUrl!;
      userData.email = kakaoUser.kakaoAccount!.email!;
      userData.providerUid = kakaoUser.id.toString();
      userData.privacypolicies = 'true';
    }
    else
    {
      var firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser != null)
      {
        userData.name.value = firebaseUser.displayName!;
        userData.photoUrl.value = firebaseUser.photoURL!;
        userData.email = firebaseUser.email!;
        userData.providerUid = firebaseUser.uid;
        userData.privacypolicies = 'true';
      }
    }

    print('Set User Data / isLogin : ${isLogin} / _loginType : ${_loginType}');
    userData.isLogin.value = isLogin;

    print(userData);
    return userData;
  }
}