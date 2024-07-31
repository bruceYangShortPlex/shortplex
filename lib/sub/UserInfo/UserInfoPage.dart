import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shortplex/Util/ShortplexTools.dart';
import 'package:shortplex/sub/ContentInfoPage.dart';
import 'package:shortplex/sub/CupertinoMain.dart';
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

class UserInfoPage extends StatefulWidget
{
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
  var alarmList = <ContentData>[];
  var favoritesList = <ContentData>[];
  int prevUpdateCount = 0;

  getContentList()
  {
    prevUpdateCount = UserData.to.refreshCount.value;
    if (UserData.to.isLogin.value == false)
    {
      return;
    }

    HttpProtocolManager.to.Get_UserInfoContentList(false).then((value)
    {
      if (value == null) {
        return;
      }

      alarmList.clear();
      for (var item in value.data!.items!)
      {
        var data = ContentData
        (
          id: item.id,
          title: item.title,
          imagePath: item.posterPortraitImgUrl,
          cost: 0,
          releaseAt: item.releaseAt,
          landScapeImageUrl: item.posterLandscapeImgUrl,
          rank: item.topten,
        );

        data.contentTitle = item.title ?? '';
        setState(() {
          alarmList.add(data);
        });
      }
    },);

    HttpProtocolManager.to.Get_UserInfoContentList(true).then((value)
    {
      if (value == null) {
        return;
      }

      favoritesList.clear();
      for (var item in value.data!.items!)
      {
        var data = ContentData
        (
          id: item.id,
          title: item.title,
          imagePath: item.posterPortraitImgUrl,
          cost: 0,
          releaseAt: item.releaseAt,
          landScapeImageUrl: item.posterLandscapeImgUrl,
          rank: item.topten,
        );

        data.contentTitle = item.title ?? '';
        setState(() {
          favoritesList.add(data);
        });
      }
    },);
  }

  getWalletInfo()
  {
    if (UserData.to.isLogin.value ==false)
    {
      return;
    }

    HttpProtocolManager.to.Get_WalletBalance().then((value)
    {
      if (value == null) {
        return;
      }

      for(var item in value.data!.items!)
      {
        if (item.userId == UserData.to.userId)
        {
          UserData.to.popcornCount.value = double.parse(item.popcorns).toInt();
          UserData.to.bonusCornCount.value = double.parse(item.bonus).toInt();
          break;
        }
      }
    },);
  }

