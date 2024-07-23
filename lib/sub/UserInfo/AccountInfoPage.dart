import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_field/models/country_code_model.dart';
import 'package:intl_phone_number_field/models/dialog_config.dart';
import 'package:intl_phone_number_field/view/country_code_bottom_sheet.dart';
import 'package:shortplex/Util/HttpProtocolManager.dart';
import 'package:shortplex/sub/UserInfo/PhoneConfirmPage.dart';
import '../../Util/ShortplexTools.dart';
import '../../table/StringTable.dart';
import '../../table/UserData.dart';

enum AccountInfoSubPageType
{
  NONE,
  GENDER,
  BIRTHDAY,
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

  @override
  void initState()
  {
    countrySelected = CountryCodeModel
    (
        name: "Korea, Republic of South Korea", dial_code: "+82", code: "KR"
    );

    loadFromJson().then((value)
    {
      loadCountryData(value);

      if (UserData.to.Country.isNotEmpty)
      {
        for (var item in countries!)
        {
          if (item.code == '+${UserData.to.Country}')
          {
            countrySelected = item;
            break;
          }
        }
      }
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
    _infoCount = 0;
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
                  _option(400050, AccountInfoSubPageType.BIRTHDAY),
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
                          Obx(()
                          {
                            if (UserData.to.refreshCount.value != 0) {
                              accountInfoCountCheck();
                            }
                            return
                            Text
                            (
                              '${_infoCount} / 4',
                              style:
                              TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                            );
                          },)
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
        const Divider
        (
          height: 10,
          color: Colors.white38,
          indent: 10,
          endIndent: 10,
          thickness: 1,
        ),
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
                  padding: const EdgeInsets.only(left: 30),
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
                      const TextStyle
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
                    if (UserData.to.refreshCount.value > 0)
                    {
                      switch (_type)
                      {
                        case AccountInfoSubPageType.GENDER:
                          text = ConvertGenderToString(UserData.to.Gender);
                          break;
                        case AccountInfoSubPageType.PHONENUMBER_INPUT:
                          {
                            if (UserData.to.HP_CountryCode.isNotEmpty && UserData.to.HP_Number.isNotEmpty)
                            {
                              text = '+${UserData.to.HP_CountryCode} ${UserData.to.HP_Number}'; //UserData.to.CountryCode + UserData.to.HP_Number;
                            }
                          }
                          break;
                        case AccountInfoSubPageType.BIRTHDAY:
                          {
                            print('UserData.to.BirthDay : ${UserData.to.BirthDay}');

                            if (UserData.to.BirthDay.isNotEmpty) {
                              text = ConvertDateString(UserData.to.BirthDay);
                            }
                          }
                          break;
                        case AccountInfoSubPageType.COUNTRY:
                          {
                            if (UserData.to.Country.isNotEmpty)
                            {
                              text = countrySelected.name;
                            }
                          }
                          break;
                        default:
                          print('Not found page type : ${_type}');
                          break;
                      }
                    }
                    return
                      text.isNotEmpty ?
                      Container
                      (
                        alignment: Alignment.centerRight,
                        //color: Colors.yellow,
                        width: 240.w,
                        height: 48,
                        padding: EdgeInsets.only(right: 20),
                        child:
                        Text
                        (
                          textAlign: TextAlign.end,
                          text,
                          style:
                          const TextStyle
                          (
                            fontSize: 15,
                            color: Color(0xFF00FFBF),
                            fontFamily: 'NotoSans',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                      :
                      IconButton
                      (
                        icon: Icon(Icons.add),
                        color: Colors.white,
                        onPressed: buttonDisable? null :
                        ()
                        {
                          switch (_type)
                          {
                            case AccountInfoSubPageType.PHONENUMBER_INPUT:
                              Get.to(() => const PhoneConfirmPage(), arguments: countries);
                              return;
                            case AccountInfoSubPageType.GENDER:
                              break;
                            case AccountInfoSubPageType.BIRTHDAY:
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
  late CountryCodeModel countrySelected;
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
        _type == AccountInfoSubPageType.BIRTHDAY ? inputBirthDay()
            :
        SizedBox();
      }
    );
  }

  int year = 0;
  int month = 0;
  int day = 0;
  DateTime? birthday;
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
                            enabled: buttonDisable == false,
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
                                snackbarComplete = false;
                                ShowCustomSnackbar('잘못됫 입력(테이블아님)', SnackPosition.TOP, ()
                                {
                                  snackbarComplete = true;
                                });
                                textEditingController1.text = '';
                                year = 0;
                              }
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
                            enabled: buttonDisable == false,
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
                                snackbarComplete = false;
                                ShowCustomSnackbar('잘못됫 입력(테이블아님)', SnackPosition.TOP, ()
                                {
                                  snackbarComplete = true;
                                });
                                textEditingController2.text = '';
                                month = 0;
                              }
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
                            enabled: buttonDisable == false,
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
                                snackbarComplete = false;
                                ShowCustomSnackbar('잘못됫 입력(테이블아님)', SnackPosition.TOP,
                                ()
                                {
                                  snackbarComplete = true;
                                });
                                textEditingController3.text = '';
                                day = 0;
                              }
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
                      if (snackbarComplete == false || buttonDisable) {
                        return;
                      }

                      if (year == 0 || day == 0 || month == 0)
                      {
                        snackbarComplete = false;
                        ShowCustomSnackbar('잘못됫 입력(테이블아님)', SnackPosition.TOP,
                        ()
                        {
                          snackbarComplete = true;
                        });
                        return;
                      }

                      try
                      {
                        birthday = DateTime(year, month, day);
                      }
                      catch (e)
                      {
                        //print('유효하지 않은 날짜입니다.');
                        snackbarComplete = false;
                        ShowCustomSnackbar('잘못됫 입력(테이블아님)', SnackPosition.TOP,
                        ()
                        {
                          snackbarComplete = true;
                        });
                        return;
                      }

                      if (birthday!.year == year && birthday!.month == month && birthday!.day == day)
                      {
                        buttonDisable = true;
                        UserData.to.BirthDay = DateToString(birthday!).replaceAll('.', '-');
                        HttpProtocolManager.to.Send_UserInfo().then((value)
                        {
                          if (value == null)
                          {
                            UserData.to.BirthDay = '';
                          }

                          UserData.to.UpdateInfo(value);
                          Navigator.pop(context);
                          buttonDisable = false;
                        },);
                      }
                      else
                      {
                        if (kDebugMode) {
                          print(birthday);
                        }
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

  var buttonDisable = false;
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
                        if (buttonDisable) {
                          return;
                        }

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
                        if (buttonDisable) {
                          return;
                        }

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
                  if (buttonDisable || gender == GenderType.NONE) {
                    return;
                  }

                  buttonDisable = true;
                  //서버에 보내고 확인.
                  UserData.to.Gender = gender.name;

                  HttpProtocolManager.to.Send_UserInfo().then((value)
                  {
                    if (value == null)
                    {
                      gender = GenderType.NONE;
                      UserData.to.Gender = '';
                    }

                    UserData.to.UpdateInfo(value);

                    buttonDisable = false;
                    Navigator.pop(context);
                  },);
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
        selected: countrySelected,
        onSelected: (countryCodeModel)
        {
          UserData.to.Country = countryCodeModel.code.replaceAll('+', '');
          buttonDisable = true;
          HttpProtocolManager.to.Send_UserInfo().then((value)
          {
            if (value == null)
            {
              UserData.to.Country = '';
            }

            buttonDisable = false;
            UserData.to.UpdateInfo(value);
            setState(()
            {
              countrySelected = countryCodeModel;
            });
          },);
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
        if (kDebugMode) {
          print('country json load Error $e / stackTrace : $stackTrace');
        }
      }
    }));
    setState(() {});
  }
}
