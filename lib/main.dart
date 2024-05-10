import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shortplex/Util/LoginMananger.dart';
import 'package:shortplex/Util/google_login.dart';
import 'package:shortplex/sub/LogoPage.dart';
import 'package:shortplex/sub/UserInfoPage.dart';
import 'Util/kakao_login.dart';
import 'table/StringTable.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  StringTable().InitTable();

  Get.lazyPut(() => Kakao_Login());
  Get.lazyPut(() => Google_Login());
  Get.lazyPut(() => LoginMananger());
  Get.lazyPut(()=> UserData());
  Get.find<LoginMananger>().Check();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)
  {
    // 화면 크기 초기화
    return ScreenUtilInit(child: GetMaterialApp(
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

      ), designSize: Size(390, 844));
  }
}

