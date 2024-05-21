import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shortplex/Util/ShortplexTools.dart';
import 'package:shortplex/sub/BuySubscriptionPage.dart';
import '../table/StringTable.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

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
                        Goods(SetStringArg(400060, ['20']),'','assets/images/User/my_popcon.png', '₩1,900', ''),
                        Goods(SetStringArg(400060, ['40']),SetStringArg(400008, ['+2']),'assets/images/Shop/my_popcon2.png', '₩3,900', SetStringArg(400028, [' 5'])),
                        Goods(SetStringArg(400060, ['80']),SetStringArg(400008, ['+8']),'assets/images/Shop/my_popcon3.png', '₩7,900', SetStringArg(400028, ['10'])),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row
                    (
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:
                      [
                        Goods(SetStringArg(400060, ['140']),SetStringArg(400008, ['+21']),'assets/images/Shop/my_popcon4.png', '₩13,900', SetStringArg(400028, ['15'])),
                        Goods(SetStringArg(400060, ['200']),SetStringArg(400008, ['+40']),'assets/images/Shop/my_popcon5.png', '₩19,900', SetStringArg(400028, ['20'])),
                        Goods(SetStringArg(400060, ['300']),SetStringArg(400008, ['+90']),'assets/images/Shop/my_popcon6.png', '₩29,900', SetStringArg(400028, ['30'])),
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
                            StringTable().Table![400032]!,
                            style:
                            TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                          ),
                        ),
                      ],
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
                        TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
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

  Widget Goods(String _title, String _bonus, String _iconPath, String _price, String _sale) =>
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
                _title,
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
      Visibility
      (
        visible: _bonus != '',
        child:
        Stack
        (
          alignment: Alignment.center,
          children:
          [
            SvgPicture.asset
            (
              alignment: Alignment.center,
              'assets/images/shop/my_shop_1.svg',
              width: 94,
              height: 150,
            ),

              Transform
              (
                transform: Matrix4.identity()..translate(41, -67.0)..rotateZ(0.79),
                child:
                Text
                (
                  _sale,
                  style:
                  TextStyle(fontSize: 9, color: Colors.black, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                ),
              ),
          ],
        ),
      )

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

                Text
                (
                  StringTable().Table![400031]!,
                  style:
                  TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                ),

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
              Get.to(() => BuySubscriptionPage(), arguments: ['₩39,900']);
              print('go subscription');
            },
          ),
        ),
      ],
    );
}
