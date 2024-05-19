import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../table/StringTable.dart';
import '../table/UserData.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(()=>UserData());
  await StringTable().InitTable();
  runApp(WalletInfoPage());
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
                    TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),),
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
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children:
                                      [
                                        _moneyInfo('assets/images/shortplex.png', Get.find<UserData>().GetPopupcornCount().$1),

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
                                        _moneyInfo('assets/images/shortplex.png', Get.find<UserData>().GetPopupcornCount().$2),
                                      ],
                                    ),
                                    Padding
                                    (
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Container
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

                                        GestureDetector
                                          (
                                          child: Text(StringTable().Table![400009]!,
                                            style:
                                            TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),),
                                          onTap: ()
                                          {
                                            print('Clic go to shop');
                                          },
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
                                  TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),),
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
                              Text(StringTable().Table![400007]!,
                                style:
                                TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 50, color: Colors.white38, indent: 10, endIndent: 10, thickness: 1,),
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
    padding: const EdgeInsets.only(left: 20, top: 20),
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
}
