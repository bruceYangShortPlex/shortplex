import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                        Goods(),     Goods(),     Goods(),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row
                    (
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:
                      [
                        Goods(),     Goods(),     Goods(),
                      ],
                    ),
                    goods_subscription(),
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

  Widget Goods()=>
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
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            Padding
            (
              padding: const EdgeInsets.only(bottom: 0),
              child: Text
              (
                StringTable().Table![400023]!,
                style:
                TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
              ),
            ),
            Padding
            (
              padding: const EdgeInsets.only(bottom: 5),
              child: Text
              (
                '+8보너스',
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
                color: Colors.white,
                child:
                Image.asset
                (
                  'assets/images/shortplex.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding
            (
              padding: const EdgeInsets.only(bottom: 4),
              child: Text
              (
                '₩1,900',
                style:
                TextStyle(fontSize: 13, color: Colors.black, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  Widget goods_subscription() =>
      Container
      (
        width: 390,
        height: 50,
        child:
        Row
        (
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
          [
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
                Text(StringTable().Table![400031]!,
                  style:
                  TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),),
              ),
            ),
            Padding
            (
              padding:EdgeInsets.only(right: 10),
              child:
              IconButton
              (
                alignment: Alignment.center,
                color: Colors.white,
                iconSize: 20,
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: ()
                {
                  print('go subscription');
                },
              ),
            ),
          ],
        ),
      );
}
