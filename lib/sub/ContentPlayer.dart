import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';
import 'package:share/share.dart';
import 'package:shortplex/Network/Comment_Res.dart';
import 'package:shortplex/Network/Content_Res.dart';
import 'package:shortplex/Util/HttpProtocolManager.dart';
import 'package:shortplex/sub/LogoPage.dart';
import 'package:shortplex/sub/UserInfo/LoginPage.dart';
import 'package:shortplex/sub/UserInfo/ShopPage.dart';
import 'package:shortplex/table/UserData.dart';
import 'package:video_player/video_player.dart';

import '../Util/ShortplexTools.dart';
import '../table/StringTable.dart';
import 'ContentInfoPage.dart';
import 'CupertinoMain.dart';
import 'Home/HomeData.dart';
import 'ReplyPage.dart';

enum ContentUI_ButtonType
{
  COMMENT,
  CHECK,
  SHARE,
  CONTENT_INFO,
}

enum Bottom_UI_Type
{
  NONE,
  COMMENT,
  REPLY,
  EPISODE,
}

class ContentPlayer extends StatefulWidget
{
  @override
  _ContentPlayerState createState() => _ContentPlayerState();
}

class _ContentPlayerState extends State<ContentPlayer> with TickerProviderStateMixin, WidgetsBindingObserver
{
  final CarouselController pagecontroller = CarouselController();
  VideoPlayerController? videoController;
  // Add a variable to handle the time of video playback
  int selectedEpisodeNo = 0;
  double currentTime = 0.0;
  double tweenDelay = 3;
  double commentScrollOffset = 0;
  bool controlUIVisible = false;
  bool isShowContent = false;
  bool isEdit = false;
  bool prevLogin = false;
  bool initialized = false;
  bool buttonDisable = false;
  bool snackBarComplete = true;

  TextEditingController textEditingController = TextEditingController();
  FocusNode textFocusNode = FocusNode();

  Bottom_UI_Type bottomUItype = Bottom_UI_Type.NONE;

  late Ticker ticker;
  late AnimationController tweenController;
  Episode? episodeData;
  var episodeGroupList = <String>[];
  var episodeGroupSelections = <bool>[];
  late Map<int, List<Episode>> mapEpisodeData = {};
  var episodeGroupScrollController = ScrollController();
  var currentPopcorn = 0;

  void initVideoController()
  {
    initialized = false;
    currentTime = 0;

    if (videoController != null)
    {
      videoController!.removeListener(eventListener);
      videoController!.dispose();
    }

    HttpProtocolManager.to.Get_streamUrl(episodeData!.episodeHd, episodeData!.id).then((value)
    {
      if (value.isEmpty)
      {
        Restart.restartApp();
        return;
      }

      //print('Play Url : $value');
      videoController = VideoPlayerController.networkUrl(Uri.parse(value))
        ..initialize().then((_)
      {
        if (isShowContent)
        {
          HttpProtocolManager.to.Send_WatchData(episodeData!.id);

          setState(()
          {
            initialized = true;
            videoController!.setVolume(1);
            videoController!.play();
          });

          videoController!.addListener(eventListener);
        }
      });
    },);
  }

  void eventListener()
  {
    if (isShowContent == false)
    {
      return;
    }

    if (videoController!.value.position >=
        videoController!.value.duration)
    {
      // 동영상 재생이 끝났을 때 실행할 로직
      if (selectedEpisodeNo < HomeData.to.listEpisode.length)
      {
        pagecontroller.nextPage();
        //pagecontroller.jumpToPage(selectedEpisodeNo);
        return;
      }
      else
      {
        Get.back();
      }
    }

    if (mounted) {
      setState(() {
        currentTime = videoController!.value.position.inSeconds.toDouble();
      });
    }
  }

  void initContent()
  {
    print('init start');
    if (videoController != null)
    {
      videoController!.removeListener(eventListener);
      videoController!.dispose();
      videoController = null;
    }

    isShowContent = false;

    currentPopcorn = UserData.to.popcornCount.value;

    if(HomeData.to.listEpisode.any((element) => element.no == selectedEpisodeNo))
    {
      episodeData = HomeData.to.listEpisode.firstWhere((item) => item.no ==
          selectedEpisodeNo);
    }
    else{
      print('not found episode no : $selectedEpisodeNo');
    }

    //팝콘이 부족하지 않은지 확인.
    //이번회차의 가격을 알아온다.
    if (episodeData!.isLock)
    {
      var money = UserData.to.popcornCount.value + UserData.to.bonusCornCount.value;
      print('!!!! is Lock !!!!!');
      //구독중이면 그냥 다음진행.
      if (UserData.to.isSubscription == false)
      {
        if (money < episodeData!.cost)
        {
          isShowContent = false;
          bottomOffset = 0;
          tweenTime = 300;
          setState(()
          {

          });
        }
        else
        {
          //팝콘은 충분한데 자동결제가 아닌사람.
          if (UserData.to.autoPlay == false)
          {
            WidgetsBinding.instance.addPostFrameCallback((_)
            {
              showDialogTwoButton(SetTableStringArgument(100038, [episodeData!.priceAmt, episodeData!.title, episodeData!.no.toString()]),
                  SetTableStringArgument(100039 , [money.toString()]),
                      ()
                  {
                    //소비하고 보겠다고 ok함.
                    if (kDebugMode) {
                      print('buy episode 1');
                    }
                    PlayEpisode(episodeData!.id);
                  },
                  ()
                  {
                    isShowContent = false;
                    Get.back();
                  },);
            });
          }
          else
          {
            print('buy episode 2');
            PlayEpisode(episodeData!.id);
          }
        }
      }
      else
      {
        print('play content 1');
        isShowContent = true;
      }
    }
    else
    {
      print('play content 2');
      isShowContent = true;
    }

    if (isShowContent == true)
    {
      initVideoController();
    }
  }

