import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shortplex/sub/ContentInfoPage.dart';
import 'package:shortplex/sub/Home/HomeData.dart';
import 'package:shortplex/sub/Home/SearchPage.dart';

import '../../Network/Content_Res.dart';
import '../../Network/HomeData_Res.dart';
import '../../Network/Home_Content_Res.dart';
import '../../Util/HttpProtocolManager.dart';
import '../../table/UserData.dart';
import '../ContentPlayer.dart';

class HomePage extends StatefulWidget
{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  var pageList = <ContentData>[];
  var watchingContentsDataList = <ContentData>[];
  var rankContentsDataList = <ContentData>[];
  var recentList = <ContentData>[];
  Map<String, List<ContentData>> themesList = {};
  var pageIndex = 0;

  void GetHomeData() async
  {
    pageList = HomeData.to.pageList;
    watchingContentsDataList = HomeData.to.watchingContentsDataList;
    recentList = HomeData.to.recentList;
    rankContentsDataList = HomeData.to.rankContentsDataList;
    themesList = HomeData.to.themesList;

    try
    {
      Get.lazyPut(() => HttpProtocolManager());

      HttpProtocolManager.to.get_HomeContentData(HomeDataType.featured, 0, 20).then((value)
      {
        pageList.clear();
        for (var item in value!.data!.items!)
        {
          var data = ContentData
          (
              id: item.id,
              title: value.data!.title,
              imagePath: item.posterPortraitImgUrl,
              cost: 0,
              releaseAt: item.releaseAt ?? '',
              landScapeImageUrl: item.posterLandscapeImgUrl,
              rank: item.topten,
          );

          data.contentTitle = item.subtitle ?? '';
          pageList.add(data);
        }

        setState(() {

        });
      });

      HttpProtocolManager.to.get_HomeContentData(HomeDataType.top, 0, 20).then((value)
      {
        rankContentsDataList.clear();
        for (var item in value!.data!.items!)
        {
          var data = ContentData
          (
            id: item.id,
            title: value.data!.title ?? '타이틀 없음',
            imagePath: item.posterPortraitImgUrl,
            cost: 0,
            releaseAt: item.releaseAt ?? '',
            landScapeImageUrl: item.posterLandscapeImgUrl,
            rank: item.topten,
          );

          data.contentTitle = item.subtitle ?? '';
          rankContentsDataList.add(data);
        }

        setState(() {

        });
      });

      HttpProtocolManager.to.get_HomeContentData(HomeDataType.watch, 0, 20).then((value)
      {
        watchingContentsDataList.clear();
        for (var item in value!.data!.items!)
        {
          var data = ContentData
          (
            id: item.content_id,
            title: value.data!.title,
            imagePath: item.posterPortraitImgUrl,
            cost: 0,
            releaseAt: item.releaseAt ?? '',
            landScapeImageUrl: item.posterLandscapeImgUrl,
            rank: item.topten,
          );
          data.isWatching = true;
          data.watchingEpisode = item.no;
          data.contentTitle = item.subtitle ?? '';
          watchingContentsDataList.add(data);
        }
        setState(() {

        });
      });

      HttpProtocolManager.to.get_HomeContentData(HomeDataType.recent, 0, 20).then((value)
      {
        recentList.clear();
        for (var item in value!.data!.items!)
        {
          var data = ContentData
          (
            id: item.id,
            title: value.data!.title,
            imagePath: item.posterPortraitImgUrl,
            cost: 0,
            releaseAt: item.releaseAt ?? '',
            landScapeImageUrl: item.posterLandscapeImgUrl,
            rank: item.topten,
          );
          data.isNew = true;
          data.contentTitle = item.subtitle ?? '';
          recentList.add(data);
        }
        setState(() {

        });
      });

      HttpProtocolManager.to.get_HomeContentData(HomeDataType.activethemes, 0, 100).then((value)
      {
        for(var themse in value!.data!.items!)
        {
          if (themesList.containsKey(themse.id))
          {
            continue;
          }

          HttpProtocolManager.to.get_HomeContentData(HomeDataType.themes, 0, 20, themse.id!).then((result)
          {
            var list = <ContentData>[];
            for (var item in result!.data!.items!)
            {
              var data = ContentData
              (
                id: item.id,
                title: item.theme_title ?? '',
                imagePath: item.posterPortraitImgUrl,
                cost: 0,
                releaseAt: item.releaseAt ?? '',
                landScapeImageUrl: item.posterLandscapeImgUrl,
                rank: item.topten,
              );

              data.contentTitle = item.subtitle ?? '';
              list.add(data);
            }
            themesList[themse.id!] = list;
            setState(() {

            });
          });
        }
      });

      HomeData.to.SetPageList(pageList);
      HomeData.to.SetWatchList(watchingContentsDataList);
      HomeData.to.SetRankList(rankContentsDataList);
      HomeData.to.SetThemesList(themesList);
      HomeData.to.SetRecentList(recentList);
    }
    catch(e)
    {
      print('GetHomeData error : $e');
    }
  }


