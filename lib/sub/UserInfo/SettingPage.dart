
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shortplex/Util/HttpProtocolManager.dart';
import 'package:shortplex/Util/LoginMananger.dart';
import 'package:shortplex/table/UserData.dart';

import '../../Util/ShortplexTools.dart';
import '../../table/StringTable.dart';
import 'AccountInfoPage.dart';
import 'LoginPage.dart';

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
  //final VoidCallback _callback = () {};

  @override
  void initState() {
    _isChecked = UserData.to.Alarmallow;
    super.initState();
  }

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
                    TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),),

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
                  Obx(() {
                    return
                    Visibility(visible: UserData.to.isLogin.value, child:_option(400046, SettingSubPageType.ACCOUNT_DELETE),);
                  },),
                  Obx(() {
                    return
                    Visibility(visible: UserData.to.isLogin.value, child:_option(400047, SettingSubPageType.LOG_OUT),);
                  },),
                  Divider(height: 10, color: Colors.white.withOpacity(0.6), indent: 10, endIndent: 10, thickness: 1,),
                  Text
                  (
                    'Ver 1.00' ,
                    style:
                    TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                  ),
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
              width: _isToggle ? 260.w : 280.w,
              //color: Colors.yellow,
              alignment: Alignment.centerLeft,
              child:
              Text
              (
                StringTable().Table![_titleID]!,
                style:
                TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),),
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

  bool buttonEnabled = true;
  Widget _moveButton(SettingSubPageType _type)
  {
    return
    IconButton
    (
      alignment: Alignment.center,
      color: Colors.white,
      iconSize: 20,
      icon: const Icon(Icons.arrow_forward_ios),
      onPressed: buttonEnabled ? ()
      {
        switch (_type)
        {
          case SettingSubPageType.ACCOUNT_INFO:
            {
              if (UserData.to.isLogin.value == false)
              {
                showDialogTwoButton(StringTable().Table![600018]!, '',
                ()
                {
                  Get.to(() => const LoginPage());
                });
                return;
              }

              Get.to(() => const AccountInfoPage());
            }
            break;
          case SettingSubPageType.ACCOUNT_DELETE:
            {
              showDialogTwoButton(StringTable().Table![600014]!, StringTable().Table![600015]!,
              ()
              {
                HttpProtocolManager.to.Send_DeleteAccount().then((value)
                {
                  Get.find<LoginMananger>().LogOut(true).then((value)
                  {
                    buttonEnabled = true;
                  },);
                },);
                print('Account Delete ok Clikc');

              });
            }
            break;
          case SettingSubPageType.LOG_OUT:
            {
                showDialogTwoButton(StringTable().Table![600011]!, '',
                ()
                async
                {
                  buttonEnabled = false;
                  var loginManager = Get.find<LoginMananger>();

                  await loginManager.LogOut();

                  buttonEnabled = true;
                  print('Logout ok Click');
                });
            }
            break;
          default:
            print('not found type ${_type}');
            break;
        }
      } : null
    );
  }

  Widget _toggleButton()
  {
    return
    Obx(()
    {
      if (UserData.to.isLogin.value)
      {
        _isChecked = UserData.to.Alarmallow;
      }
      return
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
            UserData.to.Alarmallow = value ?? false;

            HttpProtocolManager.to.Send_UserInfo().then((value)
            {
              UserData.to.UpdateInfo(value);

              setState(()
              {
                _isChecked = UserData.to.Alarmallow;
              });
            },);
          },
        ),
      );
    },);
  }
}