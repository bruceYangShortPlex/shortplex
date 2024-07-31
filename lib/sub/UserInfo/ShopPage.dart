import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shortplex/Network/Product_Res.dart';
import 'package:shortplex/Util/HttpProtocolManager.dart';
import 'package:shortplex/Util/InAppPurchaseService.dart';
import 'package:shortplex/Util/ShortplexTools.dart';
import 'package:shortplex/sub/Home/HomeData.dart';
import '../../table/StringTable.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

import '../../table/UserData.dart';
import 'BuySubscriptionPage.dart';
import 'LoginPage.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage>
{
  getProducts()
  {
    HttpProtocolManager.to.Get_Products().then((value)
    {
      if (value != null)
      {
        if (value.data!.items!.isEmpty)
        {
          print('Products list is Zero !!!!!!');
        }
        else
        {
          if (kDebugMode)
          {
            print('Get_Products result : ${value.data!.items!.length}');
          }
          HomeData.to.productList.value = value.data!.items!;
        }
      }
    },);
  }

  @override
  void initState()
  {
    //getProducts();

    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return mainWidget(context);
  }

  Widget mainWidget(BuildContext context)
  {
    try
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
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.3,
                      height: 50,
                      //color: Colors.blue,
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      child:
                      CupertinoNavigationBarBackButton
                      (
                        color: Colors.white,
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                    Container
                    (
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.3,
                      height: 50,
                      //color: Colors.green,
                      alignment: Alignment.center,
                      child:
                      Text
                        (
                        StringTable().Table![400021]!,
                        style:
                        TextStyle(
                          fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                      ),
                    ),
                    Container(width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.3, height: 50,)
                  ],
                ),
              ),
              child:
              Container
              (
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                //color: Colors.blue,
                child:
                Padding
                (
                  padding: EdgeInsets.only(top: 60),
                  child:
                  SingleChildScrollView(child: ShopGoods())
                ),
              ),
            ),
          ),
        );
    }
    catch(e)
    {
      print('shop error $e');
      return
      Container
      (
        child:
        CupertinoNavigationBarBackButton
        (
          color: Colors.white,
          onPressed: ()
          {
            Get.back();
          },
        ),
      );
    }
  }
}

Widget ShopGoods([bool _visibleTap = true])
{
  return
    Column
    (
      mainAxisAlignment: MainAxisAlignment.start,
      children:
      [
        Visibility
        (
          visible: _visibleTap,
          child: Padding
          (
            padding: EdgeInsets.only(right: 300.w, top: 10),
            child:
            Text
            (
              StringTable().Table![400023]!,
              style:
              TextStyle
              (
                fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
            ),
          ),
        ),
        SizedBox(height: 20,),
        Obx(()
        {
          var products = <ProductItem>[];
          if (HomeData.to.productList.length >= 3) {
            products = HomeData.to.productList.sublist(0, 3);
          }

          return
          Row
          (
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
            [
              for(int i = 0; i < products.length; ++i)
                Goods(SetStringArgument(products[i].name,[products[i].popcorns.toString()]),
                    products[i].bonus == 0 ? '' : SetTableStringArgument(400008, [products[i].bonus.toString()]),
                    HomeData.to.GetShopIcon(products[i].popcorns.toString(), false), HomeData.to.GetPrice(products[i].id),
                    products[i].bonusrate == '0' ? '' :SetTableStringArgument(400028, [products[i].bonusrate]), products[i].id),
            ],
          );
        },),
        SizedBox(height: 20,),
        Obx(()
        {
          var products = <ProductItem>[];
          if (HomeData.to.productList.length >= 6) {
            products = HomeData.to.productList.sublist(3, 6);
          }

          return
            Row
            (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
              [
                for(int i = 0; i < products.length; ++i)
                  Goods(SetStringArgument(products[i].name,[products[i].popcorns.toString()]),
                      products[i].bonus == 0 ? '' : SetTableStringArgument(400008, [products[i].bonus.toString()]),
                      HomeData.to.GetShopIcon(products[i].popcorns.toString(), false), HomeData.to.GetPrice(products[i].id),
                      products[i].bonusrate == '0' ? '' :SetTableStringArgument(400028, [products[i].bonusrate]), products[i].id),
              ],
            );
        },),
        SizedBox(height: 20,),
        Container
        (
          width: 330.w,
          height: 50,
          //color: Colors.green,
          child: goods_subscriptionTitle(),
        ),
        SizedBox(height: 15,),
        GestureDetector
        (
          onTap: ()
          {
            Get.to(() => BuySubscriptionPage());
          },
          child:
          Container
          (
            width: 330.w,
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
        ),
        SizedBox(height: 30,),
        Visibility
        (
          visible: _visibleTap,
          child:
          Stack
            (
            alignment: Alignment.center,
            children:
            [
              Divider(height: 10,
                color: Colors.white.withOpacity(0.6),
                indent: 10,
                endIndent: 10,
                thickness: 1,),
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
                  TextStyle(fontSize: 16,
                    color: Colors.grey,
                    fontFamily: 'NotoSans',
                    fontWeight: FontWeight.bold,),
                ),
              ),
            ],
          ),
        ),
        Visibility
        (
          visible: _visibleTap,
          child:
          Container
          (
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 5),
            width: 330.w,
            height: 110,
            //color: Colors.blueGrey,
            child:
            Text
              (
              StringTable().Table![400033]!,
              style:
              TextStyle(fontSize: 13,
                color: Colors.grey,
                fontFamily: 'NotoSans',
                fontWeight: FontWeight.w500,),
            ),
          ),
        )
      ],
  );
}

