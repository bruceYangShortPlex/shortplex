import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'LoginPage.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage>
{
  @override
  Widget build(BuildContext context)
  {
    return CupertinoApp(
      home: SafeArea(
        child:
        Padding
        (
          padding: const EdgeInsets.only(top: 0),
          child: Column(
            children:
            [
              Container
              (
                color: Colors.black,
                width: 1.sw,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:
                  [
                    _profile(),
                    _nickName(),
                    SizedBox(
                      width: 80,
                      height: 40,
                      child: CupertinoButton(
                        child: Text('Login'),
                        color: Colors.yellow,
                        onPressed: () {
                          //Get.toNamed('/loginpage');
                          Get.to(() => LoginPage(),transition: Transition.noTransition);
                          print('Click');
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container
                (
                color: Colors.black,
                width: 1.sw,
                height: 1.sw,
                child:
                Column(children: [_walletInfo(),],),),

            ],
          ),
        ),

      ),
    );
  }

  Widget _profile() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 50.w,
      height: 50.h,
      decoration: const BoxDecoration
      (
        border: Border
          (
            left: BorderSide(color: Colors.green, width: 2),
            right:BorderSide(color: Colors.green, width: 2),
            top :BorderSide(color: Colors.green, width: 2),
            bottom:BorderSide(color: Colors.green, width: 2),
        ),
        //borderRadius: BorderRadius.circular(15),
        shape: BoxShape.circle,
        color: Color(0xFF00FFBF),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Obx(() => Get.find<UserData>().photoUrl.value.isEmpty ? Container(color: Colors.black,) : Image.network('${Get.find<UserData>().photoUrl.value}', fit: BoxFit.cover),
        ),
      ),
    ),
  );

  Widget _nickName() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Obx(() =>
        Text('${Get.find<UserData>().name.value}',style: TextStyle(fontFamily: 'NotoSans', fontWeight: FontWeight.w100,fontSize: 20),),
    ),
  );

  Widget _walletInfo() => Stack
    (
    children:
    [
      Container
        (
          width: 356.w,
          height: 135.w,
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1.00, 0.5),
              end: Alignment(1, 0.5),
              colors: [Color(0x330006A5).withOpacity(0.22), Color(0xFF00FFBF).withOpacity(0.22),],
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1.50, color: Color(0xFF4D4D4D)),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children:
        [
          Padding(
            padding: EdgeInsets.only(left: 30, ),
            child:  Text('나의 지값', style: TextStyle(color: Colors.white,fontFamily: 'NotoSans', fontSize: 18),),),

        ],
        ),
      ),
    ],
  );

}

class UserData extends GetxController
{
  RxString name = 'Guest'.obs;
  RxString photoUrl = ''.obs;
  RxBool loginComplete = false.obs;

  InitValue()
  {
    name.value = 'Guest';
    photoUrl.value = '';
    loginComplete.value = false;
  }
}