  @override
  void initState()
  {
    //UserData.to.isSubscription(true);

    getContentList();
    getWalletInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
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
              userAccountInfo(),
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

  Widget userAccountInfo() =>
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
                  Obx(() {
                    return
                      Visibility
                        (
                        visible: UserData.to.isLogin.value == false,
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
                      );
                  },),
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
                child: Image.asset('assets/images/user/my_picture.png', fit: BoxFit.cover,),) :
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
          visible: UserData.to.isSubscription.value,
          child:
          Container
          (
            width: 356.w,
            height: 50,
            decoration:
            ShapeDecoration
            (
              //color: Colors.black,
              shape: RoundedRectangleBorder
              (
                side: BorderSide(width: 1.50, color: Color(0xFF00FFBF)),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            //color: Colors.red,
            child:
            Stack
            (
              alignment: Alignment.center,
              children:
              [
                ClipRRect
                (
                  borderRadius: BorderRadius.circular(12),
                  child: 
                  Image.asset
                  (
                    width: 356.w,
                    'assets/images/user/my_user_freepass.png',
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
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
                          padding: const EdgeInsets.only(left: 20),
                          child: Column
                          (
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                            [
                              Text
                              (
                                StringTable().Table![400014]!,
                                style: TextStyle(color: Colors.white,fontFamily: 'NotoSans', fontSize: 13),
                              ),
                              Text
                              (
                                StringTable().Table![400015]!,
                                style: TextStyle(color: Colors.white.withOpacity(0.6),fontFamily: 'NotoSans', fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        Padding
                        (
                          padding: EdgeInsets.only(right: 20),
                          child:
                          GestureDetector
                          (
                            onTap: ()
                            {
                               Get.to(() => BuySubscriptionPage());
                            },
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
                              Container
                              (
                                child:
                                Text
                                  (
                                  StringTable().Table![400016]!,
                                  style:
                                  TextStyle(fontSize: 8, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
          ),
        ),
      ),
    ],
  );

  Widget _walletInfo() =>
  Stack
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
            Container
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
                          width: 235.w,
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
                                    'assets/images/user/my_popcorn.png',
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
                                  width: 110.w,
                                  height: 92 * 0.5,
                                  padding: EdgeInsets.only(left: 5),
                                  //color: Colors.red,
                                  alignment: Alignment.centerLeft,
                                  child:
                                  Obx(()
                                  {
                                    return
                                    Text
                                    (
                                      Get.find<UserData>().GetPopupcornCount().$1,
                                      style: const TextStyle(color: Colors.white,fontFamily: 'NotoSans', fontSize: 16),
                                    );
                                  },),
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
                                child:
                                Image.asset
                                (
                                  alignment: Alignment.center,
                                  width: 32,
                                  height: 32,
                                  'assets/images/user/my_bonus.png',
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
                                child:
                                Text
                                (
                                  StringTable().Table![400007]!,
                                  style:
                                  const TextStyle(color: Colors.white,fontFamily: 'NotoSans', fontSize: 12),
                                ),
                              ),
                              //),
                              Padding
                                (
                                padding: const EdgeInsets.only(right: 20.0),
                                child:
                                Container
                                (
                                  width: 110.w,
                                  height: 92 * 0.5,
                                  padding: EdgeInsets.only(left: 5),
                                  //color: Colors.red,
                                  alignment: Alignment.centerLeft,
                                  child:
                                  Obx(()
                                  {
                                    return
                                    Text
                                    (
                                      UserData.to.GetPopupcornCount().$2,
                                      style: const TextStyle(color: Colors.white,fontFamily: 'NotoSans', fontSize: 16),
                                    );
                                  },),
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
                    width: 117.w,
                    height: 92,
                    //color: Colors.blue,
                    alignment: Alignment.center,
                    child:
                    GestureDetector
                    (
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
                      child:
                      Container
                      (
                        width: 80.w,
                        height: 26,
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1.50, color: Color(0xFF00FFBF)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child:
                        Container
                        (
                          padding: EdgeInsets.only(bottom: 2),
                          child:
                          Text(StringTable().Table![400009]!, style: TextStyle(fontSize: 14, color: Colors.white,fontFamily: 'NotoSans',),),
                        ),
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

  Widget _mainListView()
  {
    return
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
        SingleChildScrollView
        (
          child:
          Obx(()
          {
            if (UserData.to.refreshCount.value != prevUpdateCount)
            {
              prevUpdateCount = UserData.to.refreshCount.value;
              getContentList();
            }

            return
            Column
            (
              children:
              [
                defaultInfo(400010, 400097, 400098, CupertinoIcons.bell_fill, alarmList),
                defaultInfo(400011,400099, 400100, CupertinoIcons.heart_solid, favoritesList),
                option(400012, CupertinoIcons.headphones, UserInfoSubPageType.WALLET_INFO),
                option(400013, Icons.settings_outlined, UserInfoSubPageType.SETTING),
              ],
            );
          },),
        )
        // Obx
        //   (() =>
        //     ListView.builder
        //     (
        //       //physics: ClampingScrollPhysics(),
        //       itemCount: UserInfoMainListView.to.list.length,
        //       itemBuilder: (context, index) {
        //         return UserInfoMainListView.to.list[index];
        //         //return Text(str);
        //       },
        //     ),
        // ),
      ),
    );
  }

  Widget option(int _titleID, IconData _icon, UserInfoSubPageType _type)
  {
    return
      Container
      (
        width: 390.w,
        alignment: Alignment.topCenter,
        child:

          Column
          (
            mainAxisAlignment: MainAxisAlignment.start,
            children:
            [
              Container
              (
                width: 360.w,
                child:
                Row
                (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                  [
                    Icon(_icon, color: Colors.white,),
                    Container
                    (
                      height: 30,
                      width: 280.w,
                      //color: Colors.yellow,
                      alignment: Alignment.centerLeft,
                      child:
                      Text(StringTable().Table![_titleID]!,
                        style:
                        const TextStyle(
                          fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),),
                    ),
                    widget._moveButton(_type),
                  ],
                ),
              ),
              Divider(height: 10,
                color: Colors.white,
                indent: 10,
                endIndent: 10,
                thickness: 1,),
            ],
          ),
      );
  }

  Widget defaultInfo(int _titleID, int _contents1id, int _contents2id, IconData _icon, List<ContentData> _list ) =>
      Container
      (
        width: 390.w,
        //: 190,
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
                  child:
                  Container
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
                    child:
                    Text
                    (
                      StringTable().Table![_titleID]!,
                      style:
                      const TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                    ),
                  ),
                ),
              ],
            ),
            _list.length == 0 ? contetntAnnounce(_contents1id,_contents2id,_icon == CupertinoIcons.bell_fill)
            : contentsView(_list, _icon == CupertinoIcons.bell_fill),
            Padding
            (
              padding: const EdgeInsets.only(top: 20.0),
              child: Divider(height: 2, color: Colors.white, indent: 10, endIndent: 10, thickness: 1,),
            ),
          ],
        ),
      );

  Widget contetntAnnounce(int _contents1id, int _contents2id, bool _isAlarm)
  {
    return
    Padding(
      padding: const EdgeInsets.only(left: 44, top: 10),
      child: Column
      (
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
            Container
            (
              //color: Colors.red,
              height: 40,
              //width: 200.w,
              child: Text(StringTable().Table![_contents1id]!,
                style:
                const TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w500,),),
            ),
            Container
            (
              //color: Colors.blue,
              height: 40,
              //width: 200.w,
              child: Text(StringTable().Table![_contents2id]!,
                style:
                TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w500,),),
            ),
            GestureDetector
            (
              onTap: ()
              {
                var moveindex = 1;
                if (_isAlarm)
                {
                  moveindex = 2;
                }
                MainBottomNavgationBarController.to.selectedIndex.value = moveindex;
              },
              child:
              Container
              (
                padding: EdgeInsets.only(bottom: 1),
                alignment: Alignment.center,
                width: 90,
                height: 26,
                decoration:
                ShapeDecoration
                (
                  shape:
                  RoundedRectangleBorder
                    (
                    side: BorderSide(width: 1.50, color: Color(0xFF4D4D4D)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child:
                Text
                (
                  StringTable().Table![400101]!,
                  style:
                  const TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget contentsView(List<ContentData> _list, [bool _isAlram = false])
  {
    if (_list.length == 0)
      return SizedBox();

    return
      Center(
        child: Container
        (
          width: MediaQuery.of(context).size.width,
          //color: Colors.red,
          child:
          Column
          (
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
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
                    SizedBox(width: 10,),
                    for(var item in _list)
                      contentItem(item, _isAlram),
                    SizedBox(width: 10,),
                  ],
                ),
              ),
              //SizedBox(height: 30,),
            ],
          ),
        ),
      );
  }

  Widget contentItem(ContentData _data, bool _isAlram)
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
                Get.to(() => const ContentInfoPage(), arguments: _data);
              },
              child:
              Stack
              (
                alignment: _data.isWatching ? Alignment.center : Alignment.topRight,
                children:
                [
                  Container
                  (
                    width: 105,
                    height: 160,
                    // decoration: ShapeDecoration
                    // (
                    //   color: Color(0xFFC4C4C4),
                    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                    // ),
                    child:
                    ClipRRect
                    (
                      borderRadius: BorderRadius.circular(7),
                      child:
                      _data.imagePath != null ?
                      Image.network(_data.imagePath!, fit: BoxFit.cover,) : Container(),
                    ),
                  ),
                  Visibility
                  (
                    visible: _data.isNew,
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
                        StringTable().Table![500014]!,
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
                        visible: _data.rank,
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
            SizedBox(height: 2,),
            Container
            (
              //color: Colors.red,
              width: 105,
              height: 14,
              child:
              Text
              (
                _data.title!,
                style:
                TextStyle(fontSize: 10, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
              ),
            ),
            SizedBox(height: 4,),
            Visibility
            (
              visible: _isAlram,
              child:
              Container
              (
                //color: Colors.red,
                width: 105,
                height: 14,
                child:
                Text
                (
                  SetTableStringArgument(200001, [SubstringDate(_data.releaseAt!).$2, SubstringDate(_data.releaseAt!).$3]),
                  style:
                  TextStyle(fontSize: 9, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                ),
              ),
            ),
          ],
        ),
      );
  }
}
