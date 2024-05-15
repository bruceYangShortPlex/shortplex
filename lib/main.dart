import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shortplex/Util/LoginMananger.dart';
import 'package:shortplex/sub/LoginPage.dart';
import 'package:shortplex/sub/LogoPage.dart';
import 'package:shortplex/sub/UserInfoPage.dart';
import 'Util/theme.dart';
import 'table/StringTable.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  StringTable().InitTable();
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
    return ScreenUtilInit
      (
        child: GetMaterialApp
        (
            theme:
            ThemeData
              (
              colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF00FFBF), background: Colors.black,),
              useMaterial3: true,
              ),
        home: LogoPage(),
      ), designSize: Size(390, 844));
  }
}

