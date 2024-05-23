import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shortplex/sub/PhoneConfirmPage.dart';
import '../table/StringTable.dart';

enum AccountInfoSubPageType
{
  NONE,
  PHONENUMBER_INPUT,
}

class AccountInfoPage extends StatefulWidget {
  const AccountInfoPage({super.key});

  @override
  State<AccountInfoPage> createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage>
{
  var _infoCount = 0;

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
                  Text(StringTable().Table![400040]!,
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
                  _option(400049),
                  _option(400050),
                  _option(400051),
                  _option(400052, AccountInfoSubPageType.PHONENUMBER_INPUT),
//_option(400053),
                  Divider(height: 10, color: Colors.white38, indent: 10, endIndent: 10, thickness: 1,),
                  Padding
                    (
                    padding: EdgeInsets.all(20),
                    child:
                    Text(StringTable().Table![400055]!,
                      style:
                      TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),),
                  ),
                  Padding
                  (
                    padding: EdgeInsets.only(top: 20.0),
                    child:
                    Container
                    (
                      width: 356.w,
                      height: 100,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          Text(StringTable().Table![400056]!,
                          style:
                          TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),),
                          SizedBox(height: 10,),
                          Text('${_infoCount} / 4',
                            style:
                            TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),),
                        ],
                      ),
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _option(int _titleID, [AccountInfoSubPageType _type = AccountInfoSubPageType.NONE]) =>
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
                  width: 280,
                  //color: Colors.yellow,
                  alignment: Alignment.centerLeft,
                  child:
                  Text
                  (
                    StringTable().Table![_titleID]!,
                    style:
                    TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                  ),
                ),
              ),
              Padding
              (
                padding:EdgeInsets.only(right: 20),
                child: IconButton(icon: Icon(Icons.add), color: Colors.white,
                  onPressed: ()
                  {
                      switch(_type)
                      {
                        case AccountInfoSubPageType.PHONENUMBER_INPUT:
                          Get.to(() => PhoneConfirmPage());
                          break;
                        default:
                          print('Not found page type : ${_type}');
                          break;
                      }
                  },),
              ),
            ],
          ),
        ],
      );
}
