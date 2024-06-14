import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shortplex/Util/ShortsPlayer.dart';
import 'package:shortplex/sub/ContentInfoPage.dart';
import 'package:get/get.dart';
import '../../table/StringTable.dart';
import '../../table/UserData.dart';

class FeaturedPage extends StatefulWidget
{
  const FeaturedPage({super.key});

  @override
  State<FeaturedPage> createState() => _FeaturedPageState();
}

class _FeaturedPageState extends State<FeaturedPage>
{
  List<Widget> pageList = <Widget>[];
  List<String> urlList = <String>[];
  List<FeaturedData> dataList = <FeaturedData>[];
  var currentIndex = 0;

  @override
  void initState()
  {
    super.initState();
    // pageList.add(VideoPage(url: "https://cdn.gro.care/ec12312256ad_1683524903074.mp4",));
    // pageList.add(VideoPage(url: "https://cdn.gro.care/4dc9fddff1c8_1683731818849.mp4",));
    // pageList.add(VideoPage(url: "https://cdn.gro.care/045e95f617aa_1683612715343.mp4",));
     pageList.add(ShortsPlayer(shortsUrl: "https://www.quadra-system.com/api/v1/vod/stream/EP1-fhd-1717993295708.mp4",));
    // pageList.add(ShortsPlayer(shortsUrl: "https://videos.pexels.com/video-files/6060027/6060027-uhd_2160_3840_25fps.mp4",));
    // pageList.add(ShortsPlayer(shortsUrl: "https://videos.pexels.com/video-files/17687288/17687288-uhd_2160_3840_30fps.mp4",));
     //pageList.add(_testWidget('1'));
     pageList.add(_testWidget('2'));
     pageList.add(_testWidget('3'));

    var data1 = FeaturedData();
    data1.title = '황후마마가 돌아왔다.1';
    data1.content = '사청과 부명수의 계략으로 억울한 죽음을 맞이한 사음, 환생 후 부명수와의 혼례 한 달 전으로 돌아오게 된다...';
    dataList.add(data1);
    var data2 = FeaturedData();
    data2.title = 'abc';
    data2.content = 'bbbb';
    dataList.add(data2);
    var data3 = FeaturedData();
    data3.title = 'ccc';
    data3.content = 'dddd';
    dataList.add(data3);

    // urlList =
    // [
    //   "https://videos.pexels.com/video-files/17687288/17687288-uhd_2160_3840_30fps.mp4",
    //   "https://videos.pexels.com/video-files/6060027/6060027-uhd_2160_3840_25fps.mp4",
    //   "https://videos.pexels.com/video-files/17687288/17687288-uhd_2160_3840_30fps.mp4"
    // ];

    for(int i = 0; i < 10; ++i)
    {
      var contentsData = ContentData(id: '$i', imagePath: '', title: '배포할 내용', cost: i, releaseAt: '', landScapeImageUrl: '', rank: false);
      contentsData.isNew = false;
      contentsData.isWatching = true;
      contentsData.watchingEpisode = i; //SetTableStringArgument(100010, ['1', '72']);
    }
  }

  @override
  void dispose()
  {
    pageList.clear();
    urlList.clear();
    dataList.clear();
    super.dispose();
  }

  Widget _testWidget(String _title)
  => Container
  (
      alignment: Alignment.center,
      color: Colors.green,
      child:
      AspectRatio
      (
        aspectRatio: 9 / 16,
        child:
        Container
        (
          alignment: Alignment.center,
          color: Colors.red,
          child: Text(_title),
        ),
      ),
  );

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
            child:
            Stack
            (
              alignment: Alignment.center,
              children:
              [
                CarouselSlider
                (
                  options: CarouselOptions
                  (
                    onPageChanged: (index, reason)
                    {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    aspectRatio: 9 / 16,
                    viewportFraction: 1,
                    //enlargeCenterPage: true,
                    scrollDirection: Axis.vertical,
                    //autoPlay: true,
                  ),
                  items: pageList,
                ),
                Align
                (
                  alignment: Alignment.bottomCenter,
                  child:
                  Container
                  (
                    width: MediaQuery.of(context).size.width,
                    height: 125,
                    color: Colors.transparent,
                    child:
                    GestureDetector
                    (
                      onTap: ()
                      {
                        Get.to(()=> ContentInfoPage(), arguments: dataList[currentIndex]);
                      },
                      child:
                      Row
                      (
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          Expanded
                          (
                            flex: 1,
                            child:
                            Container
                            (
                              height: 100,
                              color: Colors.white,
                            ),
                          ),
                          Expanded
                          (
                            flex: 2,
                            child:
                            Container
                            (
                              height: 100,
                              //color: Colors.grey,
                              child:
                              Column
                              (
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                [
                                  Text
                                  (
                                    dataList[currentIndex].title,
                                    style:
                                    TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                                  ),
                                  Container
                                  (
                                    //color: Colors.grey,
                                    width: 245.w,
                                    child:
                                    Text
                                    (
                                      dataList[currentIndex].content,
                                      style:
                                      TextStyle(fontSize: 11, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w500,),
                                    ),
                                  ),
                                  Align
                                  (
                                    alignment: Alignment.bottomRight,
                                    child:
                                    Padding
                                    (
                                      padding: const EdgeInsets.only(bottom:15, right: 20),
                                      child: Container
                                      (
                                        alignment: Alignment.center,
                                        width: 73,
                                        height: 20,
                                        padding: EdgeInsets.only(bottom: 3),
                                        decoration:
                                        ShapeDecoration
                                        (
                                          color: Colors.black54,
                                            shape:
                                            RoundedRectangleBorder
                                            (
                                              side: BorderSide(width: 1.50, color: Colors.grey),
                                              borderRadius: BorderRadius.circular(20),
                                             ),
                                          ),
                                        child:
                                        Text
                                        (
                                          StringTable().Table![100006]!,
                                          style:
                                          TextStyle(fontSize: 11, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                                        ),
                                      ),
                                    )
                                  ),
                                ],
                              ),
                            )
                          )
                        ],
                      ),
                    ),

                  ),
                ),
              ],
            ),
          ),
    ),
  );
}

class FeaturedData
{
  String iconPath = '';
  String title = '';
  String content = '';
  int id = 0;
}

