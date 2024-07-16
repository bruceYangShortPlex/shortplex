import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shortplex/Util/ShortplexTools.dart';
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
                  Divider(height: 10, color: Colors.white38, indent: 10, endIndent: 10, thickness: 1,),
                  numberConfirmTitle(),
                  numberInputField(),
                  getCertificationNumber(),
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
      padding: EdgeInsets.only(right: 280.w, top: 40),
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

  final FixedExtentScrollController controller = FixedExtentScrollController(initialItem: 0);
  List<String> codeList = ['+82', '+1', '+44', '+61', '+81'];
  String phoneNumber = ''; // 사용자가 입력한 전화번호를 저장할 변수
  String dropdownValue = '';
  String certificationNumber = '';

  @override
  void initState()
  {
    super.initState();
    dropdownValue = codeList[0];
  }

  Widget numberInputField() => Align
  (
    alignment: Alignment.topCenter,
    child:
    Padding
    (
      padding:
      EdgeInsets.only(top: 10, right: 20),
      child:
      Container
      (
        child: Row
        (
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
              codePicker(),
              numberInput(),
          ],
        ),
      ),
    ),
  );

  Widget codePicker() =>
      Container
      (
        //alignment: Alignment.center,
        //height: 50,
        width: 80,
        // decoration: BoxDecoration
        // (
        //     borderRadius: BorderRadius.circular(12),
        //     color: Colors.deepPurple
        // ),
        child:
        CupertinoPicker.builder
        (
            //backgroundColor: Colors.white,
            scrollController: controller,
            itemExtent: 44,
            childCount: codeList.length,
            onSelectedItemChanged: (index)
            {
              setState(()
              {
                dropdownValue = codeList[index];
                if (kDebugMode) {
                  print(dropdownValue);
                }
              });
            },
            itemBuilder: (context, index)
            {
              return
              Center
              (
                child:
                Text
                (
                  codeList[index],
                  style:
                  TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                ),
              );
            }
        ),
      );

  Widget numberInput() =>
      Container
      (
        alignment: Alignment.center,
        height: 80,
        width: 280.w,
        child:
        CupertinoTextField
        (
          cursorColor: Colors.white,
          keyboardType: TextInputType.phone,
          style: TextStyle(fontFamily: 'NotoSans', fontSize: 18, color: Colors.white),
          decoration:
          BoxDecoration
          (
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.withOpacity(0.2),
            border:
            Border.all
            (
              color: Colors.white,
              width: 0.5,
            ),
          ),
          onChanged: (value)
          {
            print('input value : $value');
            phoneNumber = value;
            // 여기서 value는 사용자가 입력한 전화번호입니다.
            //print('전화번호: $phoneNumber');
          },
        ),
      );

  Widget getCertificationNumber() => Align
  (
    alignment: Alignment.center,
    child:
    Padding
    (
      padding: const EdgeInsets.only(left: 210,),
      child:
      Container
      (
        alignment: Alignment.center,
        width: 142,
        height: 35,
        decoration: ShapeDecoration
        (
          color: Color(0xFF1E1E1E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child:
        GestureDetector
        (
          child: Text(StringTable().Table![400084]!,
            style:
            TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),),
          onTap: ()
          {
            if (phoneNumber.isEmpty)
            {
              ShowCustomSnackbar(StringTable().Table![400088]!, SnackPosition.BOTTOM);
              return;
            }

            var numberCheck = phoneNumber.isValidPhoneNumberFormat();
            if (numberCheck == false)
            {
              print('wrong number');
              return;
            }

            phoneNumber = phoneNumber.replaceAll('-', '');
            if (phoneNumber.length > 12)
            {
              print('error');
              return;
            }

            dropdownValue = dropdownValue.replaceAll('+', '');

            print('Send Number : ${dropdownValue} ${phoneNumber}');
          },
        ),
      ),
    ),
  );

  Widget setCertificationNumber() =>
      Padding(
        padding: const EdgeInsets.only(right: 140),
        child:
        Container
        (
          alignment: Alignment.center,
          height: 80,
          width: 240,
          child:
          CupertinoTextField
          (
            cursorColor: Colors.white,
            keyboardType: TextInputType.number,
            style: TextStyle(fontFamily: 'NotoSans', fontSize: 18, color: Colors.white),
            decoration:
            BoxDecoration
            (
              borderRadius: BorderRadius.circular(8),
              color:Colors.grey.withOpacity(0.2),
              border:
              Border.all
              (
                color: Colors.white,
                width: 0.5,
              ),
            ),
            onChanged: (value)
            {
              certificationNumber = value;
            },
          ),
        ),
      );

  Widget checkNumber()
  {
    return
    Container
    (
      alignment: Alignment.center,
      width: 100,
      height: 40,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.50,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Color(0xFF494A4A),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child:
      GestureDetector
      (
        child:
        Text(StringTable().Table![400085]!,
          style:
          TextStyle(fontSize: 16,
            color: Colors.white,
            fontFamily: 'NotoSans',
            fontWeight: FontWeight.bold,),),
        onTap: ()
        {
          if (certificationNumber.isEmpty && phoneNumber.isNotEmpty)
          {
            ShowCustomSnackbar(StringTable().Table![400089]!, SnackPosition.BOTTOM);
            return;
          }

          if (certificationNumber.isEmpty || phoneNumber.isEmpty)
          {
            ShowCustomSnackbar(StringTable().Table![400088]!, SnackPosition.BOTTOM);
            return;
          }

          ShowCustomSnackbar(StringTable().Table![400085]!, SnackPosition.BOTTOM);
        },
      ),
    );
  }
}
