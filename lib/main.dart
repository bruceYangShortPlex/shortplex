import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shortplex/sub/LogoPage.dart';
import 'Util/kakao_login.dart';
import 'table/StringTable.dart';
import 'sub/FirebaseSetting.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  StringTable().InitTable();
  FirebaseSetting().Setup();
  //카카오 로그인이 필요할때 init해준다. 기존에 뭐로 거시기 했는지
  KakaoSdk.init(nativeAppKey: 'fb25da9b9589891ac497820e14c180d7');
  Get.lazyPut(() => Kakao_Login());
  //카카오 로그인을 했었다는 근거가 있을때 체크하도록 코드 추가해야하한다.
  var kakaolgin = Get.find<Kakao_Login>();
  await kakaolgin.LoginCheck();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LogoPage(),
      // initialRoute: "/",
      // getPages:
      // [
      //   GetPage(name: "/",page: () => CupertinoMain()),
      //   GetPage(name: "/second",page: () => SecondPage()),
      //   GetPage(name: "/userinfo",page: () => UserInfoPage()),
      //   GetPage(name: "/loginpage",page: () => LoginPage()),
      // ]

    );
  }
}

