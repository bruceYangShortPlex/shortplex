import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shortplex/Util/HttpProtocolManager.dart';
import 'package:shortplex/Util/ShortplexTools.dart';
import 'package:shortplex/sub/ContentPlayer.dart';
import 'package:shortplex/sub/ReplyPage.dart';
import 'package:shortplex/table/UserData.dart';
import '../Network/Content_Res.dart';
import '../table/StringTable.dart';
import 'UserInfo/LoginPage.dart';

enum CommentSortType
{
  likes,   //좋아요순.
  created_at, //최신순.
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
  bool buttonEnabled = true;

  //회차 정보.
  var selections = List.generate(3, (_) => false);
  var episodeGroupList = <String>[];
  var episodeGroupSelections = <bool>[];
  late Map<int, List<Episode>> mapEpisodeData = {};
  List<Episode> contentEpisodes = <Episode>[];

  bool prevLogin = false;

  //comment 관련
  var scrollController = ScrollController();
  var commentList = <EpisodeCommentData>[];
  var totalCommentCount = 0;
  CommentSortType commentSortType = CommentSortType.created_at;

  void GetContentData()
  {
    try
    {
      if (contentData == null)
      {
        print('ContentData is Null');
        return;
      }

      HttpProtocolManager.to.Get_ContentData(contentData!.id!).then((value)
      {
        contentRes = value;
        mapEpisodeData[0] = contentRes!.data!.episode!;
        contentEpisodes.addAll(contentRes!.data!.episode!);
        int totalEpisodeCount = contentRes!.data!.episodeTotal;
        //print('totalEpisodeCount : $totalEpisodeCount / total page : ${contentRes!.data!.episode_maxpage}');
        int dividingNumber = 20;
        int groupCount = contentRes!.data!.episodeMaxpage;
        //print('groupCount = $groupCount');
        for (int i = 0; i < groupCount; ++i)
        {
          var startString = i * dividingNumber + 1;
          var endString = i * dividingNumber + dividingNumber;
          episodeGroupList.add('${startString}~${SetTableStringArgument(100033, ['$endString'],)}');
        }

        var remain = totalEpisodeCount % 20;
        if (remain != 0)
        {
          var startIndex = groupCount * dividingNumber + 1;
          var endIndex = groupCount * dividingNumber + remain;
          episodeGroupList.add('${startIndex}~${SetTableStringArgument(100033, ['$endIndex'],)}');
        }

        episodeGroupSelections = List.generate(episodeGroupList.length, (_) => false);
        episodeGroupSelections[0] = true;

        setState(() {

        });

        for(int i = 1 ; i <= contentRes!.data!.episodeMaxpage; ++i)
        {
          HttpProtocolManager.to.Get_EpisodeGroup(contentData!.id!, i).then((value)
          {
            mapEpisodeData[i] = value!.data!.episode!;
            contentEpisodes.addAll(value.data!.episode!);
          });
        }
      });
    }
    catch(e)
    {
      print('GetContentData Catch $e');
    }
  }

  int downCompletePage = 0;
  int maxPage = 0;

  void GetCommentsData([bool _refresh = false])
  {
    if (_refresh)
    {
      for(int i = 0; i < downCompletePage; ++i)
      {
        GetCommentPage(i);
      }
    }
    else
    {
      if (downCompletePage > maxPage) {
        return;
      }

      GetCommentPage(downCompletePage).then((value) => downCompletePage++);
    }
  }

