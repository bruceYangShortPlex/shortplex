import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:shortplex/Util/ShortplexTools.dart';
import '../../Util/HttpProtocolManager.dart';
import '../../table/StringTable.dart';
import '../../table/UserData.dart';
import 'package:shortplex/Util/ShortsPlayer.dart';

class ReleasedContentsPage extends StatefulWidget {
  const ReleasedContentsPage({super.key});

  @override
  State<ReleasedContentsPage> createState() => _ReleasedContentsPageState();
}

class _ReleasedContentsPageState extends State<ReleasedContentsPage> with TickerProviderStateMixin, WidgetsBindingObserver
{
  var contentUrl = '';
  int selectedIndex = 0;
  List<ContentData> dataList = <ContentData>[];
  late AnimationController tweenController;
  bool controlUIVisible = false;
  double screentHeight = 0;

  void get_Datas()
  {
    try
    {
      HttpProtocolManager.to.Get_Preview().then((value)
      {
        if (value == null) {
          return;
        }

        for(var item in value.data!.items!)
        {
          var data = ContentData
          (
            id: item.id,
            title: item.title,
            imagePath: item.episode != null ? item.episode!.altImgUrlHd : '',
            cost: 0,
            releaseAt: item.previewStartAt ?? '',
            landScapeImageUrl: item.posterLandscapeImgUrl,
            rank: item.topten,
          );
          data.contentTitle = item.subtitle ?? '';
          data.description = item.description;
          data.contentUrl = item.episode != null ? item.episode!.episodeHd : '';
          data.thumbNail = item.thumbnailImgUrl;
          data.genre = item.genre;
          data.shareUrl = item.shareLink;
          data.episodeID = item.episode!.id;

          for(var info in item.stat!)
          {
            if (kDebugMode) {
              print('preview stat : ${item.stat!.length}');
            }

            if (kDebugMode)
            {
              print('preview stat info : ${info.amt} / action : ${info.action} / info.user_id  : ${info.user_id }');
            }

            if (info.user_id == UserData.to.userId && info.amt > 0 && info.action == Stat_Type.release_at.name)
            {
              data.isAlarmCheck = true;
              break;
            }
          }

          dataList.add(data);
        }

        setState(() {

        });
      });
    }
    catch(e)
    {
      print('GetContentData Catch $e');
    }
  }


  @override
  void initState()
  {
    get_Datas();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    tweenController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    tweenController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed)
    {
      buttonDisable = false;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return mainWidget(context);
  }