  void initEpisodeGroup()
  {
    int totalEpisodeCount = HomeData.to.listEpisode.length;
    //print('totalEpisodeCount : $totalEpisodeCount / total page : ${contentRes!.data!.episode_maxpage}');
    int dividingNumber = 20;
    int groupCount = HomeData.to.listEpisode.length ~/ dividingNumber;
    //print('groupCount = $groupCount');
    for (int i = 0; i < groupCount; ++i)
    {
      var startString = i * dividingNumber + 1;
      var endString = i * dividingNumber + dividingNumber;
      episodeGroupList.add('${startString}~${SetTableStringArgument(100033, ['$endString'],)}');

      var list = <Episode>[];
      for(int j = startString - 1; j < endString; ++j)
      {
        list.add(HomeData.to.listEpisode[j]);
      }
      mapEpisodeData[i] = list;
    }

    var remain = totalEpisodeCount % 20;
    if (remain != 0)
    {
      var startIndex = groupCount * dividingNumber + 1;
      var endIndex = groupCount * dividingNumber + remain;
      episodeGroupList.add('${startIndex}~${SetTableStringArgument(100033, ['$endIndex'],)}');

      var list = <Episode>[];
      for(int j = startIndex - 1; j < endIndex; ++j)
      {
        list.add(HomeData.to.listEpisode[j]);
      }
      mapEpisodeData[mapEpisodeData.length] = list;
    }

    episodeGroupSelections = List.generate(episodeGroupList.length, (_) => false);
    episodeGroupSelections[0] = true;

    setState(() {

    });
  }

