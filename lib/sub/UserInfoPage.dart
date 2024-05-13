import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
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
      home:
      SafeArea
      (
        child: CupertinoPageScaffold
        (
          backgroundColor: context.theme.colorScheme.background,
          child: Column(
            children:
            [
              Container
              (
                width: 1.sw,
                height: 100,
                child:
                Row
                  (
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:
                  [
                    Padding
                    (
                      padding: const EdgeInsets.only(left: 20.0),
                      child: _profile(),
                    ),

                    Flexible
                    (
                      child: _nickName(),
                      fit: FlexFit.tight,
                      flex: 2,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 22.0),
                      child: SizedBox
                        (
                        width: 80,
                        height: 40,
                        child: CupertinoButton
                          (
                          child: Text('Login'),
                          color: Colors.yellow,
                          onPressed: () {
                            //Get.toNamed('/loginpage');
                            Get.to(() => LoginPage(),transition: Transition.noTransition);
                            print('Click');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container
                (
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
        child: Obx(() => Get.find<UserData>().photoUrl.value.isEmpty ?
                      Container(color: Colors.black,) :
                      Image.network('${Get.find<UserData>().photoUrl.value}',
                      fit: BoxFit.cover),
        ),
      ),
    ),
  );

  Widget _nickName() => Align
  (
    alignment: Alignment.topLeft,
    child: Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child:
            Obx(() => Column
            (
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Text('${Get.find<UserData>().name.value}',style: TextStyle(color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,fontSize: 20,),),
                Text('${Get.find<UserData>().uid}',style: TextStyle(color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,fontSize: 15,),),
              ],
            ),
      ),
    ),
  );


  Widget _walletInfo() => Stack
  (
    children:
    [
      Container
      (
        width: 356.w,
        height: 135,
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
        child:
        Column
        (
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Padding
            (
              padding: EdgeInsets.only(left: 30, ),
              child:  Text('나의 지값', style: TextStyle(color: Colors.white,fontFamily: 'NotoSans', fontSize: 18),),
            ),
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
  String uid = 'UID : ';

  InitValue()
  {
    name.value = 'Guest';
    photoUrl.value = '';
    loginComplete.value = false;
    uid = 'UID : ';
  }
}