import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shortplex/Util/LoginMananger.dart';
import 'package:shortplex/Util/google_login.dart';
import 'package:shortplex/sub/LogoPage.dart';
import 'table/StringTable.dart';
import 'sub/FirebaseSetting.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  StringTable().InitTable();

  await FirebaseSetting().Setup();

  //TODO : 뭐로 로그인했었는지 알아오는 걸로해서 로그인 메니저에서 작업쳐야함.
  Get.lazyPut(() => LoginMananger(Google_Login()));
  var loginManager = Get.find<LoginMananger>();
  await loginManager.Check();

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

