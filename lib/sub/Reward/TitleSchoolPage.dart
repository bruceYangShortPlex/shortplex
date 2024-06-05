import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../Util/ShortplexTools.dart';
import '../../table/StringTable.dart';


void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await StringTable().InitTable();
  runApp(const TitleSchoolPage());
}

class TitleSchoolPage extends StatefulWidget {
  const TitleSchoolPage({super.key});

  @override
  State<TitleSchoolPage> createState() => _TitleSchoolPageState();
}



class _TitleSchoolPageState extends State<TitleSchoolPage>
{
  late Timer schoolTimer;
  DateTime? endTime;
  Duration? endTimeDifference;
  int bonusCount = 10;

  void startTimer()
  {
    schoolTimer = Timer.periodic(
      const Duration(minutes: 1),(Timer timer) =>
        setState(
        ()
        {
          endTimeDifference = endTimeDifference! - const Duration(minutes: 1);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    endTime = DateTime.now().add(Duration(minutes: 3));
    endTimeDifference = endTime!.difference(DateTime.now());

    startTimer();
  }

  Widget mainWidget(BuildContext context)=>
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
                      StringTable().Table![300002]!,
                      style:
                      TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                    ),
                  ),
                  Container(width: MediaQuery.of(context).size.width * 0.3, height: 50,)
                ],
              ),
            ),
            child:
              Stack
              (
                children:
                [
                  SingleChildScrollView(
                    child: Container
                      (
                        width: MediaQuery.of(context).size.width,
                        //height: MediaQuery.of(context).size.height,
                        //color: Colors.blue,
                        child:
                        Column
                          (
                          children:
                          [
                            Padding
                              (
                              padding: const EdgeInsets.only(left: 35, top: 60),
                              child:
                              Container
                                (
                                width: 390,
                                alignment: Alignment.centerLeft,
                                child:
                                Text
                                  (
                                  StringTable().Table![300004]!,
                                  style:
                                  TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Container
                              (
                              width: 390,
                              height: 287,
                              //color: Colors.blue,
                              child:
                              Stack
                                (
                                children:
                                [
                                  Align
                                    (
                                    alignment: Alignment.topRight,
                                    child:
                                    Padding
                                      (
                                      padding: const EdgeInsets.only(right: 30),
                                      child:
                                      Container
                                        (
                                        width: 130,
                                        height: 55,
                                        decoration: ShapeDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment(0.98, -0.18),
                                            end: Alignment(-0.98, 0.18),
                                            colors: [Color(0xFF033C32), Color(0xFF0A293E)],
                                          ),
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              width: 1,
                                              strokeAlign: BorderSide.strokeAlignOutside,
                                              color: Color(0xFF0A2022),
                                            ),
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                        ),
                                        child:
                                        Padding
                                          (
                                          padding: EdgeInsets.only(top: 4, left: 8, right: 8),
                                          child:
                                          FittedBox
                                            (
                                            alignment: Alignment.topCenter,
                                            child:
                                            Text
                                              (
                                              endTime != null ? SetTableStringArgument(800007, [formatDuration(endTimeDifference!).$1,formatDuration(endTimeDifference!).$2]) : '',
                                              style:
                                              TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align
                                    (
                                    alignment: Alignment.bottomCenter,
                                    child: Container
                                      (
                                      height: 260,
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 30,),
                            Container(
                              width: 350,
                              height: 60,
                              decoration: ShapeDecoration(
                                color: Color(0xFF242424),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 2, color: Color(0xFF00FFBF)),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: 
                              Row
                              (
                                children: 
                                [
                                  SizedBox(width: 20,),
                                  profileRect(32, ''),
                                  Expanded
                                  (
                                    child:
                                    Container
                                    (
                                      color: Colors.grey,
                                      child: 
                                      Column
                                      (
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: 
                                        [
                                          SizedBox(height: 10,),
                                          Row
                                          (
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children:
                                            [
                                              Container( width: 50, height: 15, color: Colors.yellow,),
                                              Expanded(child: Container(height: 15, color: Colors.blue,))
                                            ],
                                          ),
                                          SizedBox(height: 5,),
                                          Expanded
                                          (
                                            child:
                                            Container
                                            (
                                              height: 15,
                                              color: Colors.red,
                                            )
                                          ),
                                          SizedBox(height: 10,),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container
                                  (
                                    width: 105,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 30,),
                            Container
                              (
                              width: 220,
                              height: 40,
                              decoration: ShapeDecoration(
                                color: Color(0xFF242424),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(bottom: 2),
                              child:
                              Text
                                (
                                StringTable().Table![300030]!,
                                style:
                                TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                              ),
                            ),
                            SizedBox(height: 30,),
                            Container
                              (
                              width: 220,
                              height: 122,
                              decoration: ShapeDecoration(
                                color: Color(0xFF242424),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 1.50, color: Color(0xFFA0A0A0)),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child:
                              Column
                                (
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                [
                                  Text
                                    (
                                    StringTable().Table![300031]!,
                                    style:
                                    TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                                  ),
                                  SizedBox(height: 15,),
                                  Text
                                    (
                                    StringTable().Table![300032]!,
                                    style:
                                    TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                                  ),
                                  SizedBox(height: 15,),
                                  Text
                                    (
                                    StringTable().Table![300033]!,
                                    style:
                                    TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 25,),
                            Container
                              (
                              width: 330,
                              //color: Colors.grey,
                              child:
                              Column
                                (
                                children:
                                [
                                  Text
                                    (
                                    StringTable().Table![300028]!,
                                    style:
                                    TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                                  ),
                                  SizedBox(height: 15,),
                                  Text
                                    (
                                    SetTableStringArgument(300029, ['$bonusCount']),
                                    style:
                                    TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30,),
                            Divider(height: 10, color: Colors.white38, indent: 10, endIndent: 10, thickness: 1,),
                            Container
                              (
                                width: 330,
                                height: 30,
                                //color: Colors.grey,
                                child:
                                Row
                                  (
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:
                                  [
                                    Text
                                      (
                                      StringTable().Table![300034]!,
                                      style:
                                      TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                                    ),
                                    IconButton
                                      (
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(bottom: 1),
                                      color: Colors.white,
                                      iconSize: 20,
                                      icon: const Icon(Icons.arrow_forward_ios), onPressed: ()
                                    {

                                    },
                                    ),
                                  ],
                                )
                            ),
                            Divider(height: 10, color: Colors.white38, indent: 10, endIndent: 10, thickness: 1,),
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
                                    StringTable().Table![300035]!,
                                    style:
                                    TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Container
                              (
                              width: 306,
                              child: Text
                                (
                                //textAlign: TextAlign.left,
                                StringTable().Table![300036]!,
                                style:
                                TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                              ),
                            ),
                            SizedBox(height: 90,),
                          ],
                        )
                    ),
                  ),
                  Align
                  (
                    alignment: Alignment.bottomCenter,
                    child:
                    GestureDetector
                    (
                      onTap: ()
                      {
                        print('open');
                      },
                      child:
                      Container
                      (
                        width: 390,
                        height: 50,
                        //color: Colors.grey,
                        child:
                        Row
                        (
                          children:
                          [
                            Container
                            (
                              width: 390,
                              color: Colors.black,
                              child:
                              Row
                              (
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>
                                [
                                  profileRect(26, ''),
                                  Expanded
                                  (
                                    child:
                                    Container
                                    (
                                      //color: Colors.blue,
                                      child:
                                      Container
                                      (
                                        padding: EdgeInsets.only(left: 20, bottom: 2),
                                        alignment: Alignment.centerLeft,
                                        height: 32,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF1E1E1E),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                        ),
                                        child:
                                        Text
                                        (
                                          StringTable().Table![100041]!,
                                          style: TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.send, color: Colors.grey,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),

          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return mainWidget(context);
  }
}