  Future GetCommentPage(int _downloadPage) async
  {
    try
    {
      await HttpProtocolManager.to.Get_Comments(contentData!.id!, _downloadPage, commentSortType.name).then((value)
      {
        var commentRes = value;
        totalCommentCount = commentRes!.data!.total;
        maxPage = commentRes.data!.maxPage;
        for(var item in commentRes.data!.items!)
        {
          if (commentList.any((element) => element.ID == item.id))
          {
            for(int i = 0; i < commentList.length; ++i)
            {
              if (commentList[i].ID == item.id)
              {
                commentList[i].name = item.displayname;
                commentList[i].comment = item.content;
                commentList[i].date = ConvertCommentDate(item.createdAt!);
                commentList[i].episodeNumber = item.episode_no.toString();
                commentList[i].iconUrl = item.photourl ?? '';
                commentList[i].isLikeCheck = item.whoami!.isNotEmpty && item.whoami == UserData.to.userId && item.ilike > 0;
                commentList[i].likeCount = item.likes ?? '0';
                commentList[i].replyCount = item.replies ?? '0';
                commentList[i].isDelete = false;
                commentList[i].commentType = item.rank > 0 && item.rank < 3 ? CommentType.BEST : CommentType.NORMAL;
                commentList[i].parentID = item.key!;
                commentList[i].isEdit = false;
                commentList[i].userID = item.userId;
                break;
              }
            }
            continue;
          }

          var commentData = EpisodeCommentData
          (
            name: item.displayname,
            comment: item.content,
            date: ConvertCommentDate(item.createdAt!),
            episodeNumber: item.episode_no.toString(),
            iconUrl: item.photourl ?? '',
            ID: item.id!,
            isLikeCheck: item.whoami!.isNotEmpty && item.whoami == UserData.to.userId && item.ilike > 0,
            likeCount: item.likes ?? '0',
            replyCount: item.replies ?? '0',
            isDelete: false,
            commentType: item.rank > 0 && item.rank < 3 ? CommentType.BEST : CommentType.NORMAL,
            parentID: item.key!,
            isEdit: false,
            userID: item.userId,
          );
          commentList.add(commentData);
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

  void GetFavorite()
  {
    if (UserData.to.isLogin.value == false)
    {
      UserData.to.isFavoriteCheck.value = false;
      return;
    }

    HttpProtocolManager.to.Get_Stat(contentData!.id!).then((value)
    {
      if (value == null || value.data == null || value.data!.isEmpty )
      {
        UserData.to.isFavoriteCheck.value = false;

        return;
      }

      for(var item in value.data!)
      {
        if (item.action == Stat_Type.favorite.name)
        {
          var amt = item.amt;
          UserData.to.isFavoriteCheck.value = amt > 0;

          print('item.amt ${item.amt} / check  : ${UserData.to.isFavoriteCheck.value}');
          return;
        }
      }
    });
  }

  @override
  void initState()
  {
    prevLogin = UserData.to.isLogin.value;

    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        onEndOfPage();
      }
    });

    contentData = Get.arguments;
    GetContentData();
    GetFavorite();
    //GetCommentsData();

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
    if (!selections[1])
    {
      return;
    }

    try
    {
      if (totalCommentCount > commentList.length)
      {
        print('Start GetCommentsData 222');
        GetCommentsData();
      }
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
                UserData.to.isOpenPopup.value = false;
                Get.back();
              },
            ),
          ),
        ),
        child:
        contentData == null ? SizedBox() :
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
        height: 220,
        //color: Colors.blueGrey,
        child:
        ClipRRect
        (
          borderRadius: BorderRadius.circular(7),
          child:
          contentData!.landScapeImageUrl == null || contentData!.landScapeImageUrl!.isEmpty ?
          SizedBox() : Image.network(contentData!.landScapeImageUrl!, fit: BoxFit.cover
            ,),
        ),
      ),
      SizedBox(height: 20,),
      Container
      (
        width: 390,
        //color: Colors.white,
        child:
        Text
        (
          contentData!.title!,
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
                  const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                ),
              ),
            ),
            Expanded
            (
              child:
              Text
              (
                contentRes != null ?  SetTableStringArgument(100022, ['${contentRes?.data?.episode?.length}']) : '',
                style:
                const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
              ),
            ),
            Expanded
            (
              flex: 1,
              child:
              Text
              (
                contentData!.rank ? StringTable().Table![300037]! : '',
                style:
                const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
              ),
            ),
            Expanded
            (
              flex: 2,
              child:
              Text
              (
                contentRes != null ? ConvertCodeToString(contentRes!.data!.genre!) : '',
                style:
                const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
          const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
                  icon:
                  Obx(()
                  {
                    return
                    UserData.to.isFavoriteCheck.value ? Icon(CupertinoIcons.heart_solid, size: 30, color: Colors.white,) :
                    Icon(CupertinoIcons.heart, size: 30, color: Colors.white, );
                  },),

                  onPressed: buttonEnabled ? ()
                  {
                    if (UserData.to.isLogin.value == false)
                    {
                      showDialogTwoButton(StringTable().Table![600018]!, '',
                      ()
                      {
                        Get.to(() => LoginPage());
                      });
                      return;
                    }

                    buttonEnabled = false;
                    int value = UserData.to.isFavoriteCheck.value ? -1 : 1;
                    HttpProtocolManager.to.Send_Stat(contentData!.id!, value, Stat_Type.favorite).then((value)
                    {
                      GetFavorite();
                      buttonEnabled = true;
                    });
                  } : null,
                ),
                Text
                (
                  StringTable().Table![100023]!,
                  style:
                  TextStyle(fontSize: 10, color: Colors.grey, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
    //print(data.key);
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

                  Get.to(() => ContentPlayer(), arguments: [list[i].no, contentEpisodes]);
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
                      //color: Colors.blueGrey,
                      child:
                      ClipRRect
                      (
                          borderRadius: BorderRadius.circular(7),
                          child:
                        list[i].thumbnailImgUrlSd == null || list[i].thumbnailImgUrlSd!.isEmpty
                        ? SizedBox() : Image.network(list[i].thumbnailImgUrlSd!, fit: BoxFit.cover,),
                      ),
                    ),
                    Visibility
                    (
                      visible: UserData.to.isSubscription.value == false && list[i].isLock,
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
                  SetTableStringArgument(100033, ['${list[i].no}']),
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

  Widget contentComment()
  {
    return
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
                        '${StringTable()
                            .Table![100026]!} (${totalCommentCount})',
                        style:
                        TextStyle(fontSize: 13,
                          color: Colors.white,
                          fontFamily: 'NotoSans',
                          fontWeight: FontWeight.bold,),
                      ),
                    ),
                  ),
                  GestureDetector
                    (
                    onTap: ()
                    {
                      print('click like');
                      setState(()
                      {
                        commentSortType = CommentSortType.likes;
                        downCompletePage = 0;
                        commentList.clear();
                        GetCommentsData();
                      });
                    },
                    child: Container
                      (
                      width: 73,
                      height: 26,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF1E1E1E),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1.50,
                              color: commentSortType == CommentSortType.likes
                                  ? const Color(0xFF00FFBF)
                                  : const Color(0xFF878787)),
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
                        TextStyle(fontSize: 11,
                          color: commentSortType == CommentSortType.likes
                              ? Colors.white
                              : const Color(0xFF878787),
                          fontFamily: 'NotoSans',
                          fontWeight: FontWeight.bold,),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  GestureDetector
                    (
                    onTap: ()
                    {
                      print('click create at');
                      setState(() {
                        commentSortType = CommentSortType.created_at;
                        commentList.clear();
                        GetCommentsData();
                      });
                    },
                    child: Container
                      (
                      width: 73,
                      height: 26,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF1E1E1E),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1.50,
                              color: commentSortType == CommentSortType.created_at
                                  ? Color(0xFF00FFBF)
                                  : Color(0xFF878787)),
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
                        TextStyle(fontSize: 11,
                          color: commentSortType == CommentSortType.created_at
                              ? Colors.white
                              : const Color(0xFF878787),
                          fontFamily: 'NotoSans',
                          fontWeight: FontWeight.bold,),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Obx(()
            {
              if (prevLogin == false && UserData.to.isLogin.value == true)
              {
                GetCommentsData(true);
              }
              else if (UserData.to.commentChange.value.isNotEmpty)
              {
                buttonEnabled = false;
                var item = commentList.firstWhere((element) => element.ID == UserData.to.commentChange.value);
                HttpProtocolManager.to.Get_Comment(item.parentID!, item.ID).then((value1)
                {
                  UserData.to.commentChange.value = '';
                  if (value1 == null)
                  {
                    buttonEnabled = true;
                    return;
                  }
                  var resData = value1.data!.items!.firstWhere((element) => element.id == item.ID);
                  if (UserData.to.userId == resData.whoami)
                  {
                    item.likeCount = resData.likes;
                    item.isLikeCheck = resData.whoami!.isNotEmpty && resData.whoami == UserData.to.userId && resData.ilike > 0;
                    setState(() {

                    });
                  }
                  buttonEnabled = true;
                },);
              }

              prevLogin = UserData.to.isLogin.value;

              return
              Column
              (
                children:
                [
                  for(int i = 0; i < commentList.length; ++i)
                  CommentWidget
                  (
                   commentList[i],
                    false,
                    (id)
                    {
                    if (kDebugMode) {
                      print(id);
                    }

                    if (buttonEnabled == false)
                    {
                      return;
                    }

                    if (UserData.to.isLogin.value == false)
                    {
                      showDialogTwoButton(StringTable().Table![600018]!, '',
                              () {
                            Get.to(() => LoginPage());
                          });
                      return;
                    }

                    buttonEnabled = false;
                    var value = commentList[i].isLikeCheck! ? -1 : 1;
                    if (kDebugMode) {
                      print('Content Info Page like check value : $value');
                    }
                    HttpProtocolManager.to.Send_Stat(id, value, Stat_Type.like)
                        .then((value)
                    {
                      for(var item in value!.data!)
                      {
                        for(int i = 0 ; i < commentList.length; ++i)
                        {
                          if (commentList[i].ID == item.key)
                          {
                            HttpProtocolManager.to.Get_Comment(commentList[i].parentID!, id).then((value1)
                            {
                              if (value1 == null)
                              {
                                buttonEnabled = true;
                                return;
                              }
                              var resData = value1.data!.items!.firstWhere((element) => element.id == id);
                              if (UserData.to.userId == resData.whoami)
                              {
                                print('find');
                                commentList[i].likeCount = resData.likes;
                                commentList[i].isLikeCheck = resData.whoami!.isNotEmpty && resData.whoami == UserData.to.userId && resData.ilike > 0;
                                setState(() {

                                });
                              }
                              print('complete');
                              buttonEnabled = true;
                            },);
                            break;
                          }
                        }
                      }
                    });
                  },
                      (id)
                  {
                    UserData.to.commentChange.value = '';
                    Get.to(() => ReplyPage(), arguments: commentList[i]);
                  },
                      (id)
                  {
                    //수정 불가.
                  },
                      (id)
                  {
                    //TODO : 삭제 버튼 처리
                    setState(()
                    {
                      commentList.remove(commentList[i]);
                    });
                  },
                ),
              ],
            );
          },),
        ],
      ),
    );
  }

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
  bool? isDelete;
  bool? isEdit;
  CommentType? commentType;
  String? parentID;
  String? userID;

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
      required this.isDelete,
      required this.isEdit,
      required this.commentType,
      required this.parentID,
      required this.userID,
    }
  );
}
