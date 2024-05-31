import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shortplex/Util/ShortplexTools.dart';
import 'package:shortplex/sub/CommentPage.dart';
import '../table/StringTable.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await StringTable().InitTable();
  runApp(ContentInfoPage());
}

enum CommentSortType
{
  LIKE,   //좋아요순.
  LATEST, //최신순.
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

  var _selections = List.generate(3, (_) => false);
  var episodeGroupList = <String>[];
  var episodeGroupSelections = <bool>[];
  late Map<int, List<EpisodeContentData>> mapEpisodeContentsData = {};
  var episodeContentsList = <EpisodeContentData>[];
  var episodeCommentList = <EpisodeCommentData>[];
  var scrollController = ScrollController();
  var totalCommentCount = 0;
  CommentSortType commentSortType = CommentSortType.LATEST;

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

    for(int i = 0; i < 10; ++i)
    {
      var commentData = EpisodeCommentData
      (
        name: '황후마마가 돌아왔다.',
        commant: '이건 재미있다. 무조건 된다고 생각한다.',
        date: '24.09.06',
        episodeNumber: '11',
        iconUrl: '',
        ID: i,
        isLikeCheck: i % 2 == 0,
        likeCount: '12',
        replyCount: '3',
        isOwner: i == 0,
        isBest: true,
      );
      episodeCommentList.add(commentData);
    }

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        onEndOfPage();
      }
    });

    setState(()
    {
      _selections[0] = true;
      episodeGroupSelections[0] = true;
    });
  }

  @override
  void dispose()
  {
    scrollController.dispose();
    _selections.clear();
    episodeGroupList.clear();
    episodeGroupSelections.clear();
    mapEpisodeContentsData.clear();
    episodeContentsList.clear();
    episodeCommentList.clear();
    super.dispose();
  }

  void onEndOfPage() async
  {
    if (!_selections[1])
      return;

    try
    {
      //여기서 리스트 요청하고 만들고 해야한다.
      // Replace with your method to fetch data from the server.
      final newItems = await Future.delayed(Duration(seconds: 1),
          ()
          {
            for(int i = 0; i < 10; ++i)
            {
              var commentData = EpisodeCommentData
              (
                name: '황후마마가 돌아왔다.',
                commant: '이건 재미있다. 무조건 된다고 생각한다.',
                date: '24.09.06',
                episodeNumber: '11',
                iconUrl: '',
                ID: i,
                isLikeCheck: i % 2 == 0,
                likeCount: '12',
                replyCount: '3',
                isOwner: i == 0,
                isBest: true,
              );
              episodeCommentList.add(commentData);

            }
            setState(()
            {

            });

          }
      );
    }
    catch (e)
    {
      print(e);
    }
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
          controller: scrollController,
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
                episodeInfo(),
                contentCommant(),
                SizedBox(height: 20,),
                contentEventAnnounce(),
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
    //어떤회차 그룹을 선택했는지 인덱스를 찾아온다. 1~20화 를 눌렀다면 0번이 true이므로 0번을 찾는다.
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
                  SetTableStringArgument(100033, ['${i + 1}']),
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

  Widget contentCommant() =>
  Visibility
  (
    visible: _selections[1],
    child:
    Column
    (
      children:
      [
        SizedBox
        (
          width: 390,
          child:
          Row
          (
            children:
            [
              Expanded
              (
                child:
                Container
                (
                  padding: EdgeInsets.only(left: 30, bottom: 1),
                  child: Text
                  (
                    '${StringTable().Table![100026]!} (${totalCommentCount})',
                    style:
                    TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                  ),
                ),
              ),
              GestureDetector
              (
                onTap: () {
                  setState(() {
                    commentSortType = CommentSortType.LIKE;
                  });
                },
                child: Container
                (
                  width: 73,
                  height: 26,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF1E1E1E),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.50, color: commentSortType == CommentSortType.LIKE ? const Color(0xFF00FFBF) : const Color(0xFF878787)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(bottom: 1),
                  child:
                  Text
                  (
                    StringTable().Table![100035]!,
                    style:
                    TextStyle(fontSize: 11, color: commentSortType == CommentSortType.LIKE ? Colors.white : const Color(0xFF878787), fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              GestureDetector
              (
                onTap: () {
                  setState(() {
                    commentSortType = CommentSortType.LATEST;
                  });
                },
                child: Container
                (
                  width: 73,
                  height: 26,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF1E1E1E),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.50, color: commentSortType == CommentSortType.LATEST ? Color(0xFF00FFBF) : Color(0xFF878787)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(bottom: 1),
                  child:
                  Text
                  (
                    StringTable().Table![100036]!,
                    style:
                    TextStyle(fontSize: 11, color: commentSortType == CommentSortType.LATEST ? Colors.white : const Color(0xFF878787), fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                  ),
                ),
              ),
              const SizedBox(width: 10,),
            ],
          ),
        ),
        SizedBox(height: 10,),
        for(int i = 0; i < episodeCommentList.length; ++i)
          CommentWidget
          (
            episodeCommentList[i].ID,
            episodeCommentList[i].iconUrl!,
            episodeCommentList[i].episodeNumber!,
            episodeCommentList[i].date!,
            episodeCommentList[i].name!,
            episodeCommentList[i].isLikeCheck!,
            episodeCommentList[i].commant!,
            episodeCommentList[i].likeCount!,
            episodeCommentList[i].replyCount!,
            episodeCommentList[i].isOwner!,
            episodeCommentList[i].isBest!,
            (id)
            {
              //TODO : 좋아요 버튼 처리
              print(id);
            },
                (id)
            {
              //TODO : 댓글의 답글 열기 버튼 처리
              Get.to(() => CommantPage(), arguments: episodeCommentList[i]);
            },
                (id)
            {
              //TODO : 삭제 버튼 처리
            },
          ),
      ],
    ),
  );

  Widget contentEventAnnounce([bool _active = true])
  {
    String title = _active ? StringTable().Table![800001]! : '안함';
    return
    Visibility
    (
      visible: _selections[2],
      child:
      SizedBox
      (
        width: 390,
        child:
        Column
        (
          mainAxisAlignment: MainAxisAlignment.start,
          children:
          [
            Row
            (
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                Icon(Icons.event, size: 26,),
                Padding
                (
                  padding: const EdgeInsets.only(right: 16),
                  child:
                  Text
                  (
                    title,
                    style:
                    TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                  ),
                ),
              ],
            ),
            Text
            (
              textAlign: TextAlign.center,
              SetTableStringArgument(800002, ['24.05.04', '24.06.03', '<황후마마가 돌아왔다>']),
              style:
              TextStyle(fontSize: 11, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
            ),
            SizedBox(height: 30,),
            Stack
            (
              alignment: Alignment.center,
              children:
              [
                Divider(height: 10, color: Colors.white.withOpacity(0.6), indent: 10, endIndent: 10, thickness: 1,),
                Container
                (
                  color: Colors.black,
                  padding: EdgeInsets.only(bottom: 3, left: 10, right: 10),
                  child:
                  Text
                  (
                    textAlign: TextAlign.center,
                    StringTable().Table![800003]!,
                    style:
                    TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Container
            (
              alignment: Alignment.centerLeft,
              color: Colors.black,
              padding: EdgeInsets.only(bottom: 3, left: 30, right: 10),
              child:
              Text
              (
                textAlign: TextAlign.start,
                StringTable().Table![800004]!,
                style:
                TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EpisodeContentData
{
  String? path;
  bool? open;
}

class EpisodeCommentData
{
  int ID = 0;
  String? iconUrl;
  String? episodeNumber;
  String? name;
  String? date;
  bool? isLikeCheck;
  String? commant;
  String? replyCount;
  String? likeCount;
  bool? isOwner;
  bool? isBest;

  EpisodeCommentData
  (
    {
      required this.ID,
      required this.iconUrl,
      required this.episodeNumber,
      required this.name,
      required this.date,
      required this.isLikeCheck,
      required this.commant,
      required this.replyCount,
      required this.likeCount,
      required this.isOwner,
      required this.isBest,
    }
  );
}
