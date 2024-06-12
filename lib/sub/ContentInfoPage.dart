import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shortplex/Util/HttpProtocolManager.dart';
import 'package:shortplex/Util/ShortplexTools.dart';
import 'package:shortplex/sub/ContentPlayer.dart';
import 'package:shortplex/sub/ReplyPage.dart';
import 'package:shortplex/table/UserData.dart';
import '../Network/Content_Res.dart';
import '../table/StringTable.dart';

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
  ContentRes? contentRes;
  ContentData? contentData;
  bool check = false;

  //회차 정보.
  var selections = List.generate(3, (_) => false);
  var episodeGroupList = <String>[];
  var episodeGroupSelections = <bool>[];
  late Map<int, List<Episode>> mapEpisodeData = {};

  //comment 관련
  var scrollController = ScrollController();
  var episodeCommentList = <EpisodeCommentData>[];
  var totalCommentCount = 0;
  CommentSortType commentSortType = CommentSortType.LATEST;

  void GetContentData() async
  {
    try
    {
      contentData = Get.arguments as ContentData;
      if (contentData == null)
      {
        return;
      }

      await HttpProtocolManager.to.get_ContentData(contentData!.id!).then((value)
      {
        contentRes = value;

        int totalEpisodeCount = contentRes!.data!.episode!.length;
        print('totalEpisodeCount = $totalEpisodeCount');
        int dividingNumber = 20;
        int groupCount = totalEpisodeCount ~/ dividingNumber;
        print('groupCount = $groupCount');
        for (int i = 0; i < groupCount; ++i)
        {
          var startString = i * dividingNumber + 1;
          var endString = i * dividingNumber + dividingNumber;
          episodeGroupList.add('${startString}~${SetTableStringArgument(100033, ['$endString'],)}');

          var episodeList = <Episode>[];
          for (int j = 0 ; j < dividingNumber; ++j)
          {
            var index = i * dividingNumber + j;
            if (index >= contentRes!.data!.episode!.length)
            {
              print('episode data length overflow');
              break;
            }
            var episodeData = contentRes!.data!.episode![index];
            episodeList.add(episodeData);
          }
          
          mapEpisodeData[i] = episodeList;
        }

        var remain = totalEpisodeCount % 20;
        if (remain != 0)
        {
          //print('remain : $remain');

          var startIndex = groupCount * dividingNumber + 1;
          var endIndex = groupCount * dividingNumber + remain;
          episodeGroupList.add('${startIndex}~${SetTableStringArgument(100033, ['$endIndex'],)}');

          var episodeList = <Episode>[];
          for(int i = startIndex; i <= endIndex; ++i)
          {
            if (i >= contentRes!.data!.episode!.length )
            {
              print('episode data length overflow');
              break;
            }

            var episodeData = contentRes!.data!.episode![i];
            episodeList.add(episodeData);
          }
          mapEpisodeData[groupCount] = episodeList;
        }

        episodeGroupSelections = List.generate(episodeGroupList.length, (_) => false);
        episodeGroupSelections[0] = true;

        setState(() {

        });
      });
    }
    catch(e)
    {
      print('GetContentData Catch $e');
    }
  }

  void GetCommentData() async
  {
    try
    {
      await HttpProtocolManager.to.get_CommentData(contentData!.id!).then((value)
      {
        var commentRes = value;
        totalCommentCount = commentRes!.data!.length;
        for(var item in commentRes.data!)
        {
          var commentData = EpisodeCommentData
          (
            name: 'GUEST ${item.id}',
            comment: item.content,
            date: item.createdAt != null ? ConvertCommentDate(item.createdAt!) : '',
            episodeNumber: '11',
            iconUrl: '',
            ID: item.id!,
            isLikeCheck: false,
            likeCount: '0',
            replyCount: '${item.replies!.length}',
            isOwner: false,
            commentType: CommentType.BEST,
          );

          episodeCommentList.add(commentData);
        }

        setState(() {

        });
      });
    }
    catch(e)
    {
      print('GetCommentData Catch $e');
    }
  }


  @override
  void initState()
  {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        onEndOfPage();
      }
    });

    GetContentData();
    GetCommentData();

    setState(()
    {
      selections[0] = true;
    });
  }

  @override
  void dispose()
  {
    scrollController.dispose();

    super.dispose();
  }

  void onEndOfPage() async
  {
    if (!selections[1]) {
      return;
    }

    try
    {

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
                contentComment(),
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
        color: Colors.blueGrey,
        child: contentData!.landScapeImageUrl == null || contentData!.landScapeImageUrl!.isEmpty ?
        SizedBox() : Image.network(contentData!.landScapeImageUrl!),
      ),
      SizedBox(height: 20,),
      Container
      (
        width: 390,
        //color: Colors.white,
        child:
        Text
        (
          contentData!.contentTitle!,
          style:
          TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
          children:
          [
            Visibility
            (
              visible: contentData?.GetReleaseDate() != '',
              child:
              Expanded
              (
                child:
                Text
                (
                  '${contentData?.GetReleaseDate()}',
                  style:
                  TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                ),
              ),
            ),
            Expanded
            (
              child: Text
              (
                contentRes != null ?  SetTableStringArgument(100022, ['${contentRes?.data?.episode?.length}']) : '',
                style:
                TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
              ),
            ),

            Expanded
            (
              flex: 2,
              child:
              Text
              (
                contentRes != null ? contentRes!.data!.genre! : '',
                style:
                TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
              ),
            ),
            Expanded
            (
              flex: 2,
              child:
              Text
              (
                contentData?.rank != 0 ? StringTable().Table![300037]! : '',
                style:
                TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
              ),
            ),
          ],
        )

      ),
      SizedBox(height: 10,),
      Container
      (
        width: 390,
        //color: Colors.white,
        child:
        Text
        (
          contentRes != null ? contentRes!.data!.description! : '',
          style:
          TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
                  TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
                  TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
                    TextStyle(fontSize: 12, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
                    TextStyle(fontSize: 12, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
                    TextStyle(fontSize: 12, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                  ),
                ),
              ],
              isSelected: selections,
              onPressed: (int index)
              {
                setState(()
                {
                  for(int i = 0 ; i < selections.length ; ++i)
                  {
                    selections[i] = i == index;
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
            visible: selections[0],
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
                visible: selections[1],
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
              visible: selections[2],
              child: Divider(height: 10, color: Color(0xFF00FFBF), thickness: 2,)
          ),
        ),
      ),
    ],
  );

  Widget episodeInfo()
  {
    return
    Visibility
    (
      visible: selections[0],
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
                  renderBorder: false,
                  selectedBorderColor: Colors.transparent,
                  color: Colors.white.withOpacity(0.6),
                  selectedColor: Colors.white,
                  children: <Widget>
                  [
                    for(int i = 0; i < episodeGroupList.length; ++i)
                      episodeGroup(episodeGroupList[i], episodeGroupSelections[i]),

                  ],
                  isSelected: episodeGroupSelections,
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < episodeGroupSelections.length; ++i) {
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
  }


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
        TextStyle(fontSize: 11, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
        TextStyle(fontSize: 11, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
      ),
    ),
  );

  Widget episodeWrap()
  {
    if (mapEpisodeData.length == 0)
    {
      return Container();
    }

    //어떤회차 그룹을 선택했는지 인덱스를 찾아온다. 1~20화 를 눌렀다면 0번이 true이므로 0번을 찾는다.
    var data = episodeGroupSelections.asMap().entries.firstWhere((element) => element.value);
    print(data.key);
    var index = data.key;

    if (!mapEpisodeData.containsKey(data.key))
    {
      return Container();
    }

    var list = mapEpisodeData[index];
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
                  if (list[i].isLock)
                  {
                    //TODO:구매안한 컨텐츠임둥.
                    print('is lock');

                    return;
                  }

                  Get.to(() => ContentPlayer(), arguments: [contentRes, i]);
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
                      color: Colors.blueGrey,
                      child: list[i].altImgUrl == null || list[i].altImgUrl!.isEmpty
                          ? SizedBox() : Image.network(list[i].altImgUrl!),
                    ),
                    Visibility
                    (
                      visible: list[i].isLock,
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
                  TextStyle(fontSize: 11, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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

  Widget contentComment() =>
  Visibility
  (
    visible: selections[1],
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
                    TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                  ),
                ),
              ),
              GestureDetector
              (
                onTap: ()
                {
                  setState(()
                  {
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
                    TextStyle(fontSize: 11, color: commentSortType == CommentSortType.LIKE ? Colors.white : const Color(0xFF878787), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              GestureDetector
              (
                onTap: ()
                {
                  setState(()
                  {
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
                    TextStyle(fontSize: 11, color: commentSortType == CommentSortType.LATEST ? Colors.white : const Color(0xFF878787), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
            episodeCommentList[i].name!,
            episodeCommentList[i].date!,
            episodeCommentList[i].isLikeCheck!,
            episodeCommentList[i].comment!,
            episodeCommentList[i].likeCount!,
            episodeCommentList[i].replyCount!,
            episodeCommentList[i].isOwner!,
            episodeCommentList[i].commentType!,
            false,
            (id)
            {
              //TODO : 좋아요 버튼 처리
              print(id);
            },
                (id)
            {
              //TODO : 댓글의 답글 열기 버튼 처리
              Get.to(() => ReplyPage(), arguments: episodeCommentList[i]);
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
      visible: selections[2],
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
                    TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                  ),
                ),
              ],
            ),
            Text
            (
              textAlign: TextAlign.center,
              SetTableStringArgument(800002, ['24.05.04', '24.06.03', '<황후마마가 돌아왔다>']),
              style:
              TextStyle(fontSize: 11, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
                    TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
                TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum CommentType
{
  NORMAL,
  BEST,
  TOP10,
}

class EpisodeCommentData
{
  String ID = '';
  String? iconUrl;
  String? episodeNumber;
  String? name;
  String? date;
  bool? isLikeCheck;
  String? comment;
  String? replyCount;
  String? likeCount;
  bool? isOwner;
  CommentType? commentType;

  EpisodeCommentData
  (
    {
      required this.ID,
      required this.iconUrl,
      required this.episodeNumber,
      required this.name,
      required this.date,
      required this.isLikeCheck,
      required this.comment,
      required this.replyCount,
      required this.likeCount,
      required this.isOwner,
      required this.commentType,
    }
  );
}
