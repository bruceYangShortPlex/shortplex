import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import '../Util/HttpProtocolManager.dart';
import '../table/StringTable.dart';
import '../table/UserData.dart';
import 'LoginPage.dart';

enum UserInfoSubPageType
{
  WALLET_CHARGE,
}

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();

  Widget _moveButton(UserInfoSubPageType _type) =>
  IconButton
  (
    padding: EdgeInsets.only(right: 0, top: 5),
    alignment: Alignment.center,
    color: Colors.white,
    iconSize: 20,
    icon: const Icon(Icons.arrow_forward_ios), onPressed: ()
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
  );
}

class _UserInfoPageState extends State<UserInfoPage>
{
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
    Get.put(UserInfoMainListView());
    return CupertinoApp(
      home:
      SafeArea
      (
        child: CupertinoPageScaffold
        (
          backgroundColor: context.theme.colorScheme.background,
          child:
          Container
          (
            width: 390.w,
            height: 844.w,
            //color: Colors.red,
            child:
            Column
            (
              children:
              [
                _UserAccountInfo(),
                _subscription(),
                SizedBox(height: 10,),
                _walletInfo(),
                Divider(height: 40, color: Colors.white24, indent: 10, endIndent: 10, thickness: 1,),
                //UserInfoMainListView.to._option(),
                _mainListView(),
              ],
            ),
          ),
        ),

      ),
    );
  }

  Widget _UserAccountInfo() =>
  Column
  (
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

            Padding
              (
              padding: const EdgeInsets.only(right: 22.0),
              child:
              Visibility
                (
                visible: !Get.find<UserData>().isLogin.value,
                child: Container
                  (
                  alignment: Alignment.center,
                  width: 90,
                  height: 26,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.50, color: Color(0xFF4D4D4D)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child:
                  GestureDetector
                    (
                    child: Text(StringTable().Table![400003]!,
                      style:
                      TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),),
                    onTap: ()
                    {
                      Get.to(() => LoginPage(),transition: Transition.noTransition);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );

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

  Widget _subscription() => Stack
  (
    children:
    [
      Obx(()=>
        Visibility
        (
          visible: !Get.find<UserData>().isSubscription.value,
          child:
          Container
            (
            width: 356.w,
            height: 50,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
              [
                Row
                  (
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:
                  [
                    SizedBox
                      (
                      height: 40,
                      width: 290.w,
                      child:
                      Column
                        (
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        [
                          Padding
                            (
                            padding: EdgeInsets.only(left: 20,top: 2),
                            child:
                            Text
                            (
                              StringTable().Table![400014]!,
                              style: TextStyle(color: Colors.white,fontFamily: 'NotoSans', fontSize: 13),
                            ),
                          ),
                          Padding
                          (
                            padding: EdgeInsets.only(left: 20, top: 2),
                            child:
                            Text
                            (
                              StringTable().Table![400015]!,
                              style: TextStyle(color: Colors.white.withOpacity(0.6),fontFamily: 'NotoSans', fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container
                    (
                      alignment: Alignment.center,
                      height: 40,
                      child:
                      Container
                      (
                        alignment: Alignment.center,
                        width: 55,
                        height: 20,
                        decoration: ShapeDecoration(
                          color: Colors.black.withOpacity(0.7),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1.50, color: Color(0xFF00FFBF)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child:
                        GestureDetector
                        (
                          child:
                          Container
                          (
                            child:
                            Text(StringTable().Table![400016]!,
                              style:
                              TextStyle(fontSize: 8, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),),
                          ),
                          onTap: ()
                          {
                            Get.to(() => LoginPage(),transition: Transition.noTransition);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ],
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
          children:
          [
            SizedBox
            (
              //color: Colors.green,
              width: 356.w,
              height: 30,
              child:
              Row
              (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                [
                  Padding
                  (
                    padding: EdgeInsets.only(left: 20, top: 5),
                    child:  Text(StringTable().Table![400005]!, style: TextStyle(color: Colors.white,fontFamily: 'NotoSans', fontSize: 18),),
                  ),
                  widget._moveButton(UserInfoSubPageType.WALLET_CHARGE),
                ],
              ),
            ),
            Divider(height: 10, color: Colors.white54, indent: 10, endIndent: 10, thickness: 1,),
            Row
            (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                [
                  Container
                  (
                    width: 235.w,
                    height: 92,
                    //color: Colors.yellow,
                    alignment: Alignment.center,
                    child:
                    Column
                    (
                      children:
                      [
                        Container
                        (
                          //color: Colors.cyan,
                          width: 235,
                          height: 92 * 0.5,
                          alignment: Alignment.center,
                          child:
                          Row
                          (
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:
                            [
                              Padding
                              (
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Image.asset
                                  (
                                    alignment: Alignment.center,
                                    width: 20,
                                    height: 20,
                                    'assets/images/shortplex.png',
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                Container
                                (
                                  alignment: Alignment.center,
                                  width: 49,
                                  height: 24,
                                  decoration: ShapeDecoration(
                                    color: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(width: 1.50, color: Color(0xFF00FFBF)),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child:  Text(StringTable().Table![400006]!, style: TextStyle(color: Colors.white,fontFamily: 'NotoSans', fontSize: 12),),
                                ),
                              //),
                              Padding
                                (
                                padding: const EdgeInsets.only(right: 20.0),
                                child:
                                Container
                                (
                                  width: 110,
                                  height: 92 * 0.5,
                                  padding: EdgeInsets.only(left: 5),
                                  //color: Colors.red,
                                  alignment: Alignment.centerLeft,
                                  child: Text(Get.find<UserData>().GetPopupcornCount().$1, style: TextStyle(color: Colors.white,fontFamily: 'NotoSans', fontSize: 16),),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container
                        (
                          //color: Colors.green,
                          width: 235.w,
                          height: 92 * 0.5,
                          child:
                          Row
                            (
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:
                            [
                              Padding
                                (
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Image.asset
                                  (
                                  alignment: Alignment.center,
                                  width: 20,
                                  height: 20,
                                  'assets/images/shortplex.png',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              Container
                                (
                                alignment: Alignment.center,
                                width: 49,
                                height: 24,
                                decoration: ShapeDecoration(
                                  color: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 1.50, color: Color(0xFF4D4D4D)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child:  Text(StringTable().Table![400007]!, style: TextStyle(color: Colors.white,fontFamily: 'NotoSans', fontSize: 12),),
                              ),
                              //),
                              Padding
                                (
                                padding: const EdgeInsets.only(right: 20.0),
                                child:
                                Container
                                  (
                                  width: 110,
                                  height: 92 * 0.5,
                                  padding: EdgeInsets.only(left: 5),
                                  //color: Colors.red,
                                  alignment: Alignment.centerLeft,
                                  child: Text(UserData.to.GetPopupcornCount().$2, style: TextStyle(color: Colors.white,fontFamily: 'NotoSans', fontSize: 16),),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container
                  (
                    width: 118.w,
                    height: 92,
                    //color: Colors.blue,
                    alignment: Alignment.center,
                    child:
                    Container
                    (
                      width: 80,
                      height: 26,
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1.50, color: Color(0xFF00FFBF)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child:
                      GestureDetector
                      (
                        child:
                        Container
                          (
                          child:
                          Text(StringTable().Table![400009]!, style: TextStyle(fontSize: 14, color: Colors.white,fontFamily: 'NotoSans',),),
                        ),
                        onTap: ()
                        {
                          Get.to(() => LoginPage(),transition: Transition.noTransition);
                        },
                      ),
                    ),
                  ),
                ],
            )
          ],
        ),
      ),
    ],
  );

  Widget _mainListView() =>
  Container
  (
    width: 390.w,
    height: 405.w,
    //color: Colors.green,
    //alignment: Alignment.center,
    child:
    Obx
    (() =>
      ListView.builder
      (
        itemCount: UserInfoMainListView.to.list.length,
        itemBuilder: (context, index)
        {
          return UserInfoMainListView.to.list[index];
          //return Text(str);
        },
      ),
    ),
  );
}

class UserInfoMainListView extends GetxController
{
  static UserInfoMainListView get to => Get.find();
  RxList<Widget> list = <Widget>[].obs;

  @override
  void onInit()
  {
    super.onInit();
    Get.put(UserInfoPage());
    list.add(defaultInfo());
    list.add(defaultInfo());
    list.add(_option());
    list.add(_option());
  }

  void AddItem()
  {
    //list.add(defaultInfo());
  }

  Widget _option() =>
  Column
  (
    mainAxisAlignment: MainAxisAlignment.center,
    children:
    [
      Row
      (
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
        [
          Padding
          (
            padding:EdgeInsets.only(left: 20),
            child: Icon(Icons.headphones),
          ),
          Padding
            (
            padding:EdgeInsets.only(left: 10),
            child:
            Container
            (
              height: 30,
              width: 280,
              //color: Colors.yellow,
              alignment: Alignment.centerLeft,
              child: Text(StringTable().Table![400003]!,
                style:
                TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),),
            ),
          ),
          Padding
          (
            padding:EdgeInsets.only(right: 20),
            child: Get.find<UserInfoPage>()._moveButton(UserInfoSubPageType.WALLET_CHARGE),
          ),
        ],
      ),
      Divider(height: 10, color: Colors.white, indent: 10, endIndent: 10, thickness: 1,),
    ],
  );

  Widget defaultInfo() =>
  Container
  (
    width: 100,
    //color: Colors.white,
    child:
    Column
      (
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Row
          (
          mainAxisAlignment: MainAxisAlignment.start,
          children:
          [
            Padding
              (
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Container
                (
                width: 20,
                height: 20,
                //color: Colors.red,
                child: Image.asset('assets/images/shortplex.png', fit: BoxFit.fitHeight,),

              ),
            ),
            Padding
              (
              padding: const EdgeInsets.only(left: 5.0, top: 10),
              child: Container
                (
                alignment: Alignment.center,
                width: 100,
                height: 32,
                //color: Colors.red,
                child: Text(StringTable().Table![400003]!,
                  style:
                  TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),),
              ),
            ),
          ],
        ),
        Padding
          (
          padding: const EdgeInsets.only(top: 8.0, left: 50),
          child:
          Container
            (
            //color: Colors.blue,
            height: 40,
            width: 200,
            child: Text(StringTable().Table![400003]!,
              style:
              TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),),
          ),
        ),
        Padding
          (
          padding: const EdgeInsets.only(top: 8.0, left: 50),
          child:
          Container
            (
            //color: Colors.blue,
            height: 40,
            width: 200,
            child: Text(StringTable().Table![400003]!,
              style:
              TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),),
          ),
        ),
        Padding
          (
            padding: const EdgeInsets.only(top: 20.0, left: 50),
            child:
            Container
            (
              alignment: Alignment.center,
              width: 90,
              height: 26,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1.50, color: Color(0xFF4D4D4D)),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child:
              GestureDetector
              (
                child: Text(StringTable().Table![400003]!,
                  style:
                  TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),),
                onTap: ()
                {
                  //UserInfoMainListView.to.AddItem();
                  print('todo~ work');
                },
              ),
            )
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Divider(height: 10, color: Colors.white, indent: 10, endIndent: 10, thickness: 1,),
        ),
      ],
    ),
  );
}