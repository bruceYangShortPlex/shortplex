import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shortplex/table/UserData.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => UserData());
  await UserData.to.LoadResolution();
  runApp(const TestWidget());
}

class TestWidget extends StatefulWidget
{
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget>
{
  var resolutinosMenu = ['1080P', '720P', '480P'];
  String selectedResolution = '720P';
  var selections = List.generate(3, (_) => false);

  @override
  void initState()
  {
    selections = List.generate(resolutinosMenu.length, (_) => false);
    selectedResolution = resolutinosMenu[UserData.to.selectResolution.index];
    selections[UserData.to.selectResolution.index] = true;
    setState(() {

    });

    super.initState();
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
                      //Get.back();
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
                    'TEST',
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
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child:
            Column
            (
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                ResolutionMenu(),
                SizedBox(height: 20,),
                RoundButton(),
              ],
            )

            //color: Colors.blue,

          ),
        ),
      ),
    );

  @override
  Widget build(BuildContext context) {
    return mainWidget(context);
  }

  Widget ResolutionMenu()
  {
    return
    Container
    (
      width: 106,
      height: 180,
      decoration: ShapeDecoration(
        color: Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child:
      Column
      (
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:
        [
          for(int i = 0 ; i < resolutinosMenu.length ; ++i)
            ResolutionSelectButton(resolutinosMenu[i], i, selections[i]),
        ],
      ),
    );
  }

  Widget ResolutionSelectButton(String _title, int _index, [bool _select = false])
  {
    return
    GestureDetector
    (
      onTap: ()
      {
        for (int i = 0 ; i < selections.length; ++i)
        {
          selections[i] = i == _index;
        }
        UserData.to.SaveResoluton(_index);
        setState(() {

        });
      },
      child:
      Container
      (
        alignment: Alignment.center,
        width: 75,
        height: 30,
        decoration:
        ShapeDecoration
        (
          color:Color(0xFF2E2E2E),
          shape: RoundedRectangleBorder(
          side: _select ? BorderSide(width: 1.50, color: Color(0xFF00FFBF)) : BorderSide(width: 0, color: Color(0xFF2E2E2E)),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child:
        Text
        (
          _title,
          style:
          const TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
        ),
      ),
    );
  }

  var isLoading = false;
  Widget RoundButton()
  {
    return
    GestureDetector
    (
      onTap: ()
      {
        print('open menu');
      },
      child:
      Container
      (
        padding: isLoading ? EdgeInsets.zero : const EdgeInsets.only(bottom: 2),
        alignment: Alignment.center,
        width: 69,
        height: 24,
        decoration: ShapeDecoration(
          color: Color(0xFF1E1E1E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child:
        isLoading ? Container( width: 15, height: 15, child: CircularProgressIndicator()) :
        Text
        (
          selectedResolution,
          style:
          TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
        ),
      ),
    );
  }
}