  Widget shortsPlay()
  {
    var height = (16/9)*261.w;
    var remainHeight = screentHeight - (height + 384);
    //print('height 1 = $height');
    return
    Container
    (
      width: 261.w,
      height: remainHeight >= 0 ? height : MediaQuery.of(context).size.height - 384,
      //color:Colors.grey,
      alignment: Alignment.center,
      child:
      ClipRRect
      (
        borderRadius: BorderRadius.circular(7),
        child:
        dataList.isNotEmpty ?
        AspectRatio
        (
            aspectRatio: 9/16,
            child:
            ShortsPlayer(shortsUrl: dataList[selectedIndex].contentUrl!,prevImage: dataList[selectedIndex].imagePath!, id: dataList[selectedIndex].episodeID)
        ) : SizedBox(),
      )
    );
  }

Widget mainWidget(BuildContext context)
{
  screentHeight = MediaQuery.of(context).size.height;
  return
  SafeArea
    (
    child:
    CupertinoApp
      (
      home:
      CupertinoPageScaffold
        (
        backgroundColor: Colors.black,
        child:
        Container
          (
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,
          //alignment: Alignment.center,
          //color: Colors.green,
          child:
          Row
            (
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children:
            [
              Column
                (
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  GestureDetector
                    (
                      onTap: () {
                        setState(() {
                          UserData.to.isOpenPopup.value = !UserData.to.isOpenPopup.value;
                          if (UserData.to.isOpenPopup.value) {
                            controlUIVisible = true;
                            tweenController.forward(from: 0);
                          }
                          else {
                            controlUIVisible = false;
                            tweenController.reverse();
                          }
                          //ui띄우고.
                        });
                      },
                      child:
                      Stack
                        (
                        alignment: Alignment.center,
                        children:
                        [
                          shortsPlay(),
                          FadeTransition
                            (
                            opacity: tweenController,
                            child:
                            IgnorePointer
                              (
                              ignoring: controlUIVisible == false,
                              child:
                              Container
                                (
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(left: 6),
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
                                  CupertinoIcons.play_arrow_solid, size: 40, color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                  SizedBox(height: 14),
                  contentInfo(),
                  //SizedBox(height: 10),
                ],
              ),
              SizedBox(width: 20,),
              contentSelector(),
            ],
          ),
        ),
      ),
    ),
  );
}

  int tweenTime = 0;
  Widget tweenAnimation(bool _play, Widget _widget)
  {
    return
    TweenAnimationBuilder
    (
      duration: Duration(milliseconds: tweenTime),
      tween: _play ? Tween<Offset>(begin: Offset(0, 0), end: Offset(-5, -5)) : Tween<Offset>(begin: Offset(-5, -5), end: Offset(0, 0)),
      builder: (context, offset, child)
      {
        return Transform.translate
        (
            offset: offset,
            child: _widget,
        );
      }
    );
  }

  Widget contentSelctItem(int _index, ContentData _data)
  {
    var date = DateTime.parse(_data.releaseAt!);
    var month = TranslateMonth(date.month);// SetTableStringArgument(200003, ['${date.month}',]);
    var day = TranslateDay(date.day); // SetTableStringArgument(200004, ['${date.day}',]);

    return
    Column
    (
      children:
      [
        Row
        (
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            Text
            (
              month,
              style:
              TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
            ),
            SizedBox(width: 5,),
            Text
            (
              day,
              style:
              TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
            ),
          ],
        ),
        SizedBox(height: 5,),
        GestureDetector
        (
          onTap: ()
          {
            if (selectedIndex == _index) {
              return;
            }

            tweenTime = 300;
            setState(()
            {
              selectedIndex = _index;
              if (kDebugMode) {
                print('selectedIndex : $selectedIndex');
              }
            });
          },
          child:
          Stack
          (
            children:
            [
              SvgPicture.asset
              (
                'assets/images/home/home_frame_bg.svg',
                width: 73.50,
                height: 112,
                fit: BoxFit.fill,
              ),
              tweenAnimation
              (
                selectedIndex == _index,
                Container
                (
                  width: 73.50,
                  height: 112,
                  decoration: ShapeDecoration(
                    color: Color(0xFFC4C4C4),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1.50,
                          color: selectedIndex == _index
                              ? Color(0xFF00FFBF)
                              : Colors.transparent),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child: Image.network(_data.thumbNail!),
                ),
              ),
            ],
          ),
          ),
        SizedBox(height: 10,),
      ],
    );
  }

  Widget contentSelector()
  {
    return
    Container
    (
      height: screentHeight,
      width: 95,
      //color: Colors.blue,
      alignment:  Alignment.bottomCenter,
      child:
      Container
      (
        height: screentHeight - 150.h,
        //color: Colors.red,
        child: ListView
        (
          scrollDirection: Axis.vertical,
          children:
          [
            //SizedBox(height: 10,),
            for(int i = 0 ; i < dataList.length; ++i)
              contentSelctItem(i, dataList[i]),
          ],
        ),
      ),
    );
  }

  bool buttonDisable = false;
  var prevRefreshCount= 0;

  Widget contentInfo()
  {
    if(dataList.length <= selectedIndex) {
      return SizedBox();
    }

    var data = dataList[selectedIndex];
    var title = data.title!;
    var date = data.GetReleaseDate();
    var totalEpisode = SetTableStringArgument(100022, ['999']);
    var genre = ConvertCodeToString(data.genre!);
    //var rank = data.rank ? StringTable().Table![500015]! : ''; // data.rank ? 'TOP10' : '';
    var description = data.description!;

    return
    // Expanded
    // (
    //   flex: 1,
    //   child:
      Container
      (
        width: 261.w,
        height: 190,
        decoration: ShapeDecoration(
          color: Color(0xFF1E1E1E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child:
        Padding
        (
          padding: const EdgeInsets.all(16),
          child:
          Column
          (
            mainAxisAlignment: MainAxisAlignment.start,
            children:
            [
              Container
              (
                alignment: Alignment.centerLeft,
                child:
                Text
                (
                  title,
                  style:
                  TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                ),
              ),
              SizedBox(height: 5,),
              Row
              (
                children:
                [
                  // Visibility
                  // (
                  //   visible: data.isNew,
                  //   child:
                  //   Container
                  //   (
                  //       width: 42,
                  //       height: 15,
                  //       //color: Colors.blue,
                  //       child:
                  //       Row
                  //       (
                  //         children:
                  //         [
                  //           SvgPicture.asset
                  //           (
                  //             'assets/images/home/main_new.svg',
                  //           ),
                  //           SizedBox(width: 11,),
                  //         ],
                  //       )
                  //   ),
                  // ),
                  // Visibility
                  // (
                  //   visible: data.rank,
                  //   child:
                  //   Container
                  //   (
                  //     width: 42,
                  //     height: 15,
                  //     //color: Colors.blue,
                  //     child:
                  //     Row
                  //     (
                  //       children:
                  //       [
                  //         SvgPicture.asset
                  //         (
                  //           'assets/images/home/main_top10.svg',
                  //         ),
                  //         SizedBox(width: 11,),
                  //       ],
                  //     )
                  //   ),
                  // ),
                  Container
                  (
                    height: 15,
                    //color: Colors.blue,
                    child:
                    Text
                    (
                      date,
                      style:
                      TextStyle(fontSize: 11, color: Colors.grey, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                    ),
                  ),
                  SizedBox(width: 11,),
                  Container
                  (
                    height: 15,
                    //color: Colors.blue,
                    child:
                    Text
                    (
                      //textAlign: TextAlign.center,
                      totalEpisode,
                      style:
                      TextStyle(fontSize: 11, color: Colors.grey, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                    ),
                  ),
                  SizedBox(width: 11,),
                  Container
                  (
                    height: 15,
                    //color: Colors.blue,
                    //alignment: Alignment.center,
                    child:
                    Text
                    (
                      genre,
                      style:
                      TextStyle(fontSize: 11, color: Colors.grey, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4,),
              Container
              (
                alignment: Alignment.centerLeft,
                height: 56,
                child:
                SingleChildScrollView
                (
                  child:
                  Text
                  (
                    description,
                    style:
                    const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'NotoSans', fontWeight: FontWeight.w500,),
                    // maxLines: 3,
                    // overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Row
              (
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children:
                [
                  GestureDetector
                  (
                    onTap: ()
                    {
                      //print('click content ID : ${data.id}');
                      if (buttonDisable) {
                        return;
                      }

                      var value = data.isAlarmCheck ? -1 : 1;
                      //print('data.isNotiCheck : ${data.isNotiCheck} / value : $value');
                      buttonDisable = true;
                      HttpProtocolManager.to.Send_Stat(data.id!, value, Comment_CD_Type.alarm, Stat_Type.release_at).then((value)
                      {
                        if (value == null)
                        {
                          buttonDisable = false;
                          return;
                        }

                        for(var item in value.data!)
                        {
                          //print('item.user_id : ${item.user_id}');
                          if (item.typeCd == Comment_CD_Type.alarm.name && item.user_id == UserData.to.userId && item.action == Stat_Type.release_at.name)
                          {
                            data.isAlarmCheck = item.amt > 0;
                            UserData.to.refreshCount++;
                            break;
                          }
                        }

                        buttonDisable = false;
                      },);
                    },
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
                            child:
                            Obx(()
                            {
                              if (UserData.to.refreshCount != prevRefreshCount)
                              {
                                prevRefreshCount = UserData.to.refreshCount.value;
                              }

                              return
                              Icon
                              (
                                  data.isAlarmCheck ? CupertinoIcons.bell_fill : CupertinoIcons.bell,
                                  size: 22, color:Colors.white
                              );
                            },),
                          ),
                          Padding
                          (
                            padding: const EdgeInsets.only(top: 18),
                            child: Text
                            (
                              StringTable().Table![200002]!,
                              style:
                              TextStyle(fontSize: 10, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  GestureDetector
                  (
                    onTap: ()
                    {
                      if(buttonDisable) {
                        return;
                      }

                      if (data.shareUrl!.isEmpty) {
                        return;
                      }

                      buttonDisable = true;
                      Share.share(data.shareUrl!);
                      if (kDebugMode) {
                        print('tap share');
                      }
                    },
                    child:
                    Container
                    (
                      //color: Colors.blue,
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
                            child: Icon(CupertinoIcons.share, size: 21, color:Colors.white),
                          ),
                          Padding
                          (
                            padding: const EdgeInsets.only(top: 18),
                            child: Text
                            (
                              StringTable().Table![100024]!,
                              style:
                              TextStyle(fontSize: 10, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      //),
    );
  }
}