import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        child: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Column(
            children: [
              SizedBox(
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
                          Get.to(() => LoginPage());
                          print('Click');
                        },
                      ),
                    ),
                  ],
                ),
              ),
              _TestBox(),
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
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
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

  Widget _TestBox()
  {
    return Align(alignment: Alignment.bottomCenter, child: Padding(padding: EdgeInsets.only(bottom: 0), child: Container(width: 0.5.sw, height: 1  .sw, color: Colors.green,),) , );
  }
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