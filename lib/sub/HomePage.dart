import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shortplex/sub/SearchPage.dart';

import '../table/UserData.dart';
import 'ContentPlayer.dart';

class HomePage extends StatefulWidget
{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  List<Widget> pageList = <Widget>[];
  List<String> homePageViewTitle = <String>[];
  var homeContentsDataList = <ContentData>[];
  var rankContentsDataList = <ContentData>[];
  var pageIndex = 0;
  var tweenInitBlock = true;

  @override
  void initState()
  {
    super.initState();
    print('init');

    pageIndex = 0;

    for(int i = 0; i < 10; ++i)
    {
      pageList.add(topPageItem());
      homePageViewTitle.add(i.toString());

      var contentsData = ContentData(id: i, imagePath: '', title: '배포할 내용', cost: i);
      contentsData.isNew = false;
      contentsData.isWatching = true;
      contentsData.watchingEpisode = '1/77화'; //SetTableStringArgument(100010, ['1', '72']);
      contentsData.rank = 0;
      homeContentsDataList.add(contentsData);
      contentsData.rank = i + 1;
      rankContentsDataList.add(contentsData);
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('change');
    // var seleect = Get.find<RootBottomNavgationBarController>().selectedIndex.value;
    // print('select : ${seleect}' );
  }

  // @override
  // void didUpdateWidget(covariant HomePage oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   super.didUpdateWidget(oldWidget);
  //   print('update : oldWidget = ${oldWidget.reactive}, current : ${widget}');
  // }

  // @override
  // void deactivate() {
  //   // TODO: implement deactivate
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
    pageList.clear();
    homePageViewTitle.clear();
    homeContentsDataList.clear();
    rankContentsDataList.clear();
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
                          homePageViewTitle[pageIndex],
                          style:
                          const TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  contentsView(homeContentsDataList),
                  rankContentView(rankContentsDataList),
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
        CarouselSlider
        (
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
          items: pageList,
        ),
      ),
    );
  }

  Widget topPageItem()
  {
    return
    GestureDetector
    (
      onTap: ()
      {
        print(pageIndex);
      },
      child: Container
      (
        width: 260,
        height: 410,
        decoration: ShapeDecoration(
        color: Color(0xFFC4C4C4),
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        ),
        ),
      ),
    );
  }

  Widget contentsView(List<ContentData> _list, [bool _buttonVisible = false])
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
          Row
          (
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
            [
              Text
              (
                _list[0].title!,
                style:
                const TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
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
            const TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
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
                    Container
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
                          GestureDetector
                          (
                            onTap: ()
                            {
                              print(_list[i].id);
                            },
                            child: Padding
                            (
                              padding: const EdgeInsets.only(left: 65),
                              child: Container
                              (
                                width: 105,
                                height: 160,
                                decoration: ShapeDecoration
                                  (
                                  color: Color(0xFFC4C4C4),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                ),
                              ),
                            ),
                          ),
                        ],
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
              if (_data.isWatching!)
              {
                print(_data.id);
                print('go to content player');
                Get.to(() => ContentPlayer(), arguments: _data);
              }
              else
              {
                print('go to info page');
                print(_data.id);
              }
            },
            child:
            Stack
            (
              alignment: _data.isWatching! ? Alignment.center : Alignment.topRight,
              children:
              [
                Container
                (
                  width: 105,
                  height: 160,
                  decoration: ShapeDecoration
                  (
                    color: Color(0xFFC4C4C4),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                  ),
                ),
                Visibility
                (
                  visible: _data.isWatching!,
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
                  visible: _data.isNew!,
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
                      const TextStyle(fontSize: 8, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
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
            visible: _data.isWatching!,
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
                      _data.watchingEpisode!,
                      style:
                      const TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
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