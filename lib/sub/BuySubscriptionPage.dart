import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import '../Util/ShortplexTools.dart';
import '../table/StringTable.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

import '../table/UserData.dart';

//import '../table/UserData.dart';

// void main() async
// {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//   Get.lazyPut(()=>UserData());
//   await StringTable().InitTable();
//   runApp(BuySubscriptionPage());
// }

class BuySubscriptionPage extends StatelessWidget
{
  BuySubscriptionPage({super.key});

  //var data = Get.arguments;

  Widget mainWidget(BuildContext context)
  {
    var userData = Get.find<UserData>();

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
                    Text
                    (
                      StringTable().Table![400031]!,
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
              padding: EdgeInsets.only(top: 50),
              child:
              Column
                (
                children:
                [
                  SizedBox(height: 50,),
                  Container
                    (
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 322 / 390,
                    height: 60,
                    //color: Colors.blueGrey,
                    child:
                    Text
                    (
                      textAlign: TextAlign.center,
                      StringTable().Table![400034]!,
                      style:
                      TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                    ),
                  ),
                  SizedBox(height: 20,),

                  Obx(() => userData.isSubscription.value ?
                    Stack
                    (
                      alignment: Alignment.center,
                      children:
                      [
                        SvgPicture.asset
                        (
                          'assets/images/Shop/my_shop_freepass_1.svg',
                        ),
                        Container
                          (
                          alignment: Alignment.centerLeft,
                          width: 290,
                          height: 78,
                          //color: Colors.white,
                          child:
                          Padding
                            (
                            padding: const EdgeInsets.only(top: 15, left: 30),
                            child: Column
                              (
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                              [
                                Text
                                  (
                                  textAlign: TextAlign.center,
                                  StringTable().Table![400014]!,
                                  style:
                                  TextStyle(fontSize: 16, color: Color(0xFF00FFBF), fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                                ),
                                Text
                                  (
                                  textAlign: TextAlign.center,
                                  SetTableStringArgument(400015, ['99.12.31']),
                                  style:
                                  TextStyle(fontSize: 14, color: Color(0xFF00FFBF), fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ) :
                    SvgPicture.asset
                    (
                      'assets/images/Shop/my_shop_freepass.svg',
                    )
                  ),
                  SizedBox(height: 50,),
                  Obx(() => Visibility
                    (
                    visible: !userData.isSubscription.value,
                    child:
                    GestureDetector
                      (
                      onTap: ()
                      {
                        userData.isSubscription(true);
                      },
                      child: Container
                        (
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(bottom: 3),
                        width: 120,
                        height: 40,
                        decoration: ShapeDecoration(
                          color: Color(0xFF1A1A1A),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1.50, color: Color(0xFF00FFBF)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child:
                        Text
                          (
                          textAlign: TextAlign.center,
                          SetTableStringArgument(400035, ['39,900']),
                          style:
                          TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                        ),
                      ),
                    ),
                  ),),

                  SizedBox(height: 50,),
                  Stack
                    (
                    alignment: Alignment.center,
                    children:
                    [
                      Divider(height: 10, color: Colors.white.withOpacity(0.6), indent: 10, endIndent: 10, thickness: 1,),
                      Container
                        (
                        color: Colors.black,
                        padding: EdgeInsets.only(bottom: 3, left: 10, right: 10),
                        child:
                        Text
                          (
                          textAlign: TextAlign.center,
                          StringTable().Table![400036]!,
                          style:
                          TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Container
                    (
                    alignment: Alignment.centerLeft,
                    color: Colors.black,
                    padding: EdgeInsets.only(bottom: 3, left: 30, right: 10),
                    child:
                    Text
                      (
                      textAlign: TextAlign.center,
                      StringTable().Table![400037]!,
                      style:
                      TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }


  @override
  Widget build(BuildContext context)
  {
    return mainWidget(context);
  }
}
