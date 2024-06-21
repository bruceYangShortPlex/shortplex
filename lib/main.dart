import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shortplex/Util/LoginMananger.dart';
import 'package:shortplex/sub/LogoPage.dart';
import 'package:shortplex/table/Event2Table.dart';
import 'package:shortplex/table/UserData.dart';
import 'Util/AdsManager.dart';
import 'table/StringTable.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  AdManager.initGoogleMobileAds();
  Event2table().InitTable();
  StringTable().InitTable();
  Get.lazyPut(() => LoginMananger());
  Get.lazyPut(() => UserData());
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
    return
    ScreenUtilInit
    (
      child:
      GetMaterialApp
      (
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true,),
        home: LogoPage(),
    ), designSize: Size(390, 844));
  }
}

