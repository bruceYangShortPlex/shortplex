
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shortplex/Util/social_login.dart';

class FaceBook_Login implements Social_Login
{
  @override
  late bool isLogin = false;

  @override
  late String token = '';

  @override
  Future<bool> Login() async
  {
    try
    {
      var result = await signInFaceBook();

      if (result.user != null) {
        token = result.user!.uid;
        print('facebook login token : ${token}');
        isLogin = true;
      }
    }
    catch (e)
    {
      print('error facebook login fail : ${e}');
      isLogin = false;
    }

    return isLogin;
  }

  @override
  Future<bool> LoginCheck() async {
    var user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  @override
  Future<bool> Logout () async
  {
    await FacebookAuth.instance.logOut();
    return true;
  }
}


Future<UserCredential> signInFaceBook() async {
  // Trigger the authentication flow
  final LoginResult result = await FacebookAuth.instance.login();
  final String accessToken = result.accessToken!.token;

  final OAuthCredential credential = FacebookAuthProvider.credential(accessToken);

  //final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

  print('credential.token : ${credential.token} / credential.accessToken : ${credential.accessToken}');

  //final UserCredential ce = await FirebaseAuth.instance.signInWithCredential(credential);

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}