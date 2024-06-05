import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shortplex/sub/UserInfo/SettingPage.dart';
import 'package:shortplex/sub/UserInfo/ShopPage.dart';
import '../../Util/HttpProtocolManager.dart';
import '../../table/StringTable.dart';
import '../../table/UserData.dart';
import 'BuySubscriptionPage.dart';
import 'LoginPage.dart';
import 'WalletInfoPage.dart';

enum UserInfoSubPageType
{
  WALLET_INFO,
  CS,
  SETTING,
}

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();

  Widget _moveButton(UserInfoSubPageType _type) =>
  IconButton
  (
    alignment: Alignment.center,
    color: Colors.white,
    iconSize: 20,
    icon: const Icon(Icons.arrow_forward_ios), onPressed: ()
    {
      switch(_type)
      {
        case UserInfoSubPageType.WALLET_INFO:
          Get.to(()=> WalletInfoPage());
          break;
        case UserInfoSubPageType.SETTING:
          Get.to(() => SettingPage());
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
  void didUpdateWidget(covariant UserInfoPage oldWidget)
  {
    super.didUpdateWidget(oldWidget);

    var manager = HttpProtocolManager.to;
    manager.send_GetUserData().then((value)
    {
      print('send GetUserData value ${value}');
      if (value != '') {
        //유저정보 불러와서 비동기로 데이터 체우기.
        var jsonData = jsonDecode(value);
        var providerid = jsonData['providerid'];
        print('providerid');
      }
    });
  }

  @override
  Widget build(BuildContext context)
  {
    Get.put(UserInfoMainListView());
    return CupertinoApp
    (
      home:
      SafeArea
      (
        child: CupertinoPageScaffold
        (
          backgroundColor: Colors.black,//context.theme.colorScheme.background,
          child:
          Container
          (
            width: 390.w,
            height: 844.h,
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
              SizedBox(height: 10,),
              Divider(height: 2, color: Colors.white, indent: 10, endIndent: 10, thickness: 0.5,),
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
        width: 390.w,
        height: 100,
        //color: Colors.green,
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
                child:
                Container
                (
                  padding: EdgeInsets.only(bottom: 2),
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
                    child:
                    Text
                    (
                      StringTable().Table![400003]!,
                      style:
                      TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                    ),
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

  Widget _profile() => Padding
  (
    padding: const EdgeInsets.all(8.0),
    child:
    Container
    (
      width: 50,
      height: 50,
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
      child:
      ClipRRect
      (
        borderRadius: BorderRadius.circular(100),
        child:
        Obx(() => Get.find<UserData>().photoUrl.value.isEmpty ?
              Container
              (
                color: Colors.black,
                child: Image.asset('assets/images/User/my_picture.png', fit: BoxFit.cover,),) :
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
      Obx(() =>
        Column
        (
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Text('${Get.find<UserData>().name.value}',style: TextStyle(color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,fontSize: 20,),),
            Text('UID : ${Get.find<UserData>().providerUid}',style: TextStyle(color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,fontSize: 12,),),
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
          visible: Get.find<UserData>().isSubscription.value,
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
                              TextStyle(fontSize: 8, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),),
                          ),
                          onTap: ()
                          {
                            // if (Get.find<UserData>().isLogin.value)
                            // {
                            //   Get.to(() => ShopPage());
                            // }
                            // else
                            // {
                            //   showDialogTwoButton(400003, 400003,
                            //   () =>
                            //   {
                            //       Get.to(() => LoginPage(), transition: Transition.noTransition),
                            //   });
                            // }

                            Get.to(() => BuySubscriptionPage());
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
                    child:  Text(StringTable().Table![400005]!, style: TextStyle(color: Colors.white,fontFamily: 'NotoSans', fontSize: 16),),
                  ),
                  widget._moveButton(UserInfoSubPageType.WALLET_INFO),
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
                          alignment: Alignment.centerLeft,
                          child:
                          Row
                          (
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:
                            [
                              Padding
                              (
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child:
                                  Image.asset
                                  (
                                    alignment: Alignment.center,
                                    width: 32,
                                    height: 32,
                                    'assets/images/User/my_popcon.png',
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                Container
                                (
                                  padding: EdgeInsets.only(bottom: 2),
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
                          width: 235,
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
                                child:
                                Image.asset
                                (
                                  alignment: Alignment.center,
                                  width: 32,
                                  height: 32,
                                  'assets/images/User/my_bonus.png',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              Container
                              (
                                padding: EdgeInsets.only(bottom: 1),
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
                          padding: EdgeInsets.only(bottom: 2),
                          child:
                          Text(StringTable().Table![400009]!, style: TextStyle(fontSize: 14, color: Colors.white,fontFamily: 'NotoSans',),),
                        ),
                        onTap: ()
                        {
                          // if (Get.find<UserData>().isLogin.value)
                          // {
                          //   Get.to(() => ShopPage());
                          // }
                          // else
                          // {
                          //   showDialogTwoButton(400003, 400003,
                          //   () =>
                          //   {
                          //       Get.to(() => LoginPage(), transition: Transition.noTransition),
                          //   });
                          // }

                          Get.to(() => ShopPage());
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
  Expanded
  (
    child:
  Container
  (
    width: 390.w,
    //height: 443.h,
    //color: Colors.green,
    alignment: Alignment.center,
    child:
    Obx
    (() =>
      ListView.builder
      (
        //physics: ClampingScrollPhysics(),
        itemCount: UserInfoMainListView.to.list.length,
        itemBuilder: (context, index)
        {
          return UserInfoMainListView.to.list[index];
          //return Text(str);
        },
      ),
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
    list.add(defaultInfo(400010, 400010, 400010,CupertinoIcons.bell));
    list.add(defaultInfo(400011,400011,400011, CupertinoIcons.heart));
    list.add(_option(400012, CupertinoIcons.headphones, UserInfoSubPageType.WALLET_INFO));
    list.add(_option(400013, Icons.settings_outlined, UserInfoSubPageType.SETTING));
  }

  Widget _option(int _titleID, IconData _icon, UserInfoSubPageType _type) =>
  Align
  (
    alignment: Alignment.topCenter,
    child:
    Column
    (
      mainAxisAlignment: MainAxisAlignment.start,
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
              child:
              Icon(_icon, color: Colors.white,),
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
                child:
                Text(StringTable().Table![_titleID]!,
                  style:
                  TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),),
              ),
            ),
            Padding
              (
              padding:EdgeInsets.only(right: 20),
              child: Get.find<UserInfoPage>()._moveButton(_type),
            ),
          ],
        ),
        Divider(height: 10, color: Colors.white, indent: 10, endIndent: 10, thickness: 1,),
      ],
    ),
  );

  Widget defaultInfo(int _titleID, int _contents1id, int _contents2id, IconData _icon ) =>
  Container
  (
    width: 390.w,
    height: 190,
    //color: Colors.white,
    child:
    Column
    (
      mainAxisAlignment: MainAxisAlignment.start,
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
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Container
                (
                width: 20,
                height: 20,
                //color: Colors.red,
                child:
                Icon
                (
                  _icon, size: 20,
                  color: Colors.white,
                )
              ),
            ),
            Padding
            (
              padding: const EdgeInsets.only(left: 10.0, top: 10),
              child: Container
              (
                alignment: Alignment.centerLeft,
                width: 300,
                height: 22,
                //color: Colors.red,
                child: Text(StringTable().Table![_titleID]!,
                  style:
                  TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),),
              ),
            ),
          ],
        ),
        Padding
        (
          padding: const EdgeInsets.only(top: 10, left: 50),
          child:
          Container
          (
            //color: Colors.red,
            height: 40,
            width: 200.w,
            child: Text(StringTable().Table![_contents1id]!,
              style:
              TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),),
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
            width: 200.w,
            child: Text(StringTable().Table![_contents2id]!,
              style:
              TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),),
          ),
        ),
        Padding
        (
            padding: const EdgeInsets.only(top: 10.0, left: 50),
            child:
            Container
            (
              padding: EdgeInsets.only(bottom: 1),
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
                child:
                Text(StringTable().Table![400010]!,
                  style:
                  TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),),
                onTap: ()
                {
                  print('todo~ work');
                },
              ),
            )
        ),
        Padding
        (
          padding: const EdgeInsets.only(top: 20.0),
          child: Divider(height: 2, color: Colors.white, indent: 10, endIndent: 10, thickness: 1,),
        ),
      ],
    ),
  );

  Widget contentsView(List<ContentData> _list, [bool _buttonVisible = false])
  {
    if (_list.length == 0)
      return SizedBox();

    return
      Container
        (
        width: 390,
        child:
        Column
          (
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Row
              (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
              [
                Text
                  (
                  _list[0].title!,
                  style:
                  const TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                ),
                SizedBox(height: 10,),
                SizedBox
                  (
                  width: 40,
                  child:
                  Visibility
                    (
                    visible: _buttonVisible,
                    child:
                    IconButton
                      (
                        alignment: Alignment.center,
                        color: Colors.white,
                        iconSize: 20,
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: ()
                        {
                          print('Click Move All Contents');
                        }
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            SingleChildScrollView
              (
              scrollDirection: Axis.horizontal,
              child:
              Row
                (
                mainAxisAlignment: MainAxisAlignment.start,
                children:
                [
                  for(var item in _list)
                    contentItem(item),
                ],
              ),
            ),
            SizedBox(height: 30,),
          ],
        ),
      );
  }

  Widget contentItem(ContentData _data)
  {
    return
      Padding
        (
        padding: const EdgeInsets.only(right: 10),
        child:
        Column
          (
          children:
          [
            GestureDetector
              (
              onTap: ()
              {
                if (_data.isWatching!)
                {
                  print(_data.id);
                  print('go to content player');
                }
                else
                {
                  print('go to info page');
                  print(_data.id);
                }
              },
              child:
              Stack
                (
                alignment: _data.isWatching! ? Alignment.center : Alignment.topRight,
                children:
                [
                  Container
                    (
                    width: 105,
                    height: 160,
                    decoration: ShapeDecoration
                      (
                      color: Color(0xFFC4C4C4),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                    ),
                  ),
                  Visibility
                    (
                    visible: _data.isWatching!,
                    child:
                    Container
                      (
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 3.5),
                      width: 50,
                      height: 50,
                      decoration: ShapeDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: OvalBorder(
                          side: BorderSide(
                            width: 1.50,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0xFF00FFBF),
                          ),
                        ),
                      ),
                      child: Icon(CupertinoIcons.play_arrow_solid, size: 28, color: Colors.white,),
                    ),
                  ),
                  Visibility
                    (
                    visible: _data.isNew!,
                    child:
                    Container
                      (
                      width: 29,
                      height: 14,
                      alignment: Alignment.center,
                      decoration: ShapeDecoration
                        (
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 0.80, color: Color(0xFF00FFBF)),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      child:
                      Text
                      (
                        'NEW',
                        style:
                        const TextStyle(fontSize: 8, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                      ),
                    ),
                  ),
                  Padding
                    (
                    padding: const EdgeInsets.only(top: 160 - 42, right: 105 - 42),
                    child:
                    Visibility
                      (
                        visible: _data.rank != 0,
                        child:
                        Container
                          (
                          //alignment: Alignment.center,
                          //width: 42,height: 42, color: Colors.red,
                          child: SvgPicture.asset('assets/images/home/home_frame.svg', fit: BoxFit.contain,),
                        )
                    ),
                  ),
                ],
              ),
            ),
            Visibility
              (
              visible: _data.isWatching!,
              child:
              SizedBox
                (
                width: 105,
                child:
                Row
                  (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                  [
                    Padding
                      (
                      padding: const EdgeInsets.only(left: 6, bottom: 2.1),
                      child: Text
                        (
                        _data.watchingEpisode!,
                        style:
                        const TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                      ),
                    ),
                    IconButton
                      (
                      alignment: Alignment.center,
                      padding: EdgeInsets.zero,
                      iconSize: 16,
                      onPressed: ()
                      {
                        print('go to info page');
                        print(_data.id);
                      },
                      icon: Icon(CupertinoIcons.info), color: Colors.white,)
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
}