  Future<List<Episode>?> GetEpisodeData(String _contentID) async
  {
    List<Episode> contentEpisodes = <Episode>[];
    try
    {
      await HttpProtocolManager.to.get_ContentData(_contentID).then((value) async
      {
        var contentRes = value;
        contentEpisodes.addAll(contentRes!.data!.episode!);
        int totalEpisodeCount = contentRes.data!.episodeTotal;

        for(int i = 1 ; i <= contentRes.data!.episodeMaxpage; ++i)
        {
          await HttpProtocolManager.to.get_EpisodeGroup(_contentID, i).then((value)
          {
            contentEpisodes.addAll(value!.data!.episode!);
            if (contentEpisodes.length == totalEpisodeCount)
            {
              print('episode list add complete ${contentEpisodes.length}');
              return contentEpisodes;
            }
          });
        }
      });
    }
    catch(e)
    {
      print('GetEpisodeData Catch $e');
    }

    return contentEpisodes;
  }

  @override
  void initState()
  {
    super.initState();

    pageIndex = 0;

    Get.lazyPut(()=> HomeData());

    GetHomeData();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  // }

  // @override
  // void didUpdateWidget(covariant HomePage oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   print('update : oldWidget = ${oldWidget.reactive}, current : ${widget}');
  // }

  // @override
  // void deactivate() {
  //   super.deactivate();
  //   print('deactive');
  // }

  // @override
  // void activate()
  // {
  //   super.activate();
  //   print('activate');
  // }

  @override
  void dispose()
  {
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return
    CupertinoApp
    (
      home:
      CupertinoPageScaffold
      (
        backgroundColor: Colors.black,
        navigationBar:
          CupertinoNavigationBar
          (
            backgroundColor: Colors.black.withOpacity(0.85),
            leading:
            Center
            (
              child: Container
              (
                width: 390,
                height: 50,
                //color: Colors.blue,
                child:
                Row
                (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                  [
                    Image.asset('assets/images/main/shortplex.png', width: 24, height: 30,),
                    Padding
                    (
                      padding: const EdgeInsets.only(right: 8.0),
                      child:
                      IconButton
                      (
                        onPressed: ()
                        {
                          Get.to(() => SearchPage());
                        },
                        icon: Icon(CupertinoIcons.search), iconSize: 30,color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
        child:
        SingleChildScrollView
        (
          scrollDirection: Axis.vertical,
          child:
          Padding
          (
            padding: EdgeInsets.only(top: 80),
            child: Center
            (
              child:
              Column
              (
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>
                [
                  Stack
                  (
                    alignment: Alignment.bottomCenter,
                    children:
                    [
                      homPageView(),
                      Container
                      (
                        height: 70,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0, -1),
                            end: Alignment(0, 1),
                            colors: [Colors.transparent, Colors.black],
                          ),
                          //border: Border.all(width: 1),
                        ),
                      ),
                      Padding
                      (
                        padding: EdgeInsets.only(bottom: 8.0),
                        child:
                        Text
                        (
                          pageList.length != 0 && pageIndex < pageList.length ?
                          pageList[pageIndex].contentTitle! : '',
                          style:
                          const TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  contentsView(watchingContentsDataList),
                  rankContentView(rankContentsDataList),
                  contentsView(recentList),
                  for(var item in themesList.values)
                    contentsView(item),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget homPageView()
  {
    return
    Padding
    (
      padding: const EdgeInsets.only(top: 10),
      child:
      Container
      (
        width: 390,
        height: 410,
        //color: Colors.green,
        child:
        CarouselSlider.builder
        (
          itemCount: pageList.length,
          itemBuilder: (context, index, realIndex)
          {
            var widget = pageList.length != 0 && index < pageList.length ? topPageItem(pageList[index]) : Container();
            return widget;
          },
          options:
          CarouselOptions
          (
            enlargeFactor: 0.2,
            enlargeCenterPage: true,
            viewportFraction: 0.7,
            height: 410,
            autoPlay: true,
            //aspectRatio: 1.0,
            initialPage: 0,
            onPageChanged: (index, reason)
            {
              setState(()
              {
                pageIndex = index;
              });
            },
          ),
          //items: pageList,
        ),
      ),
    );
  }

  Widget topPageItem(ContentData _data)
  {
    return
    GestureDetector
    (
      onTap: ()
      {
        Get.to(()=> ContentInfoPage(), arguments: _data);
        print('pageIndex : $pageIndex');
      },
      child: Container
      (
        width: 260,
        height: 410,
        decoration: ShapeDecoration(
        color: Colors.black,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        ),
        ),
        child:
        ClipRRect
        (
          borderRadius: BorderRadius.circular(10),
          child:
          Image.network(_data.imagePath!, fit: BoxFit.cover,)
        ),
      ),
    );
  }

  Widget contentsView(List<ContentData> _list, [bool _buttonVisible = false])
  {
    if (_list.isEmpty) {
      return SizedBox();
    }

    return
    SizedBox
    (
      width: 390,
      child:
      Column
      (
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Row
          (
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
            [
              Text
              (
                _list[0].title!,
                style:
                const TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
              ),
              SizedBox(height: 10,),
              SizedBox
              (
                width: 40,
                child:
                Visibility
                (
                  visible: _buttonVisible,
                  child:
                  IconButton
                  (
                    alignment: Alignment.center,
                    color: Colors.white,
                    iconSize: 20,
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: ()
                    {
                      print('Click Move All Contents');
                    }
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          SingleChildScrollView
          (
            scrollDirection: Axis.horizontal,
            child:
            Row
            (
              mainAxisAlignment: MainAxisAlignment.start,
              children:
              [
                for(var item in _list)
                  contentItem(item),
              ],
            ),
          ),
          SizedBox(height: 30,),
        ],
      ),
    );
  }

  Widget rankContentView(List<ContentData> _list)
  {
    if (_list.length == 0)
      return SizedBox();

    return
    Container
    (
      width: 390,
      child:
      Column
      (
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Text
          (
            _list[0].title!,
            style:
            const TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
          ),
          SizedBox(height: 10,),
          SingleChildScrollView
          (
            scrollDirection: Axis.horizontal,
            child:
            Row
            (
              mainAxisAlignment: MainAxisAlignment.start,
              children:
              [
                for(int i = 0; i < _list.length; ++i)
                  Padding
                  (
                    padding: EdgeInsets.only(right: 5),
                    child:
                    GestureDetector
                    (
                      onTap: ()
                      {
                        Get.to(()=> ContentInfoPage(), arguments: _list[i]);
                        //print(_list[i].id);
                      },
                      child: Container
                      (
                        width: 180,
                        height: 160,
                        //color: Colors.grey,
                        alignment: Alignment.centerRight,
                        child:
                        Stack
                        (
                          children:
                          [
                            Padding
                            (
                              padding: const EdgeInsets.only(left: 75),
                              child: SvgPicture.asset
                              (
                                'assets/images/home/home_frame_bg.svg',
                                width: 180,
                                height: 160,
                              ),
                            ),
                            SvgPicture.asset
                            (
                              'assets/images/home/home_text ${i + 1}.svg',
                              width: 180,
                              height: 160,
                            ),
                            Padding
                            (
                              padding: const EdgeInsets.only(left: 65),
                              child:
                              Container
                              (
                                width: 105,
                                height: 160,
                                // decoration: ShapeDecoration
                                // (
                                //   color: Colors.black, // Color(0xFFC4C4C4),
                                //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                // ),
                                child:
                                ClipRRect
                                (
                                  borderRadius: BorderRadius.circular(7),
                                  child:
                                  _list[i].imagePath != null ?
                                  Image.network(_list[i].imagePath!, fit: BoxFit.cover,) : Container(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 30,),
        ],
      ),
    );
  }

  bool buttonEnable = true;
  Widget contentItem(ContentData _data)
  {
    return
    Padding
    (
      padding: const EdgeInsets.only(right: 15),
      child:
      Column
      (
        children:
        [
          GestureDetector
          (
            onTap: () async
            {
              if (buttonEnable == false)
                return;

              if (_data.isWatching)
              {
                buttonEnable = false;
                try
                {
                  GetEpisodeData(_data.id!).then((value)
                  {
                    print('_data.watchingEpisode : ${_data
                        .watchingEpisode} / episode length : ${value?.length}');
                    Get.to(() => ContentPlayer(),
                        arguments: [_data.watchingEpisode, value]);
                    buttonEnable = true;
                  },);
                }
                catch(e)
                {
                  buttonEnable = true;
                  print('Get.to(() => ContentPlayer() error $e');
                }
              }
              else
              {
                print('go to info page');
                //print(_data.id);
                Get.to(() => const ContentInfoPage(), arguments: _data);
              }
            },
            child:
            Stack
            (
              alignment: _data.isWatching ? Alignment.center : Alignment.topRight,
              children:
              [
                Container
                (
                  width: 105,
                  height: 160,
                  // decoration: ShapeDecoration
                  // (
                  //   color: Colors.black, // Color(0xFFC4C4C4),
                  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                  // ),
                  child:
                  ClipRRect
                  (
                    borderRadius: BorderRadius.circular(7),
                    child:
                    _data.imagePath == null || _data.imagePath!.isEmpty ? SizedBox() : Image.network(_data.imagePath!, fit: BoxFit.cover,),
                  )
                ),
                Visibility
                (
                  visible: _data.isWatching,
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
                    child: Icon(CupertinoIcons.play_arrow_solid, size: 28, color: Colors.white,),
                  ),
                ),
                Visibility
                (
                  visible: _data.isNew,
                  child:
                  Container
                  (
                    width: 29,
                    height: 14,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration
                    (
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.80, color: Color(0xFF00FFBF)),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    child:
                    Text
                    (
                      'NEW',
                      style:
                      const TextStyle(fontSize: 8, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                    ),
                  ),
                ),
                Padding
                (
                  padding: const EdgeInsets.only(top: 160 - 42, right: 105 - 42),
                  child:
                  Visibility
                  (
                    visible: _data.rank,
                    child:
                    Container
                    (
                      //alignment: Alignment.center,
                      //width: 42,height: 42, color: Colors.red,
                      child: SvgPicture.asset('assets/images/home/home_frame.svg', fit: BoxFit.contain,),
                    )
                  ),
                ),
              ],
            ),
          ),
          Visibility
          (
            visible: _data.isWatching,
            child:
            SizedBox
            (
              width: 105,
              child:
              Row
              (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                [
                  Padding
                  (
                    padding: const EdgeInsets.only(left: 6, bottom: 2.1),
                    child:
                    Text
                    (
                      _data.watchingEpisode != null ? _data.watchingEpisode.toString() : '',
                      style:
                      const TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                    ),
                  ),
                  IconButton
                  (
                    alignment: Alignment.center,
                    padding: EdgeInsets.zero,
                    iconSize: 16,
                    onPressed: ()
                    {
                      print('go to info page');
                      //print(_data.id);
                    },
                    icon: Icon(CupertinoIcons.info), color: Colors.white,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}