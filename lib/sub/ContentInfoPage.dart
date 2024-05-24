import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shortplex/Util/ShortplexTools.dart';
import '../table/StringTable.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await StringTable().InitTable();
  runApp(ContentInfoPage());
}

class ContentInfoPage extends StatefulWidget
{
  const ContentInfoPage({super.key});

  @override
  State<ContentInfoPage> createState() => _ContentInfoPageState();
}

class _ContentInfoPageState extends State<ContentInfoPage>
{
  bool check = false;

  List<bool> _selections = List.generate(3, (_) => false);

  @override
  void initState() {
    super.initState();
    setState(() {
      _selections[0] = true;
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return mainWidget(context);
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
        ),
        child:
        SingleChildScrollView
        (
          child:
          Container
          (
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            padding: EdgeInsets.only(top: 60),
            child:
            Column
            (
              children:
              [
                top(),
                SizedBox(height: 20,),
                tabButtons(),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  Widget top() => Column
  (
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children:
    [
      Container
      (
        width: 390,
        height: 260,
        color: Colors.white,
      ),
      SizedBox(height: 20,),
      Container
      (
        width: 390,
        //color: Colors.white,
        child:
        Text
        (
          '황후마마가 돌아왔다.',
          style:
          TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
        ),
      ),
      SizedBox(height: 10,),
      Container
      (
        width: 390,
        //color: Colors.white,
        child:
        Text
        (
          SetStringArgument('{0}          {1}          {2}          {3}', ['24.09','총99화','시대물','TOP10']),
          style:
          TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
        ),
      ),
      SizedBox(height: 10,),
      Container
      (
        width: 390,
        //color: Colors.white,
        child:
        Text
        (
          'Content 내용이 들어갈 자리 \nContent 내용이 들어갈 자리\nContent 내용이 들어갈 자리 ',
          style:
          TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
        ),
      ),
      SizedBox(height: 10,),
      Container
      (
        width: 390,
        //color: Colors.white,
        child:
        Row
        (
          mainAxisAlignment: MainAxisAlignment.start,
          children:
          [
            Column
            (
              crossAxisAlignment: CrossAxisAlignment.center,
              children:
              [
                IconButton
                (
                  icon: check ? Icon(CupertinoIcons.heart_solid, size: 30, color: Colors.white,) :
                  Icon(CupertinoIcons.heart, size: 30, color: Colors.white, ),
                  onPressed: ()
                  {
                    setState(()
                    {
                      check = !check;
                    });
                  },
                ),
                Text
                (
                  StringTable().Table![100023]!,
                  style:
                  TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                ),
              ],
            ),
            SizedBox(width: 20,),
            Column
            (
              crossAxisAlignment: CrossAxisAlignment.center,
              children:
              [
                IconButton
                (
                  icon:
                  Icon(CupertinoIcons.share, size: 27, color: Colors.white,),
                  onPressed: ()
                  {
                    setState(()
                    {

                    });
                  },
                ),
                SizedBox(height: 3,),
                Text
                (
                  StringTable().Table![100024]!,
                  style:
                  TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  Widget tabButtons() =>
  Padding
  (
    padding: const EdgeInsets.only(left: 10),
    child:
    Container
    (
      width: 390,
      child:
      Align
      (
        alignment: Alignment.centerLeft,
        child:
        Stack
        (
          children:
          [
            Divider(height: 10, color: Colors.white38, indent: 10, endIndent: 10, thickness: 1,),
            selectedPoint(),
            ToggleButtons
            (
              fillColor: Colors.transparent,
              //focusColor: Colors.red,
              //borderColor: Colors.red,
              //disabledColor: Colors.red,
              borderColor: Colors.transparent,
              selectedBorderColor: Colors.transparent,
              color: Colors.white.withOpacity(0.6),
              selectedColor: Colors.white,
              children: <Widget>
              [
                Container
                (
                  alignment: Alignment.center,
                  width: 75,
                  child:
                  Text
                    (
                    StringTable().Table![100025]!,
                    style:
                    TextStyle(fontSize: 12, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                  ),
                ),
                Container
                (
                  alignment: Alignment.center,
                  width: 75,
                  child:
                  Text
                  (
                    StringTable().Table![100026]!,
                    style:
                    TextStyle(fontSize: 12, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                  ),
                ),
                Container
                (
                  alignment: Alignment.center,
                  width: 75,
                  child:
                  Text
                    (
                    StringTable().Table![100027]!,
                    style:
                    TextStyle(fontSize: 12, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                  ),
                ),
              ],
              isSelected: _selections,
              onPressed: (int index)
              {
                setState(()
                {
                  for(int i = 0 ; i < _selections.length ; ++i)
                  {
                    _selections[i] = i == index;
                  }
                });
              },
            ),
          ],
        )

      ),
    ),
  );
  Widget selectedPoint() =>
  Row
  (
    children:
    [
      Padding
      (
        padding: const EdgeInsets.only(left: 1.2),
        child:
        Container
        (
          //color: Colors.green,
          width: 75,
          child:
          Visibility
          (
            visible: _selections[0],
            child: Divider(height: 10, color: Color(0xFF00FFBF), thickness: 2,)
          ),
        ),
      ),
      Padding
      (
        padding: const EdgeInsets.only(left: 1.1),
        child:
        Container
        (
            width: 75,
            child:
            Visibility
              (
                visible: _selections[1],
                child: Divider(height: 10, color: Color(0xFF00FFBF), thickness: 2,)
            ),
        ),
      ),
      Padding
      (
        padding: const EdgeInsets.only(left: 1),
        child:
        Container
        (
          width: 75,
          child:
          Visibility
          (
              visible: _selections[2],
              child: Divider(height: 10, color: Color(0xFF00FFBF), thickness: 2,)
          ),
        ),
      ),
    ],
  );
}
