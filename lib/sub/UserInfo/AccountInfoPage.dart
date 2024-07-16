import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shortplex/sub/UserInfo/PhoneConfirmPage.dart';
import '../../table/StringTable.dart';
import '../../table/UserData.dart';

enum AccountInfoSubPageType
{
  NONE,
  SEX,
  BIRTH_DAY,
  COUNTRY,
  PHONENUMBER_INPUT,
}

class AccountInfoPage extends StatefulWidget {
  const AccountInfoPage({super.key});

  @override
  State<AccountInfoPage> createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage> with TickerProviderStateMixin
{
  var _infoCount = 0;
  var pagelist = ['2001','2002','2003','2004','2005','2006'];
  late AnimationController tweenController;

  @override
  void initState() {

    super.initState();
    accountInfoCountCheck();

    tweenController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  void accountInfoCountCheck()
  {
    _infoCount = UserData.to.Gender.isNotEmpty ? ++_infoCount : _infoCount;
    _infoCount = UserData.to.BirthDay.isNotEmpty ? ++_infoCount : _infoCount;
    _infoCount = UserData.to.Country.isNotEmpty ? ++_infoCount : _infoCount;
    _infoCount = UserData.to.HP_Number.isNotEmpty ? ++_infoCount : _infoCount;
  }

  @override
  void dispose() {
    tweenController.dispose();
    super.dispose();
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
                  Text
                  (
                    StringTable().Table![400040]!,
                    style:
                    TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                  ),
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
            Stack
            (
              children:
              [
                Padding
                (
                  padding: const EdgeInsets.only(top: 80),
                  child:
                  Column
                  (
                    children:
                    [
                      _option(400049, AccountInfoSubPageType.SEX),
                      _option(400050, AccountInfoSubPageType.BIRTH_DAY),
                      _option(400051, AccountInfoSubPageType.COUNTRY),
                      _option(400052, AccountInfoSubPageType.PHONENUMBER_INPUT),
                      Divider(height: 10, color: Colors.white38, indent: 10, endIndent: 10, thickness: 1,),
                      Padding
                      (
                        padding: EdgeInsets.all(20),
                        child:
                        Text(StringTable().Table![400055]!,
                          style:
                          TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),),
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
                                  TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),),
                                SizedBox(height: 10,),
                                Text('${_infoCount} / 4',
                                  style:
                                  TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),),
                              ],
                            ),
                          )
                      ),
                    ],
                  ),
                ),
                menuSelectPopup(),
              ],
            )
          ),
        ),
      ),
    );
  }

  AccountInfoSubPageType visibleUI = AccountInfoSubPageType.NONE;
  Widget _option(int _titleID, [AccountInfoSubPageType _type = AccountInfoSubPageType.NONE])
  {
    return
    Column
    (
      mainAxisAlignment: MainAxisAlignment.center,
      children:
      [
        Divider(height: 10,
          color: Colors.white38,
          indent: 10,
          endIndent: 10,
          thickness: 1,),
        Stack
        (
          children:
          [
            Row
            (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
              [
                Padding
                (
                  padding: EdgeInsets.only(left: 30),
                  child:
                  Container
                  (
                    height: 30,
                    //width: 280,
                    //color: Colors.yellow,
                    alignment: Alignment.centerLeft,
                    child:
                    Text
                    (
                      StringTable().Table![_titleID]!,
                      style:
                      TextStyle
                      (
                        fontSize: 15,
                        color: Colors.white,
                        fontFamily: 'NotoSans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding
                (
                  padding: EdgeInsets.only(right: 20),
                  child:
                  Obx(()
                  {
                    var text = '';
                    if (UserData.to.isLogin.value)
                    {
                      accountInfoCountCheck();

                      switch (_type)
                      {
                        case AccountInfoSubPageType.SEX:
                          text = UserData.to.Gender;
                          break;
                        case AccountInfoSubPageType.PHONENUMBER_INPUT:
                          text = '+${UserData.to.HP_CountryCode} ${UserData.to.HP_Number}';  //UserData.to.CountryCode + UserData.to.HP_Number;
                          break;
                        case AccountInfoSubPageType.BIRTH_DAY:
                          text = UserData.to.BirthDay;
                          break;
                        case AccountInfoSubPageType.COUNTRY:
                          text = UserData.to.Country;
                          break;
                        default:
                          print('Not found page type : ${_type}');
                          break;
                      }
                    }
                    return
                      text.isNotEmpty ?
                      Text
                        (
                        textAlign: TextAlign.end,
                        text,
                        style:
                        TextStyle
                          (
                          fontSize: 15,
                          color: Color(0xFF00FFBF),
                          fontFamily: 'NotoSans',
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      :
                      IconButton
                      (
                        icon: Icon(Icons.add),
                        color: Colors.white,
                        onPressed: ()
                        {
                          switch (_type)
                          {
                            case AccountInfoSubPageType.PHONENUMBER_INPUT:
                              Get.to(() => PhoneConfirmPage());
                              return;
                            case AccountInfoSubPageType.SEX:
                              setState(() {
                                visibleUI = AccountInfoSubPageType.SEX;
                              });
                              break;
                            case AccountInfoSubPageType.BIRTH_DAY:
                              setState(() {
                                visibleUI = AccountInfoSubPageType.BIRTH_DAY;
                              });
                              break;
                            case AccountInfoSubPageType.COUNTRY:
                              setState(() {
                                visibleUI = AccountInfoSubPageType.COUNTRY;
                              });
                            default:
                              print('Not found page type : ${_type}');
                              break;
                          }

                          print('click type : $_type');

                          setState(() {
                            isPopupOpen = true;
                            tweenController.forward(from: 0);
                          });
                        },
                      );
                  },),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
  bool isPopupOpen = false;
  Widget menuSelectPopup()
  {
    return
    IgnorePointer
    (
      ignoring: isPopupOpen == false,
      child:
      FadeTransition
      (
        opacity: tweenController,
        child:
        GestureDetector
        (
          onTap: ()
          {
            setState(() {
              isPopupOpen = false;
              tweenController.reverse();
            });
          },
          child:
          Container
          (
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black54,
            alignment: Alignment.center,
          ),
        )
      ),
    );
  }

  Widget selectGender(AccountInfoSubPageType _type)
  {
    return
      Visibility
      (
        visible: _type ==  AccountInfoSubPageType.SEX && visibleUI == AccountInfoSubPageType.SEX,
        child:
        Container
          (
          padding: EdgeInsets.only(top: 8),
          height: 40,
          //width: 200,
          child:
          Row
            (
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children:
            [
              GestureDetector
                (
                child: Container
                  (
                  alignment: Alignment.center,
                  width: 75,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: Color(0xFF2E2E2E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child:
                  Text
                    (
                    StringTable().Table![400058]!,
                    style:
                    const TextStyle(fontSize: 15, color: Color(0xFF00FFBF), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                  ),
                ),
                onTap: ()
                {
                  print('gender select M');
                  //gender 전달.
                },
              ),
              SizedBox(width: 20,),
              GestureDetector
                (
                child:
                Container
                  (
                  alignment: Alignment.center,
                  width: 75,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: Color(0xFF2E2E2E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child:
                  Text
                    (
                    StringTable().Table![400059]!,
                    style:
                    const TextStyle(fontSize: 15, color: Color(0xFF00FFBF), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                  ),
                ),
                onTap: ()
                {
                  print('gender select F');
                  //gender 전달.
                },
              ),
              SizedBox(width: 20,),
            ],
          ) ,
          //color: Colors.yellow,
        ),
      );
  }

  Widget selectBirthDay(AccountInfoSubPageType _type)
  {
    return
      Visibility
      (
        visible: _type ==  AccountInfoSubPageType.BIRTH_DAY && visibleUI == AccountInfoSubPageType.BIRTH_DAY,
        child:
        Container
          (
          padding: EdgeInsets.only(top: 8),
          height: 40,
          //width: 200,
          child:
          Row
          (
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children:
            [
              // GestureDetector
              // (
              //   child:
                Container
                (
                  alignment: Alignment.center,
                  width: 75,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: Color(0xFF2E2E2E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child:
                  DropButton(),
                  // Text
                  //   (
                  //   StringTable().Table![400058]!,
                  //   style:
                  //   const TextStyle(fontSize: 15, color: Color(0xFF00FFBF), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                  // ),
                ),
              //   onTap: ()
              //   {
              //     print('gender select M');
              //     //gender 전달.
              //   },
              // ),
              SizedBox(width: 20,),
              GestureDetector
              (
                child:
                Container
                  (
                  alignment: Alignment.center,
                  width: 75,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: Color(0xFF2E2E2E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child:
                  Text
                    (
                    StringTable().Table![400059]!,
                    style:
                    const TextStyle(fontSize: 15, color: Color(0xFF00FFBF), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                  ),
                ),
                onTap: ()
                {
                  print('gender select F');
                  //gender 전달.
                },
              ),
              SizedBox(width: 20,),
              GestureDetector
                (
                child: Container
                  (
                  alignment: Alignment.center,
                  width: 75,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: Color(0xFF2E2E2E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child:
                  Text
                    (
                    StringTable().Table![400058]!,
                    style:
                    const TextStyle(fontSize: 15, color: Color(0xFF00FFBF), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                  ),
                ),
                onTap: ()
                {
                  print('gender select M');
                  //gender 전달.
                },
              ),
              SizedBox(width: 20,),
              GestureDetector
              (
                child: Container
                (
                  alignment: Alignment.center,
                  width: 75,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: Color(0xFF00FFBF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child:
                  Text
                  (
                    StringTable().Table![800017]!,
                    style:
                    const TextStyle(fontSize: 15, color: Colors.black, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                  ),
                ),
                onTap: ()
                {
                  print('gender select M');
                  //gender 전달.
                },
              ),
              SizedBox(width: 30,),
            ],
          ) ,
          //color: Colors.yellow,
        ),
      );
  }

  Widget DropButton()
  {
    return
    Container
    (
      width: 300.w,
      height: 300.h,
      alignment: Alignment.center,
      child:
      CarouselSlider.builder
      (
        itemCount: pagelist.length,
        itemBuilder: (context, index, realIndex)
        {
          return
          Text
          (
            pagelist[index],
            style:
            TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
          );
        },
        //items: pagelist,
        options:
        CarouselOptions
        (
          // autoPlayInterval: Duration(milliseconds: 1000),
          // autoPlayAnimationDuration : Duration(milliseconds: 1010),
          // autoPlayCurve: Curves.linear,
          enlargeFactor: 1,
          enlargeCenterPage: false,
          viewportFraction:1,
          height: 50,
          //: true,
          //aspectRatio: 1.0,
          scrollDirection: Axis.vertical,
          enableInfiniteScroll: false,
          initialPage: 0,
          onPageChanged: (index, reason)
          {

          },
        ),
      ),
    );
  }
}
