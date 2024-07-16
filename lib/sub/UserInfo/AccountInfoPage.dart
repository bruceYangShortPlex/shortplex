import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_field/models/country_code_model.dart';
import 'package:intl_phone_number_field/models/dialog_config.dart';
import 'package:intl_phone_number_field/util/country_list.dart';
import 'package:intl_phone_number_field/view/country_code_bottom_sheet.dart';
import 'package:shortplex/sub/UserInfo/PhoneConfirmPage.dart';
import '../../Util/ShortplexTools.dart';
import '../../table/StringTable.dart';
import '../../table/UserData.dart';

enum AccountInfoSubPageType
{
  NONE,
  GENDER,
  BIRTH_DAY,
  COUNTRY,
  PHONENUMBER_INPUT,
}

enum GenderType
{
  NONE,
  F,
  M,
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
  //late AnimationController tweenController;

  @override
  void initState()
  {
    selected = CountryCodeModel
    (
        name: "Korea, Republic of South Korea", dial_code: "+82", code: "KR"
    );
    loadFromJson().then((value)
    {
      loadCountryData(value);
    },);

    super.initState();
    accountInfoCountCheck();

    // tweenController = AnimationController
    // (
    //   duration: const Duration(milliseconds: 300),
    //   vsync: this,
    // );
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
   // tweenController.dispose();
    textEditingController1.dispose();
    textEditingController2.dispose();
    textEditingController3.dispose();
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
          resizeToAvoidBottomInset: false,
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
            Padding
            (
              padding: const EdgeInsets.only(top: 80),
              child:
              Column
              (
                children:
                [
                  _option(400049, AccountInfoSubPageType.GENDER),
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
                        case AccountInfoSubPageType.GENDER:
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
                            case AccountInfoSubPageType.GENDER:
                              break;
                            case AccountInfoSubPageType.BIRTH_DAY:
                              break;
                            case AccountInfoSubPageType.COUNTRY:
                            default:
                              print('Not found page type : ${_type}');
                              break;
                          }
                          menuSelectPopup(_type);
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

  List<CountryCodeModel>? countries;
  late CountryCodeModel selected;
  var dialogConfig = DialogConfig();
  Future menuSelectPopup(AccountInfoSubPageType _type)
  {
    gender = GenderType.NONE;
    return
    showModalBottomSheet
    (
      shape:
      const RoundedRectangleBorder
      (
        borderRadius:
        BorderRadius.vertical
        (
          top: Radius.circular(30)
        )
      ),
      barrierColor: Colors.black54,
      isScrollControlled: true,
      backgroundColor:
      const Color(0xFF1B1B1B),
      context: context,
      builder: (context)
      {
        return
        _type == AccountInfoSubPageType.COUNTRY ? countrySelect()
            :
        _type == AccountInfoSubPageType.GENDER ? genderSelect ()
            :
        _type == AccountInfoSubPageType.BIRTH_DAY ? inputBirthDay()
            :
        SizedBox();
      }
    );
  }

  int year = 0;
  int month = 0;
  int day = 0;
  DateTime? birtyDay;
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  TextEditingController textEditingController3 = TextEditingController();
  var snackbarComplete = true;
  Widget inputBirthDay()
  {
    return
      StatefulBuilder
      (
          builder: (BuildContext context, StateSetter setState)
          {
            return
              Container
              (
                padding: EdgeInsets.only(top: 50),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.8,
                //color: Colors.transparent,
                child:
                Column
                (
                  children:
                  [
                    Container
                    (
                      width:MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(left: 36.w),
                      //color: Colors.white,
                      height: 40,
                      child:
                      Text
                      (
                        StringTable().Table![400049]!,
                        style:
                        TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                      ),
                    ),
                    //SizedBox(height: 10,),
                    Container
                    (
                        width: 310.w,//MediaQuery.of(context).size.width,
                        height: 45,
                        child:
                        Row
                        (
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:
                          [
                            Container
                            (
                              alignment: Alignment.center,
                              height : 45,
                              width : 120,
                              child:
                              CupertinoTextField
                              (
                                controller: textEditingController1,
                                placeholder: 'YYYY',
                                textAlign: TextAlign.center,
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontFamily: 'NotoSans', fontSize: 20, color: Colors.white),
                                decoration:
                                BoxDecoration
                                (
                                  borderRadius: BorderRadius.circular(8),
                                  color:Color(0xFF2E2E2E),
                                ),
                                onEditingComplete: ()
                                {
                                  if (year < 1900 || year >= DateTime.now().year)
                                  {
                                    ShowCustomSnackbar('잘못됫 입력(테이블아님)', SnackPosition.TOP);
                                    textEditingController1.text = '';
                                    year = 0;
                                  }

                                  print('year onEditingComplete');
                                  FocusScope.of(context).unfocus();
                                },
                                onChanged: (value)
                                {
                                  if (int.tryParse(value) != null)
                                  {
                                    year = int.parse(value);
                                  }
                                },
                              ),
                            ),
                            Container
                            (
                              alignment: Alignment.center,
                              height : 45,
                              width : 80,
                              child:
                              CupertinoTextField
                              (
                                controller: textEditingController2,
                                placeholder: 'MM',
                                textAlign: TextAlign.center,
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontFamily: 'NotoSans', fontSize: 20, color: Colors.white),
                                decoration:
                                BoxDecoration
                                (
                                  borderRadius: BorderRadius.circular(8),
                                  color:Color(0xFF2E2E2E),
                                ),
                                onEditingComplete: ()
                                {
                                  if (month < 1 || month > 12)
                                  {
                                    ShowCustomSnackbar('잘못됫 입력(테이블아님)', SnackPosition.TOP);
                                    textEditingController2.text = '';
                                    month = 0;
                                  }
                                  print('year onEditingComplete');
                                  FocusScope.of(context).unfocus();
                                },
                                onChanged: (value)
                                {
                                  if (int.tryParse(value) != null)
                                  {
                                    month = int.parse(value);
                                  }
                                },
                              ),
                            ),
                            Container
                            (
                              alignment: Alignment.center,
                              height : 45,
                              width : 80,
                              child:
                              CupertinoTextField
                              (
                                controller: textEditingController3,
                                placeholder: 'DD',
                                textAlign: TextAlign.center,
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontFamily: 'NotoSans', fontSize: 20, color: Colors.white),
                                decoration:
                                BoxDecoration
                                  (
                                  borderRadius: BorderRadius.circular(8),
                                  color:Color(0xFF2E2E2E),
                                ),
                                onEditingComplete: ()
                                {
                                  if (day < 1 || day > 31)
                                  {
                                    ShowCustomSnackbar('잘못됫 입력(테이블아님)', SnackPosition.TOP);
                                    textEditingController3.text = '';
                                    day = 0;
                                  }
                                  print('year onEditingComplete');
                                  FocusScope.of(context).unfocus();
                                },
                                onChanged: (value)
                                {
                                  if (int.tryParse(value) != null)
                                  {
                                    day = int.parse(value);
                                  }
                                },
                              ),
                            )
                          ],
                        )
                    ),
                    SizedBox(height: 30,),
                    GestureDetector
                    (
                      onTap: ()
                      {
                        if (snackbarComplete == false) {
                          return;
                        }

                        try {
                          birtyDay = DateTime(year, month, day);
                        } catch (e) {
                          print('유효하지 않은 날짜입니다.');
                          return;
                        }

                        if (birtyDay!.year == year && birtyDay!.month == month && birtyDay!.day == day)
                        {
                          //서버에 보내고 확인.
                          Navigator.pop(context);
                        }
                        else
                        {
                          snackbarComplete = false;
                          ShowCustomSnackbar('잘못됫 입력(테이블아님)', SnackPosition.TOP,
                          ()
                          {
                            snackbarComplete = true;
                          });
                        }
                      },
                      child:
                      Container
                      (
                        alignment: Alignment.center,
                        height: 45,
                        width: 310.w,
                        decoration: BoxDecoration(
                          color: Color(0xFF00FFBF),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child:
                        Text
                          (
                          StringTable().Table![800017]!,
                          style:
                          TextStyle(fontSize: 19,  color: Colors.black, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                        ),
                      ),
                    ),
                  ],
                ),
              );
          }
      );
  }

  var gender = GenderType.NONE;
  Widget genderSelect()
  {
    return
    StatefulBuilder
    (
      builder: (BuildContext context, StateSetter setState)
      {
        return
        Container
        (
          padding: EdgeInsets.only(top: 50),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.8,
          //color: Colors.transparent,
          child:
          Column
          (
            children:
            [
              Container
              (
                width:MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 36.w),
                //color: Colors.white,
                height: 40,
                child:
                Text
                  (
                  StringTable().Table![400049]!,
                  style:
                  TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                ),
              ),
              //SizedBox(height: 10,),
              Container
              (
                  width: 310.w,//MediaQuery.of(context).size.width,
                  height: 45,
                  child:
                  Row
                  (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                    [
                      GestureDetector
                      (
                        onTap : ()
                        {
                          setState(() {
                            gender = GenderType.F;
                          });
                        },
                        child:
                        Container
                        (
                          alignment: Alignment.center,
                          height: 45,
                          width: 140,
                          decoration: BoxDecoration(
                            color: gender == GenderType.F ? Color(0xFF00FFBF) : Color(0xFF2E2E2E),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child:
                          Text
                            (
                            StringTable().Table![400058]!,
                            style:
                            TextStyle(fontSize: 20,  color: gender == GenderType.F ? Colors.black : Color(0xFF00FFBF), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                          ),
                        ),
                      ),
                      //SizedBox(width: 20,),
                      GestureDetector
                      (
                        onTap: ()
                        {
                          setState(() {
                            gender = GenderType.M;
                          });
                        },
                        child: Container
                        (
                          alignment: Alignment.center,
                          height: 45,
                          width: 140,
                          decoration: BoxDecoration(
                            color: gender == GenderType.M ? Color(0xFF00FFBF) : Color(0xFF2E2E2E),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child:
                          Text
                            (
                            StringTable().Table![400059]!,
                            style:
                            TextStyle(fontSize: 20, color: gender == GenderType.M ? Colors.black : Color(0xFF00FFBF), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              SizedBox(height: 30,),
              GestureDetector
              (
                onTap: ()
                {
                  Navigator.pop(context);
                  //서버에 보내고 확인.
                },
                child:
                Container
                (
                  alignment: Alignment.center,
                  height: 45,
                  width: 310.w,
                  decoration: BoxDecoration(
                    color: gender != GenderType.NONE ? Color(0xFF00FFBF) : Color(0xFF2E2E2E),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child:
                  Text
                  (
                    StringTable().Table![800017]!,
                    style:
                    TextStyle(fontSize: 19,  color: gender != GenderType.NONE ? Colors.black : Color(0xFF00FFBF), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  Widget countrySelect()
  {
    return
    countries != null ?
    SingleChildScrollView
    (
      child:
      CountryCodeBottomSheet
      (
        countries: countries!,
        selected: selected,
        onSelected: (countryCodeModel)
        {
          setState(()
          {
            selected = countryCodeModel;
          });
        },
        dialogConfig: dialogConfig,
      ),
    )
    : const SizedBox();
  }

  Future<String> loadFromJson() async
  {
    return await rootBundle.loadString('assets/countries/country_list_en.json');
  }

  void loadCountryData(String data)
  {
    print('loadCountryData');
    Iterable jsonResult = json.decode(data);
    countries = List<CountryCodeModel>.from(jsonResult.map((model) {
      try
      {
        return CountryCodeModel.fromJson(model);
      }
      catch (e, stackTrace)
      {
        print(e);
        print(stackTrace);
      }
    }));
    setState(() {});
  }

  Widget selectGender(AccountInfoSubPageType _type)
  {
    return
    Container();
  }
}
