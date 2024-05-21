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
                    Goods(),
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
    return
    ScreenUtilInit
    (
      designSize: Size(390, 844),
      child:
      mainWiget(context),
    );
  }

  Widget Goods()=>
  SvgPicture.asset(
    'assets/images/shop/my_shop.svg',
    width: 94,
    height: 150,
  );
}