  void getFavorite()
  {
    if (UserData.to.isLogin.value == false)
    {
      UserData.to.isFavoriteCheck.value = false;
      return;
    }

    HttpProtocolManager.to.Get_Stat(episodeData!.contentId).then((value)
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
          print('item.amt ${item.amt} / check 3 : ${UserData.to.isFavoriteCheck}');
          setState(() {

          });
          return;
        }
      }
    });
  }

  Future PlayEpisode(String _eid) async
  {
    HttpProtocolManager.to.Send_BuyEpisode(_eid).then((value)
    {
      if (value == null)
      {
        return;
      }

      if ( value.data!.status  == null) {
        return;
      }

      if (value.data!.status is bool)
      {
        print('Status is a boolean: ${value.data!.status}');
        if ( value.data!.status == false)
        {
          if (kDebugMode) {
            print(value.data!.message);
          }
          //이미 구매함.
          if (value.data!.message == 'You already have it')
          {
            var completeEpisode = HomeData.to.EpisodeBuyUpdate(_eid);
            if (completeEpisode != null)
            {
              if (kDebugMode) {
                print('play contetent');
              }
              isShowContent = true;
              initVideoController();
              setState(() {

              });

            }
            return;
          }
        }
      }
      else if (value.data!.status is String)
      {
        if (value.data!.status == "completed")
        {
          print('value.data!.status : ${value.data!.status}');
          if (_eid == value.data!.productId)
          {
            //구매 성공.
            var completeEpisode = HomeData.to.EpisodeBuyUpdate(_eid);
            if (completeEpisode != null)
            {
              if (kDebugMode) {
                print('구매 성공');
              }
              isShowContent = true;
              initVideoController();
              setState(() {

              });
            }

            HttpProtocolManager.to.Get_WalletBalance().then((walletBalanceValue)
            {
              if (walletBalanceValue == null) {
                return;
              }

              for(var item in walletBalanceValue.data!.items!)
              {
                if (item.userId == UserData.to.userId)
                {
                  UserData.to.MoneyUpdate(item.popcorns,item.bonus);
                  break;
                }
              }
            });
          }
        }
      }
      else
      {
        if (kDebugMode) {
          print('Unknown type');
        }
      }
    },);
  }

  @override
  void initState()
  {
    buttonDisable = false;
    prevLogin = UserData.to.isLogin.value;
    if (Get.arguments is int) {
      selectedEpisodeNo = Get.arguments;
    }
    //print('selectedEpisodeNo : $selectedEpisodeNo');

    initContent();

    tweenController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    //사용팝콘 알려준다.
    WidgetsBinding.instance.addPostFrameCallback((_) async
    {
      if (UserData.to.usedPopcorn != 0)
      {
        ShowCustomSnackbar(SetTableStringArgument(100047, [UserData.to.usedPopcorn.toString()]), SnackPosition.BOTTOM);
        UserData.to.usedPopcorn = 0;
      }
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent)
      {
        print('call end page');
        onEndOfPage();
      }
    });

    ticker = createTicker((elapsed)
    {
      if (elapsed.inSeconds > 3)
      {
          ticker.stop();
          if(controlUIVisible = true)
          {
            controlUIVisible = false;
            tweenController.reverse();
            setState(() {

            });
          }
        }
    });

    // FocusNode에 리스너 추가
    textFocusNode.addListener(()
    {
      if (textFocusNode.hasFocus)
      {
        if (UserData.to.isLogin.value == false)
        {
          textFocusNode.unfocus();

          showDialogTwoButton(StringTable().Table![600018]!, '',
          ()
          {
            Get.to(() => LoginPage());
          });
        }
      }
      else
      {
        // CupertinoTextField가 포커스를 잃었을 때 실행할 코드
        textEditingController.text = '';
        isEdit = false;
        editReplyID = '';
      }
    });

    getFavorite();
    initEpisodeGroup();
    getCommentsData();

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed)
    {
      buttonDisable = false;
    }
  }

  @override
  void dispose()
  {
    episodeGroupScrollController.dispose();
    textFocusNode.dispose();
    textEditingController.dispose();
    ticker.dispose();
    replyScrollController.dispose();
    if (isShowContent)
    {
      videoController!.removeListener(eventListener);
      videoController!.dispose();
    }
    tweenController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  // @override
  // void didChangeDependencies() async
  // {
  //   super.didChangeDependencies();
  // }

  void SendComment() async
  {
    try
    {
      connecting = true;
      if (isEdit)
      {
        await HttpProtocolManager.to.Send_edit_comment
        (
          episodeData!.id, textEditingController.text, commentData!.ID,
          Comment_CD_Type.episode).then((value)
        {
          for(var item in value!.data!.items!)
          {
            for(int i = 0 ; i < episodeCommentList.length; ++i)
              {
                if (episodeCommentList[i].ID == item.id && episodeCommentList[i].comment != item.content)
                {
                  episodeCommentList[i].comment = item.content;
                  break;
                }
              }
          }
          setState(() {

          });
          connecting = false;
        });
      }
      else
      {
        await HttpProtocolManager.to.Send_Comment(
            episodeData!.id!, textEditingController.text, '', Comment_CD_Type.episode).then((value)
        {
          CommentRefresh(value, false);
          connecting = false;
        });
      }
    }
    catch(e)
    {
      connecting = false;
      print('send Comment error : $e');
    }
  }

  void SendReply() async
  {
    try
    {
      connecting = true;
      if (isEdit)
      {
        await HttpProtocolManager.to.Send_edit_reply
          (
            episodeData!.id, textEditingController.text, commentData!.ID, editReplyID, Comment_CD_Type.episode).then((value) {
          for(var item in value!.data!.items!)
          {
            for(int i = 0 ; i < replyList.length; ++i)
            {
              if (replyList[i].ID == item.id && replyList[i].comment != item.content)
              {
                replyList[i].comment = item.content;
                break;
              }
            }
          }
          setState(() {

          });
          connecting = false;
        });
      }
      else
      {
        await HttpProtocolManager.to.Send_Reply
          (
            episodeData!.id, textEditingController.text, commentData!.ID, Comment_CD_Type.episode).then((value)
        {
          CommentRefresh(value, true);
          print('send_Reply result $value');
          connecting = false;

          //comment replise count update.
          HttpProtocolManager.to.Get_Comment(episodeData!.id, commentData!.ID).then((value1)
          {
            for(var item in value1!.data!.items!)
            {
              if (commentData == null)
              {
                break;
              }

              if (item.id == commentData!.ID)
              {
                setState(() {
                  commentData!.replyCount = item.replies;
                });
                break;
              }
            }
          });
        });
      }
    }
    catch(e)
    {
      connecting = false;
      print('send send_Reply error : $e');
    }
  }

  int downCompletePage = 0;
  int maxPage = 0;

  void getCommentsData([bool _refresh = false])
  {
    if (_refresh)
    {
      for(int i = 0; i < downCompletePage; ++i)
      {
        GetComment(i);
      }
    }
    else
    {
      if (downCompletePage > maxPage) {
        return;
      }

      GetComment(downCompletePage).then((value)
      {
        if (value) {
          downCompletePage++;
        }
      });
    }
  }

  Future<bool> GetComment(int _page) async
  {
    try
    {
      await HttpProtocolManager.to.Get_EpisodeComments(episodeData!.id, _page, commentSortType.name).then((value)
      {
        if (value == null)
        {
          return false;
        }

        maxPage = value.data!.maxPage;
        CommentRefresh(value, false);
        return true;
      });
    }
    catch(e)
    {
      print('send Comment error : $e');
    }

    return false;
  }

  void CommentRefresh(CommentRes? _data, bool _isReply)
  {
    if (_data == null)
    {
      print("CommentRefresh data null return");
      return;
    }

    for (var item in _data.data!.items!)
    {
      var selectList = _isReply ? replyList : episodeCommentList;
      if (selectList.any((element) => element.ID == item.id))
      {
        for(int i = 0 ; i < selectList.length; ++i)
        {
          if (selectList[i].ID == item.id)
          {
            selectList[i].name = item.displayname;
            selectList[i].comment = item.content;
            selectList[i].date = GetReleaseTime(item.createdAt!);
            selectList[i].episodeNumber = item.episode_no.toString();
            selectList[i].iconUrl = item.photourl;
            selectList[i].isLikeCheck = item.whoami!.isNotEmpty && item.whoami == UserData.to.userId && item.ilike > 0;
            selectList[i].likeCount = item.likes;
            selectList[i].replyCount = item.replies;
            selectList[i].isDelete = UserData.to.userId ==  item.userId;
            selectList[i].commentType = item.rank > 0 && item.rank < 3 ? CommentType.BEST : CommentType.NORMAL;
            selectList[i].parentID = item.key;
            selectList[i].isEdit = UserData.to.userId == item.userId;
            selectList[i].userID = item.userId;
          }
        }
        continue;
      }

      var commentData = EpisodeCommentData
      (
        name: item.displayname,
        comment: item.content ?? '',
        date: item.createdAt != null ? GetReleaseTime(item.createdAt!) : '00.00.00',
        episodeNumber: '',
        iconUrl: item.photourl,
        ID: item.id!,
        isLikeCheck: item.whoami!.isNotEmpty && item.whoami == UserData.to.userId && item.ilike > 0,
        likeCount: item.likes,
        replyCount: '${item.replies}',
        isDelete: UserData.to.userId == item.userId,
        commentType: CommentType.NORMAL,
        parentID: episodeData!.id,
        isEdit: UserData.to.userId == item.userId,
        userID: item.userId,
      );
      selectList.add(commentData);
      setState(() {

      });
    }

    setState(()
    {
      if (_isReply)
      {
        totalCommentReplyCount = _data.data!.total;
      }
      else
      {
        totalCommentCount = _data.data!.total;
      }
    });
  }

  void DeleteComment(String _id)
  {
    try
    {
      HttpProtocolManager.to.Send_delete_comment(episodeData!.id, _id).then((value)
      {
        for(var item  in value!.data!.items!)
        {
          print('receive delete id : ${item.id}');
          for(int i = 0; i < episodeCommentList.length; ++i)
          {
            if (episodeCommentList[i].ID == item.id)
            {
              episodeCommentList.removeAt(i);
              totalCommentCount = value.data!.total;
              //print('delete complete id : ${item.id}');
              setState(() {

              });
              break;
            }
          }
        }
      });
    }
    catch(e)
    {
      print('send Comment error : $e');
    }
  }

  void DeleteReply(String _replyID) async
  {
    try
    {
      await HttpProtocolManager.to.Send_delete_reply(episodeData!.id,commentData!.ID, _replyID).then((value)
      {
        for(var item  in value!.data!.items!)
        {
          for(int i = 0; i < replyList.length; ++i)
          {
            if (replyList[i].ID == item.id)
            {
              replyList.removeAt(i);
              setState(() {
                totalCommentReplyCount = value.data!.total;
              });
              break;
            }
          }
        }
      });
    }
    catch(e)
    {
      print('send Comment error : $e');
    }
  }

  int downReplyPage = 0;
  int maxReplyPage = 0;

  void getRepliesData([bool _refresh = false])
  {
    if (_refresh)
    {
      for(int i = 0; i < downReplyPage; ++i)
      {
        GetReplies(i);
      }
    }
    else
    {
      if (downReplyPage > maxReplyPage)
      {
        return;
      }

      GetReplies(downReplyPage).then((value) => downReplyPage++);
    }
  }

  Future GetReplies(int _page) async
  {
    try
    {
      HttpProtocolManager.to.Get_RepliesData(episodeData!.id, commentData!.ID, _page).then((value)
      {
        maxReplyPage = value!.data!.maxPage;
        CommentRefresh(value, true);
        print('Get Replies Complete');
      });
    }
    catch(e)
    {
      print('send Comment error : $e');
    }
  }


  void setScrollPosition(double _offset) {
    scrollController.animateTo(
      _offset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Widget contentUIButtons(String _buttonLabel, IconData _buttonIcon, ContentUI_ButtonType _type)
  {
    return
    Container
    (
      //color: Colors.white,
      alignment: Alignment.centerRight,
      width: MediaQuery.of(context).size.width,
      child:
      Padding
      (
        padding: const EdgeInsets.only(top:2, bottom: 10.0, right: 25),
        child: GestureDetector
        (
          onTap: ()
          {
            if (connecting) {
              return;
            }

            if (showCheck() == false)
            {
              return;
            }

            switch(_type)
            {
              case ContentUI_ButtonType.COMMENT:
              {
                bottomUItype = Bottom_UI_Type.COMMENT;
                ticker.stop();
                controlUIVisible = false;
                tweenTime = 300;
                bottomOffset = 0;
                tweenController.reverse();
                setState(() {

                });

                downCompletePage = 0;
                episodeCommentList.clear();
                getCommentsData();
              }
              break;
              case ContentUI_ButtonType.CONTENT_INFO:
                {
                  bottomUItype = Bottom_UI_Type.EPISODE;
                  ticker.stop();
                  controlUIVisible = false;
                  tweenTime = 300;
                  bottomOffset = 0;
                  tweenController.reverse();
                  setState(() {

                  });
                }
                break;
              case ContentUI_ButtonType.CHECK:
                {
                  //찜하기.
                  ticker.stop();
                  ticker.start();

                  if (UserData.to.isLogin.value == false)
                  {
                    showDialogTwoButton(StringTable().Table![600018]!, '',
                    ()
                    {
                      Get.to(() => LoginPage());
                    });
                    return;
                  }

                  connecting = true;
                  var actionValue = UserData.to.isFavoriteCheck.value ? -1 : 1;
                  HttpProtocolManager.to.Send_Stat(episodeData!.contentId!, actionValue, Comment_CD_Type.content, Stat_Type.favorite).then((value)
                  {
                    if (value == null) {
                      connecting = false;
                      return;
                    }
                    //GetFavorite();

                    for(var item in value.data!)
                    {
                      if (item.key == episodeData!.contentId && item.action == Stat_Type.favorite.name)
                      {
                        UserData.to.isFavoriteCheck.value = item.amt > 0;
                        break;
                      }
                    }

                    connecting = false;
                  });
                }
                break;
              case ContentUI_ButtonType.SHARE:
                {
                  if (buttonDisable == false) {
                    return;
                  }

                  if (episodeData!.shareLink.isEmpty) {
                    return;
                  }

                  buttonDisable = true;
                  Share.share(episodeData!.shareLink);
                  if (kDebugMode) {
                    print('tap share');
                  }
                }
                break;
              default:
                print('to do type $_type');
                break;
            }
            print('contentUIButtons tap');
          },
          child:
          Opacity
          (
            opacity: 0.70,
            child:
            Container
            (
              width: 56,
              height: 45,
              decoration: ShapeDecoration(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1.50,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Color(0xFF3B3B3B),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child:
              Stack
              (
                alignment: Alignment.center,
                children:
                [
                  Padding
                  (
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Icon(_buttonIcon, size: 22, color:Colors.white),
                  ),
                  Padding
                  (
                    padding: const EdgeInsets.only(top: 18),
                    child: Text
                    (
                      _buttonLabel,
                      style:
                      const TextStyle(fontSize: 10, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool showCheck()
  {
    if (isShowContent == false)
    {
      setState(() {
        bottomOffset = 0;
      });
    }

    return isShowContent;
  }

  Widget controlUI(BuildContext context)
  {
    return
    Container
    (
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      //color: Colors.blue,
      //alignment: Alignment.bottomCenter,
      child:
      Column
      (
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
        [
          Expanded
          (
            child:
            Container
            (
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width,
              //height: 50,
              //color: Colors.black54,
              child:
              Container
              (
                width: MediaQuery.of(context).size.width,
                height: 50,
                color: Colors.black54,
                child: Row
                (
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:
                  [
                    CupertinoNavigationBarBackButton
                    (
                      color: Colors.white,
                      onPressed: ()
                      {
                        //print(Get.isPopGestureEnable);
                        Get.back();
                      },
                    ),
                    const SizedBox(width: 10,),
                    Text
                    (
                      '${episodeData!.title}\n${SetTableStringArgument(100033, [episodeData!.no.toString()])}',
                      style:
                      const TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded
          (
            child:
            Container
            (
              alignment: Alignment.center,
              child: GestureDetector
              (
                onTap: ()
                {

                  if (showCheck() == false)
                  {
                    return;
                  }

                  if (videoController == null) {
                    return;
                  }

                  ticker.stop();
                  ticker.start();

                  if (videoController!.value.isInitialized)
                  {
                    if (videoController!.value.isPlaying) {
                      videoController!.pause();
                    }
                    else {
                      videoController!.play();
                    }
                  }
                },
                child:
                Container
                (
                  alignment: Alignment.center,
                  padding: videoController != null && isShowContent && videoController!.value.isInitialized && videoController!.value.isPlaying ? EdgeInsets.only(left: 0) : EdgeInsets.only(left: 5,),
                  width: 75,
                  height: 75,
                  decoration: ShapeDecoration(
                    color: Colors.black.withOpacity(0.7),
                    shape: OvalBorder(
                      side: BorderSide(
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFF00FFBF),
                      ),
                    ),
                  ),
                  child:
                  Icon
                  (
                    videoController != null && isShowContent && videoController!.value.isInitialized && videoController!.value.isPlaying ? CupertinoIcons.pause_solid :
                    CupertinoIcons.play_arrow_solid, size: 40, color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          contentUIButtons('$totalCommentCount', CupertinoIcons.ellipses_bubble, ContentUI_ButtonType.COMMENT),
          contentUIButtons(StringTable().Table![100023]!, UserData.to.isFavoriteCheck.value ? CupertinoIcons.heart_solid : CupertinoIcons.heart, ContentUI_ButtonType.CHECK),
          contentUIButtons(StringTable().Table![100024]!, CupertinoIcons.share, ContentUI_ButtonType.SHARE),
          contentUIButtons(StringTable().Table![100043]!, CupertinoIcons.info, ContentUI_ButtonType.CONTENT_INFO),
          Container
          (
            color: Colors.black.withOpacity(0.9),
            child:
            SizedBox
            (
              width: MediaQuery.of(context).size.width,
              child:
              videoController != null && isShowContent && videoController!.value.isInitialized ?
              CupertinoSlider
              (
                activeColor: const Color(0xFF00FFBF),
                value: currentTime,
                min: 0.0,
                max: videoController!.value.duration.inSeconds.toDouble(),
                onChanged: (value)
                {
                  ticker.stop();
                  ticker.start();
                  setState(()
                  {
                    currentTime = value;
                    videoController!.seekTo(Duration(seconds: value.toInt()));
                  });
                },
              ) : Container(),
            ),
          ),
          Container
          (
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 30),
            height: 40,
            alignment: Alignment.topLeft,
            color: Colors.black.withOpacity(0.9),
            child:
            Text
            (
              videoController != null &&isShowContent && videoController!.value.isInitialized ?
              '${SubstringDuration(videoController!.value.position).$2}:${SubstringDuration(videoController!.value.position).$3} / ${SubstringDuration(videoController!.value.duration).$2}:${SubstringDuration(videoController!.value.duration).$3}' : '00:00 / 00:00',
              style:
              const TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
            ),
          ),
        ],
      ),
    );
  }

Widget contentPlayMain()
{
    return
    GestureDetector
    (
      onTap:
          ()
      {
        if (isShowContent == false || bottomOffset == 0) {
          return;
        }

        if (tweenController.status == AnimationStatus.completed) {
          tweenController.reverse();
          ticker.stop();
          setState(() {
            controlUIVisible = false;
          });
        }
        else
        {
          tweenController.forward();
          ticker.stop();
          ticker.start();
          setState(()
          {
            controlUIVisible = true;
          });
        }
      },
      child:
      Stack
      (
        alignment: Alignment.center,
        children: <Widget>
        [
          AspectRatio
          (
            aspectRatio: 9/16,
            child:
            Center
            (
              child:
              videoController != null && isShowContent == true && videoController!.value.isInitialized == true ?
              VideoPlayer(videoController!) :
              Center
              (
                child:
                Image.network(episodeData!.altImgUrlHd),
                //CircularProgressIndicator()
              ),
            ),
          ),
          FadeTransition
          (
            opacity: tweenController,
            child:
            IgnorePointer
            (
              ignoring: controlUIVisible == false,
              child:
              controlUI(context),
            ),
          ),
          bottomCanvas(),
          //contentComment(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context)
  {
  try
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
            child:
            Center
            (
              child:
              CarouselSlider.builder
              (
                carouselController: pagecontroller,
                options:
                CarouselOptions
                (
                  initialPage: selectedEpisodeNo - 1,
                  onPageChanged: (index, reason)
                  {
                    //print('on changed index : $index');
                    tweenTime = 0;
                    //WidgetsBinding.instance.addPostFrameCallback((_) {};
                    setState(()
                    {
                      selectedEpisodeNo = index + 1;
                      initContent();
                      downCompletePage = 0;
                      episodeCommentList.clear();
                      commentSortType = CommentSortType.created_at;
                      getCommentsData();
                    });
                  },
                  height: MediaQuery.of(context).size.height,
                  //aspectRatio: 9 / 16,
                  viewportFraction: 1,
                  //enlargeCenterPage: true,
                  scrollDirection: Axis.vertical,
                  //height: MediaQuery.of(context).size.height,
                  //autoPlay: true,
                  scrollPhysics: videoController == null || videoController!.value.isInitialized == false || bottomOffset == 0 ? NeverScrollableScrollPhysics() : ClampingScrollPhysics(),
                ),
                //items: pageList,
                itemCount: HomeData.to.listEpisode.length,
                itemBuilder: (context, index, realIndex)
                {
                  return selectedEpisodeNo == index + 1 && initialized ? contentPlayMain() : Image.network(HomeData.to.listEpisode[index].altImgUrlHd!);
                },
              ),
            )
          ),
        )
      );
    }
    catch(e)
    {
      print('content player Error $e');
      return
      Stack
      (
        alignment: Alignment.center,
        children:
        [
          AspectRatio
          (
            aspectRatio: 9/16,
            child:
            Image.network(episodeData!.altImgUrlHd)
          ),
          CircularProgressIndicator(),
          Container
          (
            width: 390.w,
            height: 844.h,
            alignment: Alignment.topLeft,
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
        ],
      );
    }
  }

  bool connecting = false;
  double bottomOffset = -844.h;
  int tweenTime = 0;
  Widget bottomCanvas()
  {
    return
    TweenAnimationBuilder<double>
    (
      tween: Tween<double>(begin: 0, end: bottomOffset),
      duration: Duration(milliseconds: tweenTime),
      builder: (BuildContext context, double offset, Widget? child)
      {
        return
        Positioned
        (
          bottom: offset,
          left: 0,
          right: 0,
          child:
          Stack
          (
            children:
            [
              Container
              (
                width: MediaQuery.of(context).size.width,
                //height: MediaQuery.of(context).size.height,
                //color: Colors.transparent,
                alignment: Alignment.bottomCenter,
                child:
                Column
                (
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:
                  [
                    GestureDetector
                    (
                        onTap: ()
                        {
                          if (bottomOffset == 0)
                          {
                            if (isShowContent == false)
                            {
                              tweenController.forward();
                              ticker.stop();
                              controlUIVisible = true;
                            }

                            textFocusNode.unfocus();
                            setState(()
                            {
                              bottomOffset = -844.h;
                            });
                          }
                        },
                      child:
                      Column
                      (
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:
                        [
                          Container
                          (
                            height: MediaQuery.of(context).size.height - (500.h + 70),
                            color: Colors.transparent,
                            //color: Colors.blue,
                          ),
                          Container
                          (
                            height: 70,
                            //color: Colors.red,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(0, 0),
                                end: Alignment(0, -1),
                                colors: [Colors.black, Colors.transparent],
                              ),
                              //border: Border.all(width: 1),
                            ),
                          ),
                        ],
                      )
                    ),
                    Container
                    (
                      width: 390.w,
                      height: 500.h,
                      color: Colors.black,
                      child:
                      isShowContent == false ?
                      Obx(()
                      {
                        // 상점에서 구매 후 팝콘이 많아진 경우.
                        if (currentPopcorn != UserData.to.popcornCount.value && UserData.to.popcornCount.value > episodeData!.cost)
                        {
                          currentPopcorn = UserData.to.popcornCount.value;

                          WidgetsBinding.instance.addPostFrameCallback((_)
                          {
                            setState(()
                            {
                              bottomOffset = -844.h;
                              tweenTime = 0;
                              initContent();
                              downCompletePage = 0;
                              episodeCommentList.clear();
                              commentSortType = CommentSortType.created_at;
                              getCommentsData();
                            });
                          });

                          return const SizedBox();
                        }

                        return showShop();
                      })
                      :
                      Stack
                      (
                        children:
                        [
                          if (bottomUItype == Bottom_UI_Type.COMMENT)
                            contentComment(),
                          if (bottomUItype == Bottom_UI_Type.REPLY)
                            commentReply(),
                          if (bottomUItype == Bottom_UI_Type.EPISODE)
                            episodeInfo(),
                          Visibility
                          (
                            visible: bottomUItype == Bottom_UI_Type.COMMENT || bottomUItype == Bottom_UI_Type.REPLY,
                            child:
                            IgnorePointer
                            (
                              ignoring: connecting,
                              child:
                              Obx(()
                              {
                                return
                                  VirtualKeybord(StringTable().Table![100041]!, textEditingController, textFocusNode,
                                    !UserData.to.isLogin.value, MediaQuery.of(context).viewInsets.bottom,
                                    ()
                                    {
                                      print('comment complete ${textEditingController.text}');

                                      if (textEditingController.text.isEmpty)
                                      {
                                        return;
                                      }

                                      if (commentData != null && textEditingController.text == commentData!.comment)
                                      {
                                        return;
                                      }

                                      if (bottomUItype == Bottom_UI_Type.REPLY)
                                      {
                                        SendReply();
                                      }
                                      else
                                      {
                                        SendComment();
                                      }
                                    },);
                              }),
                            ),
                          )
                        ],
                      )
                    ),
                  ],
                )
              ),
            ],
          ),
        );
      },
    );
  }

  //comment 관련
  var episodeCommentList = <EpisodeCommentData>[];
  var scrollController = ScrollController();
  var replyScrollController = ScrollController();
  var totalCommentCount = 0;
  var totalCommentReplyCount = 0;
  CommentSortType commentSortType = CommentSortType.created_at;

  Widget contentComment()
  {
    return
    Container
    (
      padding: const EdgeInsets.only(top: 10),
      //color: Colors.pink,
      child:
        Column
        (
          children:
          [
            SizedBox
            (
              width: MediaQuery.of(context).size.width,
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
                      child:
                      Text
                      (
                        '${StringTable().Table![100026]!} (${totalCommentCount})',
                        style:
                        const TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                      ),
                    ),
                  ),
                  GestureDetector
                  (
                    onTap: ()
                    {
                      if (commentSortType == CommentSortType.likes) {
                        return;
                      }
                      //좋아요순 누름.
                      setState(()
                      {
                        commentSortType = CommentSortType.likes;
                        downCompletePage = 0;
                        episodeCommentList.clear();
                        getCommentsData();
                      });
                    },
                    child: Container
                    (
                      width: 73,
                      height: 26,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF1E1E1E),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1.50, color: commentSortType == CommentSortType.likes ? const Color(0xFF00FFBF) : const Color(0xFF878787)),
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
                        TextStyle(fontSize: 11, color: commentSortType == CommentSortType.likes ? Colors.white : const Color(0xFF878787), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  GestureDetector
                  (
                    onTap: ()
                    {
                      if (commentSortType == CommentSortType.created_at) {
                        return;
                      }
                      //최신순 누름.
                      setState(()
                      {
                        commentSortType = CommentSortType.created_at;
                        downCompletePage = 0;
                        episodeCommentList.clear();
                        getCommentsData();
                      });
                    },
                    child:
                    Container
                    (
                      width: 73,
                      height: 26,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF1E1E1E),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1.50, color: commentSortType == CommentSortType.created_at ? Color(0xFF00FFBF) : Color(0xFF878787)),
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
                        TextStyle(fontSize: 11, color: commentSortType == CommentSortType.created_at ? Colors.white : const Color(0xFF878787), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                ],
              ),
            ),
            SizedBox(height: 16,),
            Expanded
            (
              child:
              Container
              (
                height: 455.h,
                //color: Colors.green,
                child:
                SingleChildScrollView
                (
                  controller: scrollController,
                  child:
                    Obx(()
                    {
                      if (prevLogin == false && UserData.to.isLogin.value == true)
                      {
                        getCommentsData(true);
                      }
                      prevLogin = UserData.to.isLogin.value;
                      return
                      Column
                      (
                        children:
                        [
                          for(int i = 0; i < episodeCommentList.length; ++i)
                            CommentWidget
                            (
                              episodeCommentList[i],
                              false,
                              (id)
                              {
                                //댓글 좋아요 버튼.
                                if (connecting)
                                {
                                  return;
                                }
              
                                if (UserData.to.isLogin.value == false)
                                {
                                  showDialogTwoButton(StringTable().Table![600018]!, '',
                                  ()
                                  {
                                    Get.to(() => LoginPage());
                                  });
                                  return;
                                }
                                connecting = true;
                                //var item = episodeCommentList.firstWhere((element) => element.ID == id);
                                var value = episodeCommentList[i].isLikeCheck! ? -1 : 1;
                                HttpProtocolManager.to.Send_Stat(id, value, Comment_CD_Type.content, Stat_Type.like)
                                    .then((value)
                                {
                                  for(var item in value!.data!)
                                  {
                                    if (episodeCommentList[i].ID == item.key)
                                    {
                                      HttpProtocolManager.to.Get_Comment(episodeCommentList[i].parentID!, id).then((value1)
                                      {
                                        if (value1 == null)
                                        {
                                          connecting = false;
                                          return;
                                        }
                                        var resData = value1.data!.items!.firstWhere((element) => element.id == id);
                                        if (UserData.to.userId == resData.whoami)
                                        {
                                          setState(() {
                                            episodeCommentList[i].likeCount = resData.likes;
                                            episodeCommentList[i].isLikeCheck = resData.whoami!.isNotEmpty && resData.whoami == UserData.to.userId && resData.ilike > 0;
                                          });
                                        }
                                        connecting = false;
                                      },);
                                      break;
                                    }
                                  }
                                });
                              },
                              (id)
                              {
                                //댓글 답글 보기.
                                commentData = episodeCommentList[i];
                                bottomUItype = Bottom_UI_Type.REPLY;
                                //commentScrollOffset = scrollController.offset;
                                downReplyPage = 0;
                                replyList.clear();
                                getRepliesData();
                              },
                              (id)
                              {
                                //댓글 수정.
                                commentData = episodeCommentList[i];
                                textEditingController.text = commentData!.comment!;
                                FocusScope.of(context).requestFocus(textFocusNode);
                                isEdit = true;
                              },
                              (id)
                              {
                                //댓글 삭제.
                                DeleteComment(id);
                              },
                            ),
                          SizedBox(height:  50),
                        ]
                      );
                    },)
                ),
              ),
            )
          ],
        ),
    );
  }

  List<EpisodeCommentData> replyList = <EpisodeCommentData>[];
  EpisodeCommentData? commentData;
  String editReplyID = '';

  Widget commentReply()
  {
    return
    Container
    (
      height: 550.h,
      //color: Colors.green,
      child:
      Column
      (
        mainAxisAlignment: MainAxisAlignment.start,
        children:
        [
          Container
          (
            height: 50,
            alignment: Alignment.centerLeft,
            child:
            CupertinoNavigationBarBackButton
            (
              color: Colors.white,
              onPressed: ()
              {
                bottomUItype = Bottom_UI_Type.COMMENT;
                if (kDebugMode) {
                  print('on tap reply off');
                }
                setState(()
                {
                   //setScrollPosition(commentScrollOffset);
                });
              },
            ),
          ),
          Expanded
          (
            child:
            ReplyPopup(scrollController, commentData!, replyList,
            (id)
            {
              if (connecting) {
                return;
              }
              connecting = true;
              //댓글 좋아요.
              var item = episodeCommentList.firstWhere((element) => element.ID == id);
              var value = item.isLikeCheck! ? -1 : 1;
              HttpProtocolManager.to.Send_Stat(id, value, Comment_CD_Type.content, Stat_Type.like)
                  .then((value)
              {
                for(var item in value!.data!)
                {
                  for(int i = 0 ; i < episodeCommentList.length; ++i)
                  {
                    if (episodeCommentList[i].ID == item.key)
                    {
                      HttpProtocolManager.to.Get_Comment(episodeCommentList[i].parentID!, id).then((value1)
                      {
                        if (value1 == null)
                        {
                          connecting = false;
                          return;
                        }
                        var resData = value1.data!.items!.firstWhere((element) => element.id == id);
                        if (UserData.to.userId == resData.whoami)
                        {
                          setState(() {
                            episodeCommentList[i].likeCount = resData.likes;
                            episodeCommentList[i].isLikeCheck = resData.whoami!.isNotEmpty && resData.whoami == UserData.to.userId && resData.ilike > 0;
                            commentData = episodeCommentList[i];
                          });
                        }
                        connecting = false;
                      },);
                      break;
                    }
                  }
                }
              });
            },
            (id)
            {
              //코멘트 삭제.
              DeleteComment(id);
              bottomUItype = Bottom_UI_Type.COMMENT;
              if (kDebugMode)
              {
                print('comment delete');
              }
            },
            (id)
            {
              //답글 좋아요.
              if (connecting)
              {
                return;
              }
              connecting = true;
              var item = replyList.firstWhere((element) => element.ID == id);
              var value = item.isLikeCheck! ? -1 : 1;

              if (kDebugMode) {
                print('reply like check value : $value');
              }

              HttpProtocolManager.to.Send_Stat(id, value, Comment_CD_Type.content, Stat_Type.like)
                  .then((value)
              {
                for(var item in value!.data!)
                {
                  for(int i = 0 ; i < replyList.length; ++i)
                  {
                    if (replyList[i].ID == item.key)
                    {
                      HttpProtocolManager.to.Get_Reply(commentData!.parentID!, commentData!.ID, id).then((value1)
                      {
                        if (value1 == null)
                        {
                          connecting = false;
                          return;
                        }
                        var resData = value1.data!.items!.firstWhere((element) => element.id == id);
                        if (UserData.to.userId == resData.whoami)
                        {
                          setState(() {
                            replyList[i].likeCount = resData.likes;
                            replyList[i].isLikeCheck = resData.whoami!.isNotEmpty && resData.whoami == UserData.to.userId && resData.ilike > 0;
                          });
                        }
                        connecting = false;
                      },);
                      break;
                    }
                  }
                }
              });
            },
            (id)
            {
              //수정하기,
              editReplyID = id;
              isEdit = true;
              var item = replyList.firstWhere((element) => element.ID == id);
              textEditingController.text = item.comment!;
              FocusScope.of(context).requestFocus(textFocusNode);
            },
            (id)
            {
              DeleteReply(id);
            },
            20),
          )
        ],
      ),
    );
  }

  void onEndOfPage() async
  {
    try
    {
      if (bottomUItype == Bottom_UI_Type.REPLY)
      {
        if (totalCommentReplyCount > replyList.length)
        {
          getRepliesData();
        }
      }
      else if (bottomUItype == Bottom_UI_Type.COMMENT)
      {
        if (totalCommentCount > episodeCommentList.length)
        {
          getCommentsData();
        }
      }
    }
    catch (e)
    {
      print(e);
    }
  }

  Widget showShop()
  {
    return
    Padding
    (
      padding: const EdgeInsets.only(top: 0),
      child:
      SingleChildScrollView
      (
          child:
          Column
          (
            children:
            [
              Padding
              (
                padding: EdgeInsets.only(top: 0),
                child:
                Container
                (
                  height: 85,
                  //color: Colors.white,
                  child:
                  Row
                  (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                    [
                      Expanded
                      (
                        flex: 3,
                        child:
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Container
                          (
                            alignment: Alignment.centerLeft,
                            //color: Colors.blue,
                            child:
                            Column
                            (
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                              [
                                Text
                                (
                                  StringTable().Table![400024]!,
                                  style: TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                                ),
                                SizedBox(height: 8,),
                                Text
                                (
                                  SetTableStringArgument(400025, ['${episodeData!.cost}', '${UserData.to.popcornCount.value + UserData.to.bonusCornCount.value}'])
                                  ,
                                  style: TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                                ),
                              ],
                            )
                          ),
                        ),
                      ),
                      Expanded
                      (
                        child:
                        Padding
                        (
                          padding: const EdgeInsets.only(right: 30),
                          child:
                          Container
                          (
                            alignment: Alignment.topLeft,
                            //color: Colors.green,
                            child:
                            GestureDetector
                            (
                             onTap: ()
                             {
                               Get.offAll(() => CupertinoMain(), arguments: MainPageType.RewardPage.index);
                             },
                              child: Stack
                              (
                                alignment: Alignment.center,
                                children:
                                [
                                  Padding
                                  (
                                    padding: EdgeInsets.only(bottom: 20),
                                    child:

                                      Container
                                      (
                                        width: 40,
                                        height: 21,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF1E1E1E),
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(width: 1, color: Color(0xFF00FFBF)),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                        ),
                                        child:
                                        FittedBox
                                          (
                                          alignment: Alignment.center,
                                          child:
                                          Text
                                            (
                                            'FREE',
                                            style: TextStyle(fontSize: 15, color: Color(0xFF00FFBF), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                  ),
                                  Padding
                                  (
                                    padding: const EdgeInsets.only(top: 50),
                                    child:
                                    Text
                                    (
                                      StringTable().Table![400026]!,
                                      style: TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ShopGoods(false),
              Padding
              (
                padding: const EdgeInsets.only(bottom: 20.0),
                child:
                Row
                (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    toggleButton(),
                    Padding
                    (
                      padding: EdgeInsets.only(bottom: 2),
                      child:
                      Text
                      (
                        StringTable().Table![400027]!,
                        style:
                        TextStyle
                        (
                          fontSize: 12, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
      ),
    );
  }

  Widget toggleButton()
  {
    return
    Transform.scale
    (
      scale: 0.7,
      child:
      CupertinoSwitch
      (
        value: UserData.to.autoPlay,
        activeColor: Color(0xFF00FFBF),
        onChanged: (bool? value) {
          setState(() {
            UserData.to.autoPlay = value ?? false;
          });
        },
      ),
    );
  }

  Widget episodeInfo()
  {
    return
    Visibility
    (
      visible: bottomUItype == Bottom_UI_Type.EPISODE,
      child:
      Container
      (
        //color: Colors.white,
        width: 390.w,
        padding: EdgeInsets.only(top: 20.h),
        child:
        Column
        (
          mainAxisAlignment: MainAxisAlignment.start,
          children:
          [
            episodeContentInfo(),
            Container
            (
              width: 390.w,
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
                  color: Colors.grey,
                  selectedColor: Colors.white,
                  children: <Widget>
                  [
                    for(int i = 0; i < episodeGroupList.length; ++i)
                      episodeGroup(episodeGroupList[i], episodeGroupSelections[i]),
                  ],
                  isSelected: episodeGroupSelections,
                  onPressed: (int index)
                  {
                    setState(()
                    {
                      episodeGroupScrollController.jumpTo(0);
                      for (int i = 0; i < episodeGroupSelections.length; ++i)
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
  }

  Widget episodeContentInfo()
  {
    return
    Container
    (
      child:
      Column
      (
        children:
        [
          Container
          (
            width: 390,
            padding: EdgeInsets.only(left: 20),
            //color: Colors.white,
            child:
            Text
            (
              episodeData!.title,
              style:
              TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
            ),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }

  Widget episodeWrap()
  {
    if (mapEpisodeData.isEmpty)
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
      Expanded
      (
        child:
        SingleChildScrollView
        (
          controller: episodeGroupScrollController,
          scrollDirection: Axis.vertical,
          child:
          Column
          (
            children:
            [
              Wrap
              (
                spacing: 10,
                direction: Axis.horizontal,  // 가로 방향으로 배치
                children: <Widget>
                [
                  for (var i = 0; i < list!.length; i++)
                    Container
                    (
                      height: 137,
                      width: MediaQuery.of(context).size.width / 5,
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
                              if(HttpProtocolManager.to.connecting)
                              {
                                return;
                              }

                              if (list[i].no > selectedEpisodeNo)
                              {
                                var value = list[i].no - selectedEpisodeNo;
                                if (value > 1)
                                {
                                  if (snackBarComplete == false)
                                  {
                                    print('snack bar retur');
                                    return;
                                  }

                                  snackBarComplete = false;

                                  ShowCustomSnackbar(StringTable().Table![300063]!, SnackPosition.TOP, ()
                                  {
                                    snackBarComplete = true;
                                  });

                                  return;
                                }
                              }

                              setState(()
                              {
                                bottomOffset = -844.h;
                                tweenTime = 0;
                              });

                              pagecontroller.nextPage();
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
                                    Stack
                                    (
                                      children:
                                      [
                                        list[i].thumbnailImg.isEmpty
                                            ? SizedBox() : Image.network(list[i].thumbnailImg, fit: BoxFit.cover,),
                                        Visibility
                                        (
                                          visible:list[i].no == episodeData!.no,
                                          child:
                                          Center
                                          (
                                            child:
                                            Container
                                            (
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.only(left: 3.5),
                                              width: 50,
                                              height: 50,
                                              decoration: ShapeDecoration(
                                                color: Colors.black.withOpacity(0.6),
                                                shape: OvalBorder(
                                                  side: BorderSide(
                                                    width: 1.50,
                                                    strokeAlign: BorderSide.strokeAlignCenter,
                                                    color: Color(0xFF00FFBF),
                                                  ),
                                                ),
                                              ),
                                              child: Icon(CupertinoIcons.pause_solid, size: 28, color: Colors.white,),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                  )
                                ),
                                Obx(()
                                {
                                  Episode episode = list[i];
                                  for(int i = 0; i < HomeData.to.listEpisode.length; ++i)
                                  {
                                    if (HomeData.to.listEpisode[i].id == episode.id)
                                    {
                                      //print('Find Episode complete id = ${episode.id} / owned : ${HomeData.to.listEpisode[i].owned}');
                                      if (episode.owned !=  HomeData.to.listEpisode[i].owned)
                                      {
                                        setState(() {
                                          episode.owned = HomeData.to.listEpisode[i].owned;
                                        });
                                      }
                                      break;
                                    }
                                  }

                                  return
                                    Visibility
                                    (
                                      visible: UserData.to.isSubscription.value == false && episode.isLock,
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
                                    );
                                  },
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
                              const TextStyle(fontSize: 11, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                            ),
                          ),
                        ],
                      ),
                      // 화면 너비의 1/4 크기로 설정
                      //child: Image.network('이미지 URL', fit: BoxFit.cover,),  // '이미지 URL' 부분을 실제 이미지 URL로 교체해야 합니다.
                    ),
                ],
              ),
              SizedBox(height: 20,),
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
}