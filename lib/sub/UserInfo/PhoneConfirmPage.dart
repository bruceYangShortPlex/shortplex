import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_field/models/country_code_model.dart';
import 'package:intl_phone_number_field/models/dialog_config.dart';
import 'package:intl_phone_number_field/view/country_code_bottom_sheet.dart';
import 'package:shortplex/Util/HttpProtocolManager.dart';
import 'package:shortplex/Util/ShortplexTools.dart';
import 'package:shortplex/table/UserData.dart';
import '../../table/StringTable.dart';

// void main() async
// {
//   WidgetsFlutterBinding.ensureInitialized();
//   await StringTable().InitTable();
//
//   runApp(const PhoneConfirmPage());
// }

class PhoneConfirmPage extends StatefulWidget {
  const PhoneConfirmPage({super.key});

  @override
  State<PhoneConfirmPage> createState() => _PhoneConfirmPageState();

}

class _PhoneConfirmPageState extends State<PhoneConfirmPage>
{
  String phoneNumber = ''; // 사용자가 입력한 전화번호를 저장할 변수
  String hpCountryCode = '';
  String certificationNumber = '';

  String certificationPhoneNumber = ''; // 사용자가 입력한 전화번호를 저장할 변수
  String certificationCountryCode = '';

  bool buttonDisable = false;

  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();

  @override
  void initState()
  {
    countries = Get.arguments;
    selected = CountryCodeModel
    (
        name: "Korea, Republic of South Korea", dial_code: "+82", code: "KR"
    );
    super.initState();
  }

  @override
  void dispose() {
    textEditingController1.dispose();
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
                    StringTable().Table![400052]!,
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
                  Divider(height: 10, color: Colors.grey, indent: 10, endIndent: 10, thickness: 1,),
                  numberConfirmTitle(),
                  SizedBox(height: 20,),
                  numberInput(),
                  SizedBox(height: 20,),
                  getCertificationNumber(),
                  certificationTitle(),
                  setCertificationNumber(),
                  checkNumber(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget numberConfirmTitle() => Align
  (
    alignment: Alignment.center,
    child:
    Padding
    (
      padding: EdgeInsets.only(right: 210.w, top: 40),
      child: SizedBox
      (
      width: 89,
      height: 17,
      child:
      Text
      (
        StringTable().Table![400052]!,
        style:
        TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),),

      ),
    ),
  );

  bool snackbarComplete = true;
  Widget numberInput()
  {
    return
    Container
    (
      height: 40,
      width: 320,
      decoration:
      ShapeDecoration
      (
        color: Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      ),
      child:
      Row
      (
        mainAxisAlignment: MainAxisAlignment.center,
         children:
         [
           GestureDetector
           (
             onTap: ()
             {
               countrySelectPopup();
             },
             child:
             Container
             (
               width: 70,
               height: 40,
               //color: Colors.red,
               alignment: Alignment.center,
               child:
               Text
               (
                 selected.dial_code,
                 style:
                 TextStyle(fontSize: 18, color: Color(0xFF00FFBF), fontFamily: 'NotoSans', fontWeight: FontWeight.w500,),
               ),
             ),
           ),
           Container
           (
             alignment: Alignment.center,
             height: 60,
             width: 240,
             padding: EdgeInsets.zero,
             child:
             CupertinoTextField
             (
               readOnly : buttonDisable,
               maxLength: 12,
               controller: textEditingController1,
               cursorColor: Colors.white,
               keyboardType: TextInputType.number,
               style: TextStyle(
                   fontFamily: 'NotoSans', fontSize: 18, color: Colors.white),
               decoration:
               BoxDecoration
               (
                 borderRadius: BorderRadius.circular(8),
                 color: Colors.transparent,
                 // border:
                 // Border.all
                 // (
                 //   color: Colors.white,
                 //   width: 0.5,
                 // ),
               ),
               onEditingComplete: ()
               {
                 phoneNumber = textEditingController1.text;

                 if (phoneNumber.length > 12)
                 {
                   if (snackbarComplete)
                   {
                     snackbarComplete = false;
                     ShowCustomSnackbar(StringTable().Table![400088]!, SnackPosition.TOP, ()
                     {
                       snackbarComplete = true;
                     });
                   }
                   return;
                 }

                 FocusScope.of(context).unfocus();
               },
               onChanged: (value)
               {
                 if (int.tryParse(value) == null || value[value.length -1] == ' ')
                 {
                   textEditingController1.text = textEditingController1.text.replaceAll(value[value.length -1], '');
                 }

                 phoneNumber = textEditingController1.text;
                 // 여기서 value는 사용자가 입력한 전화번호입니다.
                 //print('전화번호: $phoneNumber');
               },
             ),
           ),
         ],
      )

    );
  }

  Widget certificationTitle() => Align
  (
    alignment: Alignment.center,
    child:
    Padding
      (
      padding: EdgeInsets.only(right: 210.w, top: 10),
      child: SizedBox
      (
        width: 89,
        height: 17,
        child:
        Text
          (
          StringTable().Table![400083]!,
          style:
          TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),),

      ),
    ),
  );

