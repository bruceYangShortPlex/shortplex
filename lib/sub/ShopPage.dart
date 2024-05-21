import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import '../table/StringTable.dart';
import '../table/UserData.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Get.lazyPut(()=>UserData());
  await StringTable().InitTable();
  runApp(ShopPage());
}

class ShopPage extends StatelessWidget
{
  const ShopPage({super.key});

  Widget mainWiget(BuildContext context)=>
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
                    Text
                    (
                      StringTable().Table![400021]!,
                      style:
                      TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                    ),
                  ),
                  Container(width: MediaQuery.of(context).size.width * 0.3, height: 50,)
                ],
              ),
            ),
            child:
            Container
            (
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              //color: Colors.blue,
              child:
              Padding
              (
                padding: const EdgeInsets.only(top: 60.0),
                child:
                Column
                (
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:
                  [
                    Padding
                    (
                      padding: const EdgeInsets.only(right: 400.0, top: 10),
                      child:
                      Text
                      (
                        StringTable().Table![400023]!,
                        style:
                        TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row
                    (
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:
                      [
                        Goods(400060,'','assets/images/User/my_popcon.png', '₩1,900'),
                        Goods(400060,'+2보너스','assets/images/Shop/my_popcon2.png', '₩3,900'),
                        Goods(400060,'+2보너스','assets/images/Shop/my_popcon3.png', '₩7,900'),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row
                    (
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:
                      [
                        Goods(400060,'+21보너스','assets/images/Shop/my_popcon4.png', '₩13,900'),
                        Goods(400060,'+40보너스','assets/images/Shop/my_popcon5.png', '₩19,900'),
                        Goods(400060,'+90보너스','assets/images/Shop/my_popcon6.png', '₩29,900'),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Container
                    (
                      width: MediaQuery.of(context).size.width * 330 / 390,
                      height: 50,
                      //color: Colors.green,
                      child: goods_subscriptionTitle(),
                    ),
                    SizedBox(height: 15,),
                    Container
                    (
                      width: MediaQuery.of(context).size.width * 330 / 390,
                      height: 78,
                      //color: Colors.grey,
                      child:
                      SvgPicture.asset
                      (
                        'assets/images/shop/my_shop_freepass.svg',
                        width: 330,
                        height: 78,
                      ),
                    ),
                    SizedBox(height: 30,),
                    Container
                    (
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width * 330 / 390,
                      height: 20,
                      //color: Colors.blueGrey,
                      child:
                      Text
                      (
                        StringTable().Table![400032]!,
                        style:
                        TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                      ),
                    ),
                    Container
                    (
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(top: 5),
                      width: MediaQuery.of(context).size.width * 330 / 390,
                      height: 110,
                      //color: Colors.blueGrey,
                      child:
                      Text
                      (
                        StringTable().Table![400033]!,
                        style:
                        TextStyle(fontSize: 13, color: Color(0xffA0A0A0), fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context)
  {
    return mainWiget(context);
  }

  Widget Goods(int _titleID, String _bonus, String _iconPath, String _price) =>
  Stack
  (
    alignment: Alignment.center,
    children:
    [
      SvgPicture.asset
      (
        'assets/images/shop/my_shop.svg',
        width: 94,
        height: 150,
      ),
      Container
      (
        width: 94,
        height: 150,
        alignment: Alignment.center,
        child:
        Column
        (
          mainAxisAlignment: MainAxisAlignment.start,
          children:
          [
            Padding
            (
              padding: const EdgeInsets.only(top: 14),
              child:
              Text
              (
                StringTable().Table![_titleID]!,
                style:
                TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
              ),
            ),
            Padding
            (
              padding: const EdgeInsets.only(bottom: 5),
              child:
              Text
              (
                _bonus,
                style:
                TextStyle(fontSize: 9, color: Color(0xFF00FFBF), fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
              ),
            ),
            Padding
            (
              padding: const EdgeInsets.only(bottom: 0),
              child:
              Container
              (
                height: 60,
                width: 60,
                //color: Colors.white,
                child:
                Image.asset
                (
                  _iconPath,
                ),
              ),
            ),
          ],
        ),
      ),
      Padding
      (
        padding: const EdgeInsets.only(top: 95.0),
        child:
        Container
        (
          alignment: Alignment.center,
          width: 94,height: 25,color: Color(0xFF00FFBF),
          child:
          Text
          (
            _price,
            style:
            TextStyle(fontSize: 13, color: Colors.black, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
          ),
        ),
      ),
      SvgPicture.asset
      (
        'assets/images/shop/my_shop_1.svg',
        width: 94,
        height: 150,
      ),
      // Text
      // (
      //   '+5%',
      //   style:
      //   TextStyle(fontSize: 9, color: Colors.black, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
      // ),
    ],
  );

  Widget goods_subscriptionTitle() =>
    Row
    (
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
      [
        Padding
        (
          padding:EdgeInsets.only(left: 0),
          child:
          Container
          (
            height: 30,
            width: 280,
            //color: Colors.yellow,
            alignment: Alignment.centerLeft,
            child:
            Text(StringTable().Table![400031]!,
              style:
              TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),),
          ),
        ),
        Padding
        (
          padding:EdgeInsets.only(right: 0),
          child:
          IconButton
          (
            alignment: Alignment.center,
            iconSize: 20,
            color: Colors.white,
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: ()
            {
              print('go subscription');
            },
          ),
        ),
      ],
    );
}
