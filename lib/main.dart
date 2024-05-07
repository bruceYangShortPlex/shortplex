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
  KakaoSdk.init(nativeAppKey: 'fb25da9b9589891ac497820e14c180d7');
  await Kakao_Login().LoginCheck();
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
    );
  }
}