  Widget getCertificationNumber() => Align
  (
    alignment: Alignment.center,
    child:
    Padding
    (
      padding: EdgeInsets.only(left: 170.w,),
      child:
      GestureDetector
      (
        onTap: buttonDisable ? null : ()
        {
          FocusScope.of(context).unfocus();

          setState(() {
            buttonDisable = true;
          });

          if (phoneNumber.isEmpty)
          {
            ShowCustomSnackbar(StringTable().Table![400088]!, SnackPosition.TOP, ()
            {
                setState(() {
                  buttonDisable = false;
                });
            });
            return;
          }

          // var numberCheck = phoneNumber.isValidPhoneNumberFormat();
          // if (numberCheck == false)
          // {
          //   buttonDisable = true;
          //   ShowCustomSnackbar(StringTable().Table![400088]!, SnackPosition.TOP,()
          //   {
          //     buttonDisable = false;
          //   });
          //   print('wrong number');
          //   return;
          // }

          phoneNumber = phoneNumber.replaceAll('-', '');
          if (phoneNumber.length > 12)
          {
            setState(()
            {
              buttonDisable = true;
            });
            ShowCustomSnackbar(StringTable().Table![400088]!, SnackPosition.TOP,()
            {
              setState(()
              {
                buttonDisable = false;
              });
            });
            return;
          }

          hpCountryCode = selected.dial_code.replaceAll('+', '');

          if (kDebugMode) {
            print('Send Number : ${hpCountryCode} ${phoneNumber}');
          }
          setState(()
          {
            buttonDisable = true;
          });
          //인증번호 받기 누름.
          HttpProtocolManager.to.Send_GetCertificationMessage(hpCountryCode, phoneNumber).then((value)
          {
            if (value != null)
            {
              for(var item in value.data!.items!)
              {
                if (item.userId == UserData.to.userId)
                {
                  certificationPhoneNumber = item.hpNumber;
                  certificationCountryCode = item.hpCountryCode;
                  break;
                }
              }

              if (certificationPhoneNumber != phoneNumber ||certificationCountryCode != hpCountryCode )
              {
                if (kDebugMode) {
                  print('send number / res number 가 맞지 않음');
                }
                setState(()
                {
                  buttonDisable = false;
                });
                return;
              }

              ShowCustomSnackbar(StringTable().Table![400086]!, SnackPosition.TOP, ()
              {
                setState(()
                {
                  buttonDisable = false;
                });
              });
            }
          },);
        },
        child:
        Container
        (
          alignment: Alignment.center,
          width: 142,
          height: 35,
          decoration: ShapeDecoration
          (
            color: Color(0xFF1E1E1E),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          ),
          child:
          Text
          (
            StringTable().Table![400084]!,
            style:
            TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
          ),
        ),
      ),
    ),
  );

  Widget setCertificationNumber() =>
      Padding(
        padding: EdgeInsets.only(right: 0),
        child:
        Container
        (
          alignment: Alignment.center,
          height: 80,
          width: 320,
          child:
          CupertinoTextField
          (
            readOnly: buttonDisable,
            maxLength: 6,
            controller: textEditingController2,
            textAlign: TextAlign.center,
            cursorColor: Colors.white,
            keyboardType: TextInputType.number,
            style: TextStyle(fontFamily: 'NotoSans', fontSize: 18, color: Colors.white),
            decoration:
            BoxDecoration
            (
              borderRadius: BorderRadius.circular(8),
              color:Color(0xFF1E1E1E),
            ),
            onChanged: (value)
            {
              certificationNumber = textEditingController2.text;
            },
          ),
        ),
      );

  Widget checkNumber()
  {
    return
    Padding
    (
      padding: EdgeInsets.only(left: 170.w),
      child:
      GestureDetector
      (
        onTap: buttonDisable ? null : ()
        {
          FocusScope.of(context).unfocus();

          setState(() {
            buttonDisable = true;
          });

          //print('send checkNumber');
          if (certificationNumber.isEmpty && phoneNumber.isNotEmpty)
          {
            ShowCustomSnackbar(StringTable().Table![400089]!, SnackPosition.TOP, ()
            {
              setState(() {
                buttonDisable = false;
              });
            });
            return;
          }

          if (certificationNumber.isEmpty || phoneNumber.isEmpty)
          {
            ShowCustomSnackbar(StringTable().Table![400088]!, SnackPosition.TOP, ()
            {
              setState(() {
                buttonDisable = false;
              });
            });
            return;
          }

          if (certificationPhoneNumber != phoneNumber ||certificationCountryCode != hpCountryCode )
          {
            if (kDebugMode) {
              print('검증받은 번호가 아님');
            }

            ShowCustomSnackbar(StringTable().Table![400090]!, SnackPosition.TOP, ()
            {
              setState(() {
                buttonDisable = false;
              });
            });
            return;
          }

          HttpProtocolManager.to.Send_CertificationNumber(certificationNumber).then((value)
          {
            //print('Receive checkNumber value : $value');
            if (value)
            {
              UserData.to.HP_CountryCode = hpCountryCode;
              UserData.to.HP_Number = phoneNumber;

              HttpProtocolManager.to.Send_UserInfo().then((value)
              {
                if (value != null)
                {
                  UserData.to.UpdateInfo(value);
                  ShowCustomSnackbar(StringTable().Table![400091]!, SnackPosition.TOP,
                  ()
                  {
                    setState(()
                    {
                      buttonDisable = false;
                    });
                  });
                }
                else
                {
                  ShowCustomSnackbar(StringTable().Table![400090]!, SnackPosition.TOP, ()
                  {
                    setState(()
                    {
                      buttonDisable = false;
                    });
                  });
                }
              },);
            }
          },);
        },
        child:
        Container
        (
          alignment: Alignment.center,
          width: 142,
          height: 35,
          decoration: ShapeDecoration
          (
            color: Color(0xFF1E1E1E),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          ),
          child:
          Text
          (
            StringTable().Table![400085]!,
            style:
            TextStyle(fontSize: 14,
              color: Colors.white,
              fontFamily: 'NotoSans',
              fontWeight: FontWeight.bold,),
          ),
        ),
      ),
    );
  }

  List<CountryCodeModel>? countries;
  late CountryCodeModel selected;
  var dialogConfig = DialogConfig();
  Future countrySelectPopup()
  {
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
            countrySelect();
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
}
