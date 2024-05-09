
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shortplex/Util/social_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Google_Login implements Social_Login
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
      var result = await signInWithGoogle();

      if (result.user != null) {
        token = result.user!.uid;
        print('google login token : ${token}');
        isLogin = true;
      }
    }
    catch (e)
    {
      print('error google login fail : ${e}');
    }
    isLogin = false;
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
    var resutl = await GoogleSignIn().signOut();
    print(resutl);
    return true;
  }
}


Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential
  (
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  //print('credential.token : ${credential.token} / credential.accessToken : ${credential.accessToken}');

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
