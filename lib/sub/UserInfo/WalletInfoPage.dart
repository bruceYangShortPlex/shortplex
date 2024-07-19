import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shortplex/sub/UserInfo/ShopPage.dart';
import 'package:shortplex/sub/UserInfo/UsedHistoryPage.dart';

import '../../table/StringTable.dart';
import '../../table/UserData.dart';
import 'BonusHistoryPage.dart';
import 'ChargeHistoryPage.dart';

enum WalletSubPageType
{
  NONE,
  CHARGET_HISTORY,
  BONUS_HISTORY,
  USED_HISTORY,
}

class WalletInfoPage extends StatefulWidget
{
  const WalletInfoPage({super.key});

  @override
  State<WalletInfoPage> createState() => _WalletInfoPageState();
}

class _WalletInfoPageState extends State<WalletInfoPage>
{
  @override
  Widget build(BuildContext context)
  {
    return
    SafeArea
    (
      child:
      CupertinoApp
      (
        home:
        CupertinoPageScaffold
        (
          backgroundColor: Colors.black,
          navigationBar:
          CupertinoNavigationBar
          (
            backgroundColor: Colors.transparent,
            leading:
            Row
            (
              mainAxisAlignment: MainAxisAlignment.start,
              children:
              [
                Container
                (
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 50,
                  //color: Colors.blue,
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                  child:
                  CupertinoNavigationBarBackButton
                  (
                    color: Colors.white,
                    onPressed: ()
                    {
                      Get.back();
                    },
                  ),
                ),
                Container
                (
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 50,
                  //color: Colors.green,
                  alignment: Alignment.center,
                  child:
                  Text(StringTable().Table![400005]!,
                    style:
                    TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),),
                ),
                Container(width: MediaQuery.of(context).size.width * 0.3, height: 50,)
              ],
            ),
          ),
          child:
          Container
          (
            alignment: Alignment.topCenter,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            //color: Colors.yellow,
            child:
            Padding
            (
              padding: const EdgeInsets.only(top: 80),
              child:
              Column
              (
                children:
                [
                  Padding
                  (
                    padding: EdgeInsets.only(top: 5.0),
                    child:
                    Stack
                    (
                        children:
                        [
                          Center
                          (
                            child: Padding
                            (
                              padding: const EdgeInsets.only(top: 13),
                              child: Container
                              (
                                width: MediaQuery.of(context).size.width * (356 / 390),
                                height: 135,
                                decoration: ShapeDecoration
                                (
                                  gradient: LinearGradient
                                  (
                                    begin: Alignment(-1.00, 0.5),
                                    end: Alignment(1, 0.5),
                                    colors: [Color(0x330006A5).withOpacity(0.22), Color(0xFF00FFBF).withOpacity(0.22),],
                                  ),
                                  shape: RoundedRectangleBorder
                                  (
                                    side: BorderSide(width: 1.50, color: Color(0xFF4D4D4D)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child:
                                Column
                                (
                                  children:
                                  [
                                    Row
                                    (
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:
                                      [
                                        Expanded
                                        (
                                          flex: 3,
                                          child:
                                          Obx(()
                                          {
                                            return
                                            _moneyInfo('assets/images/User/my_popcon.png', UserData.to.GetPopupcornCount().$1);
                                          },)
                                        ),
                                        Expanded
                                        (
                                          flex: 1,
                                          child:
                                          Padding
                                          (
                                            padding: const EdgeInsets.only(top: 20),
                                            child:
                                            Opacity
                                            (
                                              opacity: 0.80,
                                              child: Transform
                                                (
                                                alignment: Alignment.center,
                                                transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(1.57),
                                                child:
                                                Container
                                                (
                                                  //color: Colors.white,
                                                  height: 0.5,
                                                  width: 56,
                                                  decoration: ShapeDecoration(
                                                    shape: RoundedRectangleBorder(
                                                      side: BorderSide
                                                      (
                                                        width: 1.50,
                                                        strokeAlign: BorderSide.strokeAlignCenter,
                                                        color: Colors.white.withOpacity(0.4),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded
                                        (
                                          flex: 3,
                                          child:
                                          Obx(()
                                          {
                                            return
                                            _moneyInfo('assets/images/User/my_bonus.png', Get.find<UserData>().GetPopupcornCount().$2);
                                          },)
                                        ),
                                      ],
                                    ),
                                    Padding
                                    (
                                      padding: const EdgeInsets.only(top: 5),
                                      child:
                                      GestureDetector
                                      (
                                        onTap: ()
                                        {
                                          Get.to(() => ShopPage());
                                        },
                                        child:
                                        Container
                                        (
                                          alignment: Alignment.center,
                                          width: 152,
                                          height: 26,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFF1E1E1E),
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(width: 1.50, color: Color(0xFF00FFBF)),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          child:
                                          Padding
                                          (
                                            padding: const EdgeInsets.only(bottom: 3),
                                            child: Text(StringTable().Table![400009]!,
                                              style:
                                              TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row
                          (
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:
                            [
                              Container
                              (
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(bottom: 2),
                                width: 49,
                                height: 24,
                                decoration:
                                ShapeDecoration
                                (
                                  color: Colors.black,
                                  shape:
                                  RoundedRectangleBorder
                                  (
                                    side:
                                    BorderSide
                                    (
                                        width: 1.50,
                                        color: Color(0xFF00FFBF)
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                                child:
                                Text(StringTable().Table![400006]!,
                                  style:
                                  TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),),
                            ),
                            Container
                            (
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(bottom: 2),
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
                                const TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  //Divider(height: 50, color: Colors.white38, indent: 10, endIndent: 10, thickness: 1,),
                  _option(400017, WalletSubPageType.CHARGET_HISTORY),
                  _option(400018, WalletSubPageType.BONUS_HISTORY),
                  _option(400019, WalletSubPageType.USED_HISTORY),
                  _option(400020, WalletSubPageType.NONE, true),
                  Divider(height: 10, color: Colors.white38, indent: 10, endIndent: 10, thickness: 1,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _moneyInfo(String _imagePath, String _text) =>
  Padding
  (
    padding: const EdgeInsets.only(top: 20),
    child:
    Container
    (
      width: 150,
      height: 70,
      //color: Colors.green,
      child:
      Column
      (
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
        [
          SizedBox
          (
            height: 30,
            width: 30,
            child:
            Image.asset(_imagePath, fit: BoxFit.fitHeight,)
          ),
          Text(_text, style: TextStyle(color: Colors.white,fontFamily: 'NotoSans', fontSize: 16),),
        ],
      ),
    ),
  );

  Widget _option(int _titleID, WalletSubPageType _moveSubpageType, [bool _isToggle = false]) =>
      Column
        (
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        [
          Divider(height: 10, color: Colors.white38, indent: 10, endIndent: 10, thickness: 1,),
          Row
          (
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
            [
              Padding
                (
                padding:EdgeInsets.only(left: 30),
                child:
                Container
                (
                  height: 30,
                  width: _isToggle ? 260.w : 280.w,
                  //color: Colors.yellow,
                  alignment: Alignment.centerLeft,
                  child:
                  Text(StringTable().Table![_titleID]!,
                    style:
                    TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),),
                ),
              ),
              Padding
              (
                padding:EdgeInsets.only(right: 20),
                child: _isToggle ? _toggleButton() : _moveButton(_moveSubpageType),
              ),
            ],
          ),
        ],
      );

  Widget _toggleButton() =>
      Transform.scale
        (
        scale: 0.7,
        child:
        CupertinoSwitch
          (
          value: UserData.to.autoPlay,
          activeColor: Color(0xFF00FFBF),
          onChanged: (bool? value)
          {
            //TODO : 서버에 알리기
            setState(()
            {
              UserData.to.autoPlay = value ?? false;
            });
          },
        ),
      );

  Widget _moveButton(WalletSubPageType _type) =>
    IconButton
      (
        alignment: Alignment.center,
        color: Colors.white,
        iconSize: 20,
        icon: const Icon(Icons.arrow_forward_ios),
        onPressed: ()
        {
          switch(_type)
          {
            case WalletSubPageType.CHARGET_HISTORY:
              Get.to(()=> ChargeHistoryPage(PageTitle: StringTable().Table![400017]!));
              break;
            case WalletSubPageType.BONUS_HISTORY:
              Get.to(()=> BonusHistoryPage(PageTitle:StringTable().Table![400018]!));
              break;
            case WalletSubPageType.USED_HISTORY:
              Get.to(()=> UsedHistoryPage(PageTitle:StringTable().Table![400019]!));
              break;
            default:
              print('not found type ${_type}');
              break;
          }
        },
      );
}
