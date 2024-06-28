import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shortplex/Util/ShortsPlayer.dart';
import 'package:shortplex/sub/ContentInfoPage.dart';
import 'package:get/get.dart';
import '../../Util/HttpProtocolManager.dart';
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
  List<ContentData> dataList = <ContentData>[];
  var currentIndex = 0;

  @override
  void initState()
  {
    get_Datas();
    super.initState();
  }

  void get_Datas()
  {
    try
    {
      HttpProtocolManager.to.Get_Recommended().then((value)
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
              imagePath: item.episode != null ? item.episode!.altImgUrlHd! : '',
              cost: 0,
              releaseAt: item.releaseAt ?? '',
              landScapeImageUrl: item.posterLandscapeImgUrl,
              rank: item.topten,
            );
            data.isNew = false;
            data.contentTitle = item.subtitle ?? '';
            data.description = item.description;
            data.contentUrl = item.episode != null ? item.episode!.episodeHd : '';
            data.thumbNail = item.thumbnailImgUrl;

            pageList.add(ShortsPlayer(shortsUrl: data.contentUrl!,prevImage: data.imagePath!));

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
  void dispose()
  {
    pageList.clear();
    dataList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return mainWidget(context);
  }

  Widget mainWidget(BuildContext context)
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
            backgroundColor: Colors.black,
            child:
            dataList.length == 0 ?
            SizedBox() :
            Stack
            (
              alignment: Alignment.center,
              children:
              [
                CarouselSlider
                (
                  options:
                  CarouselOptions
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
                    //height: MediaQuery.of(context).size.height,
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 134.h,
                    // decoration: BoxDecoration(
                    //   gradient: LinearGradient(
                    //     begin: Alignment(0, -1),
                    //     end: Alignment(0, 1),
                    //     colors: [Colors.transparent, Colors.black],
                    //   ),
                    //   //border: Border.all(width: 1),
                    // ),
                    color: Colors.black54,
                    child:
                    GestureDetector
                    (
                      onTap: ()
                      {
                        if (dataList.length < currentIndex) {
                          return;
                        }
                        UserData.to.isOpenPopup.value = true;
                        Get.to(() => ContentInfoPage(),
                            arguments: dataList[currentIndex]);
                      },
                      child:
                      Row
                      (
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          Expanded
                          (
                            flex: 2,
                            child:

                            Container
                            (
                              height: 130.h,
                              alignment: Alignment.center,
                              //color: Colors.white,
                              padding: EdgeInsets.only(bottom: 26),
                              child:
                              dataList.length >= currentIndex
                              ?
                              SizedBox
                              (
                                height: 100,
                                width: 70,
                                child:
                                ClipRRect
                                (
                                  borderRadius: BorderRadius.circular(7),
                                  child: Image.network(dataList[currentIndex].thumbNail!, fit: BoxFit.cover,),
                                ),
                              )
                              :
                              SizedBox(),
                            ),
                          ),
                          Expanded
                            (
                              flex: 5,
                              child:
                              Container
                              (
                                height: 130.h,
                                //color: Colors.grey,
                                child:
                                Column
                                  (
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:
                                  [
                                    Text
                                      (
                                      dataList.length >= currentIndex
                                          ? dataList[currentIndex].title!
                                          : '',
                                      style:
                                      TextStyle(fontSize: 16,
                                        color: Colors.white,
                                        fontFamily: 'NotoSans',
                                        fontWeight: FontWeight.bold,),
                                    ),
                                    SizedBox(height: 3,),
                                    Expanded(
                                      child: Container
                                        (
                                        //color: Colors.grey,
                                        width: 270.w,
                                        child:
                                        Text
                                          (
                                          dataList.length >= currentIndex
                                              ? dataList[currentIndex]
                                              .description!
                                              : '',
                                          style:
                                          TextStyle(fontSize: 11,
                                            color: Colors.white,
                                            fontFamily: 'NotoSans',
                                            fontWeight: FontWeight.w500,),
                                        ),
                                      ),
                                    ),
                                    Align
                                    (
                                        alignment: Alignment.bottomRight,
                                        child:
                                        Padding
                                        (
                                          padding: const EdgeInsets.only(
                                              bottom: 10, right: 20),
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
                                                side: BorderSide(width: 1.50,
                                                    color: Colors.grey),
                                                borderRadius: BorderRadius
                                                    .circular(20),
                                              ),
                                            ),
                                            child:
                                            Text
                                              (
                                              StringTable().Table![100006]!,
                                              style:
                                              TextStyle(fontSize: 11,
                                                color: Colors.white,
                                                fontFamily: 'NotoSans',
                                                fontWeight: FontWeight.bold,),
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
}


