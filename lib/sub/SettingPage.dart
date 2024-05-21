
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../table/StringTable.dart';
import 'AccountInfoPage.dart';

enum SettingSubPageType
{
  NONE,
  ACCOUNT_INFO,
  LOG_OUT,
  CASH_DELETE,
  SERVICE_POLICY,
  PRIVATE_POLICY,
  LEGAL_NOTICE,
  ACCOUNT_DELETE,
}

class SettingPage extends StatefulWidget
{
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>
{
  bool _isChecked = true;
  String cacheSize = '';
  final VoidCallback _callback = () {};

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
                  Text(StringTable().Table![400013]!,
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
                  _option(400040, SettingSubPageType.ACCOUNT_INFO),
                  _option(400041, SettingSubPageType.NONE, true),
                  //_option(400042, SettingSubPageType.CASH_DELETE),
                  _option(400043, SettingSubPageType.SERVICE_POLICY),
                  _option(400044, SettingSubPageType.PRIVATE_POLICY),
                  _option(400045, SettingSubPageType.LEGAL_NOTICE),
                  _option(400046, SettingSubPageType.ACCOUNT_DELETE),
                  _option(400047, SettingSubPageType.LOG_OUT),
                  Divider(height: 10, color: Colors.white38, indent: 10, endIndent: 10, thickness: 1,),
                  Text('Ver 1.00' ,
                    style:
                    TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.4), fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _option(int _titleID, SettingSubPageType _moveSubpageType, [bool _isToggle = false]) =>
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
              Text(StringTable().Table![_titleID]!,
                style:
                TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),),
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

  Widget _moveButton(SettingSubPageType _type) =>
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
      case SettingSubPageType.ACCOUNT_INFO:
        Get.to(()=> AccountInfoPage());
        break;
      case SettingSubPageType.ACCOUNT_DELETE:
        {
          showDialogTwoButton(600014, 600015,
          () =>
          {
            print('Account Delete ok Clikc'),
          });
        }
        break;
      case SettingSubPageType.LOG_OUT:
        {
          showDialogTwoButton(600011,0,
          ()=>
          {
            print('Logout ok Clikc'),
          });
        }
        break;
      default:
        print('not found type ${_type}');
        break;
      }
    },
  );

  Widget _toggleButton() =>
  Transform.scale
  (
    scale: 0.7,
    child:
    CupertinoSwitch
    (
      value: _isChecked,
      activeColor: Color(0xFF00FFBF),
      onChanged: (bool? value)
      {
        //TODO : 서버에 알리기
        setState(()
        {
          _isChecked = value ?? false;
        });
      },
    ),
  );

  void showDialogTwoButton(int _titieID, int _contentID, VoidCallback _callback)
  {
    Get.defaultDialog
    (
      backgroundColor: Color(0x1E1E1E).withOpacity(1),
      title: StringTable().Table![_titieID]!,
      titleStyle:
      TextStyle
      (
        fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
        titlePadding: EdgeInsets.only(top: 30),
        contentPadding: _contentID == 0 ? EdgeInsets.only(top: 0) : EdgeInsets.only(top: 30),
        content : _contentID != 0 ?
        Text(StringTable().Table![_contentID]!, style: TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),) : Text(''),
        actions:
        [
          ElevatedButton
          (
            style:
            ButtonStyle
            (
              backgroundColor:
              MaterialStatePropertyAll<Color>(Color(0x1E1E1E).withOpacity(1)),
              fixedSize: MaterialStateProperty.all(Size(100, 40)),
              //padding: MaterialStateProperty.all(EdgeInsets.only(left: 10)),
            ),
            onPressed: ()
            {
              Get.back();
            },
            child:
            Text
            (
                StringTable().Table![600008]!,
                style: TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
            ),
          ),
          SizedBox(width: 10,),
          ElevatedButton
          (
            style:
            ButtonStyle
              (
              backgroundColor:
              MaterialStatePropertyAll<Color>(Color(0x1E1E1E).withOpacity(1)),
              fixedSize: MaterialStateProperty.all(Size(100, 40)),
              //padding: MaterialStateProperty.all(EdgeInsets.only(left: 10)),
            ),
            onPressed: ()
            {
              Get.back();
              _callback();
            },
            child:
            Text
            (
              StringTable().Table![600007]!,
              style: TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
            ),
          ),
        ],
      );
    }
}