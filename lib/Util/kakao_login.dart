import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'social_login.dart';

class Kakao_Login implements Social_Login {

  late User user;
  @override
  late bool isLogin = false;
  @override
  late String token = '';

  @override
  Future<bool> Login() async
  {
    if (await isKakaoTalkInstalled())
    {
      try
      {
        await UserApi.instance.loginWithKakaoTalk();
        isLogin = true;
      }
      catch (error)
      {
        print('카카오톡으로 로그인 실패 1 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          isLogin = false;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try
        {
          await UserApi.instance.loginWithKakaoAccount();
          isLogin = true;
        }
        catch (error)
        {
          print('1 카톡 해시 : ${await KakaoSdk.origin}');
          isLogin = false;
        }
      }
    }
    else
    {
      try
      {
        await UserApi.instance.loginWithKakaoAccount();
        isLogin = true;
      }
      catch (error)
      {
        print('2 카톡 해시 : ${await KakaoSdk.origin}');
        isLogin = false;
      }
    }

    if (isLogin)
    {
      await UserApi.instance.me().then((value) => user = value);
      token = user.id.toString();
    }

    return isLogin;
  }

  @override
  Future<bool> Logout() async {
    try
    {
      await UserApi.instance.unlink();
      isLogin = false;
      token = '';
    }
    catch (e)
    {
      print(e);
      isLogin = true;
    };

    return isLogin;
  }

  @override
  Future<bool> LoginCheck() async
  {
    isLogin = false;
    if (await AuthApi.instance.hasToken())
    {
      try
      {
        AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
        print('토큰 유효성 체크 성공 / tokenInfo.id : ${tokenInfo.id} / tokenInfo.expiresIn : ${tokenInfo.expiresIn}');
        await UserApi.instance.me().then((value) => user = value);
        print(user);
        isLogin = true;
      }
      catch (error)
      {
        if (error is KakaoException && error.isInvalidTokenError())
        {
          print('토큰 만료 $error');
        }
        else
        {
          print('토큰 정보 조회 실패 $error');
        }
      }
    }
    else
    {
      print('토큰이 없습니다.');
    }

    return isLogin;
  }
}