Widget Goods(String _title, String _bonus, String _iconPath, String _price, String _sale, String _pid)
{
  // print('_title : $_title');
  // print('_bonus : $_bonus');
  // print('_iconPath : $_iconPath');
  // print('_price : $_price');
  // print('_sale : $_sale');
  // print('_pid : $_pid');

  return
  GestureDetector
  (
    onTap: ()
    {
      if (HttpProtocolManager.to.connecting)
      {
        print('connecting return');
        return;
      }

      print('Click Buy Product $_pid');

      if (UserData.to.isLogin.value == false)
      {
        showDialogTwoButton(StringTable().Table![600018]!, '',
        ()
        {
          Get.to(() => LoginPage());
        });
        return;
      }

      InAppPurchaseService.to.BuyProcess(_pid);
    },
    child:
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
                padding: const EdgeInsets.only(top: 16),
                child:
                Text
                  (
                  _title,
                  style:
                  TextStyle(fontSize: 13,
                    color: Colors.white,
                    fontFamily: 'NotoSans',
                    fontWeight: FontWeight.bold,),
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
                  TextStyle(fontSize: 9,
                    color: Color(0xFF00FFBF),
                    fontFamily: 'NotoSans',
                    fontWeight: FontWeight.bold,),
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
            width: 94,
            height: 25,
            color: Color(0xFF00FFBF),
            padding: EdgeInsets.only(bottom: 2),
            child:
            Text
              (
              _price,
              style:
              TextStyle(fontSize: 13,
                color: Colors.black,
                fontFamily: 'NotoSans',
                fontWeight: FontWeight.bold,),
            ),
          ),
        ),
        Visibility
          (
          visible: _bonus != '',
          child:
          SvgPicture.asset
          (
            alignment: Alignment.center,
            'assets/images/shop/my_shop_1.svg',
            width: 94,
            height: 150,
          ),
        ),
        Positioned
          (
          bottom: 138,
          right: 8,
          child:
          Text
            (
            _sale,
            style:
            TextStyle(fontSize: 10,
              color: Colors.black,
              fontFamily: 'NotoSans',
              fontWeight: FontWeight.bold,),
          ),
        ),
      ],
    ),
  );
}

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
              TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
