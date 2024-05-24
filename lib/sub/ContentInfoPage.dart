import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
  var episodeGroupList = <String>[];
  List<bool> episodeGroupSelections = <bool>[];
  late Map<int, List<EpisodeContentData>> mapEpisodeContentsData = {};
  List<EpisodeContentData> episodeContentsList = <EpisodeContentData>[];



  @override
  void initState()
  {
    super.initState();

    episodeGroupList.add('1~20화');
    episodeGroupList.add('21~40화');
    episodeGroupList.add('41~60화');
    episodeGroupList.add('41~60화');
    episodeGroupList.add('41~60화');
    episodeGroupList.add('41~60화');
    episodeGroupList.add('41~60화');
    episodeGroupList.add('41~60화');
    episodeGroupList.add('41~60화');

    var data1 = EpisodeContentData();
    data1.path = '';
    data1.open = true;
    episodeContentsList.add(data1);
    episodeContentsList.add(data1);
    episodeContentsList.add(data1);
    episodeContentsList.add(data1);
    episodeContentsList.add(data1);
    episodeContentsList.add(data1);
    episodeContentsList.add(data1);
    episodeContentsList.add(data1);
    episodeContentsList.add(data1);
    episodeContentsList.add(data1);

    mapEpisodeContentsData[0] = episodeContentsList;

    episodeGroupSelections = List.generate(episodeGroupList.length, (_) => false);

    setState(()
    {
      _selections[0] = true;
      episodeGroupSelections[0] = true;
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
                Visibility
                (
                  visible: _selections[1],
                  child:
                  Column
                  (
                    children:
                    [
                      CommantWidget
                      (
                        0,'', SetTableStringArgument(100022, ['11']),'홍길동',
                        '24.05.09',
                        true,
                        '뭐라도 적겠지',
                            (index)
                        {
                          print(index);
                        },
                      ),
                      CommantWidget
                      (
                        1,'', SetTableStringArgument(100022, ['11']),'홍길동',
                        '24.05.09',
                        false,
                        '뭐라도 적겠지',
                            (index)
                        {
                          print(index);
                        },
                      ),
                    ],
                  ),

                ),
                    episodeInfo(),
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
                      //TODO Server work Like
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
                    print('to do share');
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
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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

  Widget episodeInfo() =>
  Visibility
  (
    visible: _selections[0],
    child:
    Container
    (
      width: 390,
      child:
      Column
      (
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        [
          Container
          (
            width: 390,
            height: 26,
            //color: Colors.green,
            child:
            SingleChildScrollView
            (
              scrollDirection: Axis.horizontal,
              child:
              ToggleButtons
              (
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                fillColor: Colors.transparent,
                //focusColor: Colors.red,
                //borderColor: Colors.red,
                //disabledColor: Colors.red,
                renderBorder: false,
                selectedBorderColor: Colors.transparent,
                color: Colors.white.withOpacity(0.6),
                selectedColor: Colors.white,
                children: <Widget>
                [
                  for(int i = 0 ; i < episodeGroupList.length; ++i)
                    episodeGroup(episodeGroupList[i], episodeGroupSelections[i]),

                ],
                isSelected: episodeGroupSelections,
                onPressed: (int index)
                {
                  setState(()
                  {
                    for(int i = 0 ; i < episodeGroupSelections.length ; ++i)
                    {
                      episodeGroupSelections[i] = i == index;
                    }
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 20,),
          episodeWrap(),
        ],
      ),
    ),
  );


  Widget episodeGroup(String _title, bool _select) =>
  Padding
  (
    padding: const EdgeInsets.only(left: 5, right: 5),
    child: _select ?
    Container
    (
      width: 73,
      height: 26,
      decoration: ShapeDecoration
      (
        color: Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.50, color: Color(0xFF00FFBF)),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 2),
      child:
      Text
      (
        _title,
        style:
        TextStyle(fontSize: 11, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
      ),
    ) 
        :
    Container
    (
      width: 73,
      height: 26,
      decoration: ShapeDecoration
      (
        color: Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.50, color: Color(0xFF999999)),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 2),
      child:
      Text
      (
        _title,
        style:
        TextStyle(fontSize: 11, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
      ),
    ),
  );

  Widget episodeWrap()
  {
    var data = episodeGroupSelections.asMap().entries.firstWhere((element) => element.value);
    print(data.key);
    var index = data.key;

    if (!mapEpisodeContentsData.containsKey(data.key))
    {
      return Container();
    }

    var list = mapEpisodeContentsData[index];
    return
    Wrap
    (
    direction: Axis.horizontal,  // 가로 방향으로 배치
    children: <Widget>
    [
      for (var i = 0; i < list!.length; i++)
        Container
        (
          height: 137,
          width: 390 / 4,
          //color: Colors.grey,
          child:
          Column
          (
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
            [
              GestureDetector
              (
                onTap: ()
                {
                  print('click');
                },
                child:
                Stack
                (
                  children:
                  [
                    Container
                    (
                      width: 77,
                      height: 107,
                      color: Colors.yellow,
                    ),
                    Visibility
                    (
                      visible: list[i].open == false,
                      child:
                      Container
                      (
                        width: 77,
                        height: 107,
                        color: Colors.black.withOpacity(0.7),
                        child:
                        SizedBox
                          (
                          child:
                          SvgPicture.asset
                            (
                            'assets/images/pick/pick_lock.svg',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding
              (
                padding: const EdgeInsets.only(top: 5),
                child:
                Text
                (
                  SetTableStringArgument(100034, ['${i + 1}']),
                  style:
                  TextStyle(fontSize: 11, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                ),
              ),
            ],
          ),
          // 화면 너비의 1/4 크기로 설정
          //child: Image.network('이미지 URL', fit: BoxFit.cover,),  // '이미지 URL' 부분을 실제 이미지 URL로 교체해야 합니다.
        ),
      ],
    );
  }

}

class EpisodeContentData
{
  String? path;
  bool? open;
}
