import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shortplex/Util/LoginMananger.dart';
import '../Util/HttpProtocolManager.dart';
import 'LoginPage.dart';

enum UserInfoSubPageType
{
  WALLET_CHARGE,
}

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage>
{

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  void didUpdateWidget(covariant UserInfoPage oldWidget) async
  {
    super.didUpdateWidget(oldWidget);

    var manager = Get.find<HttpProtocolManager>();;
    manager.send_GetUserData().then((value)
    {
      //유저정보 불러와서 비동기로 데이터 체우기.
      var jsonData = jsonDecode(value);
      var providerid = jsonData['providerid'];
      print('providerid');
    });
  }

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
                          child: Text('Login', style: TextStyle(fontSize: 10),),
                          color: Colors.yellow,
                          onPressed: ()
                          {
                            Get.to(() => LoginPage(),transition: Transition.noTransition);
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
      height: 50.w,
      decoration: const BoxDecoration
      (
        border: Border
          (
            left: BorderSide(color: Color(0xFF00FFBF), width: 2),
            right:BorderSide(color: Color(0xFF00FFBF), width: 2),
            top :BorderSide(color: Color(0xFF00FFBF), width: 2),
            bottom:BorderSide(color: Color(0xFF00FFBF), width: 2),
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
                Text('UID : ${Get.find<UserData>().providerUid}',style: TextStyle(color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,fontSize: 12,),),
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
            Row
            (
              children:
              [
                Padding
                (
                  padding: EdgeInsets.only(left: 30, ),
                  child:  Text('나의 지값', style: TextStyle(color: Colors.white,fontFamily: 'NotoSans', fontSize: 18),),
                ),

              ],
            ),

          ],
        ),
      ),
    ],
  );

  Widget moveButton(UserInfoSubPageType _type) => Padding
  (
    padding: EdgeInsets.only(top: 10),
    child:
    SizedBox
    (
      height: 20,
      width: 20,
      child: IconButton(icon: const Icon(Icons.arrow_forward_ios), onPressed: ()
      {
          switch(_type)
          {
            case UserInfoSubPageType.WALLET_CHARGE:
              //Get.to(()=>);
              break;
            default:
              print('not found type ${_type}');
              break;
          }

      },
      ),
    ),
  );
}

class UserData extends GetxController
{
  RxString name = 'Guest'.obs;
  RxString photoUrl = ''.obs;
  RxBool isLogin = false.obs;
  String email = '';
  String providerid = 'guest';
  String privacypolicies = 'true';
  String providerUid = '';

  String id = '';//barer token.
  String userId = ''; //server id

  InitValue()
  {
    name.value = 'Guest';
    photoUrl.value = '';
    isLogin.value = false;
    providerUid = 'guest';
    email = '';
    providerid = '';
    privacypolicies = 'true';
  }

  String GetProviderIcon()
  {
    String IconPath= '';
    if (providerid == 'guest')
    {
      IconPath = '';
    }
    else if (providerid == 'google')
    {
      IconPath = '';
    }
    else if (providerid == 'kakako')
    {
      IconPath = '';
    }
    else if (providerid == 'facebook')
    {
      IconPath = '';
    }
    else 
    {
      print('아이콘을 찾지 못했습니다.');
    }

    return IconPath;
  }
}