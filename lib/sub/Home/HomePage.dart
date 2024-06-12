import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shortplex/sub/ContentInfoPage.dart';
import 'package:shortplex/sub/Home/HomeData.dart';
import 'package:shortplex/sub/Home/SearchPage.dart';

import '../../Network/HomeData_Res.dart';
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
  var themesList = <List<ContentData>>[];

  var pageIndex = 0;

  Future GetHomeData() async
  {
    pageList = HomeData.to.pageList;
    watchingContentsDataList = HomeData.to.watchingContentsDataList;
    rankContentsDataList = HomeData.to.rankContentsDataList;
    themesList = HomeData.to.themesList;

    try
    {
      Get.lazyPut(() => HttpProtocolManager());
      await HttpProtocolManager.to.get_HomeData().then((value)
      {
        var homeData = value;
        if(homeData == null) {
          return;
        }

        pageList.clear();
        watchingContentsDataList.clear();
        rankContentsDataList.clear();
        themesList.clear();

        for(var item in homeData.data!.content!)
        {
          //대문 page
          if (HomeDataType.featured.toString().contains(item.code.toString()))
          {
            for (int i = 0 ; i < item.items!.length; ++i)
            {
              var listitem = item.items![i];
              var data = ContentData
              (
                  id: listitem.id,
                  title: item.title,
                  imagePath: listitem.posterPortraitImgUrl,
                  cost: 0,
                  releaseAt: listitem.releaseAt,
                  landScapeImageUrl: listitem.posterLandscapeImgUrl
              );

              data.contentTitle = listitem.title;
              pageList.add(data);
            }

            continue;
          }

          //시청중
          if (HomeDataType.watch.toString().contains(item.code.toString()))
          {
            for (int i = 0 ; i < item.items!.length; ++i)
            {
              var listitem = item.items![i];

              var data = ContentData
              (
                  id: listitem.id,
                  title: item.title,
                  imagePath: listitem.thumbnailImgUrl,
                  cost: 0,
                  releaseAt: listitem.releaseAt,
                  landScapeImageUrl: listitem.posterLandscapeImgUrl
              );
              data.contentTitle = listitem.title;
              data.isWatching = true;
              data.watchingEpisode = '';
              watchingContentsDataList.add(data);
            }

            continue;
          }

          //top10
          if (HomeDataType.top.toString().contains(item.code.toString()))
          {
            //대문 리스트.
            for (int i = 0 ; i < item.items!.length; ++i)
            {
              if (rankContentsDataList.length > 9)
                break;

              var listitem = item.items![i];
              var data = ContentData
              (
                  id: listitem.id,
                  title: item.title,
                  imagePath: listitem.thumbnailImgUrl,
                  cost: 0,
                  releaseAt: listitem.releaseAt,
                  landScapeImageUrl: listitem.posterLandscapeImgUrl
              );
              data.contentTitle = listitem.title;
              data.rank = i;
              rankContentsDataList.add(data);
            }

            continue;
          }

          var list = <ContentData>[];
          for (int i = 0 ; i < item.items!.length; ++i)
          {
            var listitem = item.items![i];
            var data = ContentData
            (
                id: listitem.id,
                title: item.title,
                imagePath: listitem.thumbnailImgUrl,
                cost: 0,
                releaseAt: listitem.releaseAt,
                landScapeImageUrl: listitem.posterLandscapeImgUrl
            );
            data.contentTitle = listitem.title;
            data.isNew = HomeDataType.recent.toString().contains(item.code.toString());
            list.add(data);
          }
          themesList.add(list);
        }

        setState(() {

        });

        HomeData.to.SetPageList(pageList);
        HomeData.to.SetWatchList(watchingContentsDataList);
        HomeData.to.SetRankList(rankContentsDataList);
        HomeData.to.SetThemesList(themesList);
      });
    }
    catch(e)
    {
      print('GetHomeData error : $e');
    }
  }

  // Future GetContentList(HomeDataType _type) async
  // {
  //   try
  //   {
  //     Get.lazyPut(() => HttpProtocolManager());
  //     var type = HomeDataType.top.toString().replaceAll('SearchType.', '');
  //     var url = 'https://www.quadra-system.com/api/v1/home/$type?page=0&itemPerPage=20';
  //     await HttpProtocolManager.to.get_SearchData(url).then((value)
  //     {
  //       var searchData = value;
  //       if(searchData == null) {
  //         return;
  //       }
  //
  //       for(int i = 0; i < searchData.data.items.length; ++i)
  //       {
  //         var item = searchData.data.items[i];
  //         var data = ContentData(id: item.id, title: item.title, imagePath: item.posterPortraitImgUrl, cost: 0);
  //
  //         data.rank = _type == HomeDataType.top ? i : 0;
  //         data.isWatching = _type == HomeDataType.watch;
  //         data.isLock = false;
  //         data.isNew = _type == HomeDataType.recent;
  //       }
  //     });
  //   }
  //   catch (error)
  //   {
  //     if (kDebugMode) {
  //       print(error);
  //     }
  //   }
  // }

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
                          const TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  contentsView(watchingContentsDataList),
                  rankContentView(rankContentsDataList),
                  for(var item in themesList)
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
      child: Container
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
        print(pageIndex);
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
        child: Image.network(_data.imagePath!, fit: BoxFit.fill,),
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
                        print(_list[i].id);
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
                                decoration: ShapeDecoration
                                (
                                  color: Colors.black, // Color(0xFFC4C4C4),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                ),
                                child: Image.network(_list[i].imagePath!, fit: BoxFit.fill,),
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

  Widget contentItem(ContentData _data)
  {
    return
    Padding
    (
      padding: const EdgeInsets.only(right: 10),
      child:
      Column
      (
        children:
        [
          GestureDetector
          (
            onTap: ()
            {
              if (_data.isWatching)
              {
                print(_data.id);
                print('go to content player');
                Get.to(() => ContentPlayer(), arguments: _data.id);
              }
              else
              {
                print('go to info page');
                print(_data.id);
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
                  decoration: ShapeDecoration
                  (
                    color: Colors.black, // Color(0xFFC4C4C4),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                  ),
                  child: Image.network(_data.imagePath!, fit: BoxFit.fill,),
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
                    visible: _data.rank != 0,
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
                      _data.watchingEpisode ?? '',
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
                      print(_data.id);
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