import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shortplex/Util/ShortsPlayer.dart';
import '../table/StringTable.dart';

// void main() async
// {
//   WidgetsFlutterBinding.ensureInitialized();
//   await StringTable().InitTable();
//   runApp(ReleasedContentsPage());
// }

class ReleasedContentsPage extends StatefulWidget {
  const ReleasedContentsPage({super.key});

  @override
  State<ReleasedContentsPage> createState() => _ReleasedContentsPageState();
}

class _ReleasedContentsPageState extends State<ReleasedContentsPage>
{
  var contentUrl = '';
  var contentList = <int>[];
  int selectedIndex = 1;

  @override
  void initState()
  {
    super.initState();

    for(int i = 0; i < 10 ; ++i)
      contentList.add(i);
  }

  @override
  void dispose() {
    contentList.clear();
    super.dispose();
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
          // navigationBar:
          // CupertinoNavigationBar
          // (
          //   backgroundColor: Colors.transparent,
          //   leading:
          //   Row
          //   (
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children:
          //     [
          //       Container
          //       (
          //         width: MediaQuery.of(context).size.width * 0.3,
          //         height: 50,
          //         //color: Colors.blue,
          //         padding: EdgeInsets.zero,
          //         alignment: Alignment.centerLeft,
          //         child:
          //         CupertinoNavigationBarBackButton
          //         (
          //           color: Colors.white,
          //           onPressed: ()
          //           {
          //             Get.back();
          //           },
          //         ),
          //       ),
          //       Container
          //         (
          //         width: MediaQuery.of(context).size.width * 0.3,
          //         height: 50,
          //         //color: Colors.green,
          //         alignment: Alignment.center,
          //         child:
          //         Text
          //           (
          //           StringTable().Table![400021]!,
          //           style:
          //           TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
          //         ),
          //       ),
          //       Container(width: MediaQuery.of(context).size.width * 0.3, height: 50,)
          //     ],
          //   ),
          // ),
          child:
          Container
          (
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            //alignment: Alignment.center,
            color: Colors.green,
            child:
            Row
            (
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                Column
                (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    Container
                    (
                      width: 259,
                      height: 463,
                      color:Colors.grey,
                      //child: ShortsPlayer(shortsUrl: contentUrl,),
                    ),
                    SizedBox(height: 10),
                    contentInfo(),
                    SizedBox(height: 10),
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

  Widget contentSelctItem(int _index)
  {
    var month = '7월'; //20003
    var day = '9일';

    return
    Column
    (
      children:
      [
        Row
        (
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children:
          [
            Text
            (
              month,
              style:
              TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
            ),
            SizedBox(width: 5,),
            Text
            (
              day,
              style:
              TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
            ),
          ],
        ),
        GestureDetector
        (
          onTap: ()
          {
            setState(()
            {
              selectedIndex = _index;
              print(selectedIndex);
            });
          },
          child:
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
                        : Colors.grey),
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            child: Text('afdafs'),
          ),
        ),
      ],
    );

  }

  Widget contentSelector()
  {
    return
    Container
    (
      height: double.infinity,
      width: 86,
      color: Colors.blue,
      child:
      ListView
      (
        scrollDirection: Axis.vertical,
        children:
        [
          SizedBox(height: 130,),
          for(var item in contentList)
            contentSelctItem(item),
        ],
      ),
    );
  }

  Widget contentInfo()
  {
    var title = '제목은 몇글자까지임?';
    var date = '24.09.09';
    var totalEpisode = '총999화';
    var genre = '시대물';
    var rank = 'TOP10';
    var content = 'asdklflkasjfdklajfkldjkalfjdlkajfkldajflkjalkfasffadsffs';

    return
    Container
    (
      width: 259,
      height: 175,
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
                TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
              ),
            ),
            SizedBox(height: 10,),
            Row
            (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
              [
                Container
                (
                  height: 15,
                  //color: Colors.blue,
                  child:
                  Text
                  (
                    date,
                    style:
                    TextStyle(fontSize: 11, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                  ),
                ),
                Container
                (
                  height: 15,
                  //color: Colors.blue,
                  alignment: Alignment.center,
                  child:
                  Text
                  (
                    textAlign: TextAlign.center,
                    totalEpisode,
                    style:
                    TextStyle(fontSize: 11, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                  ),
                ),
                Container
                (
                  height: 15,
                  //color: Colors.blue,
                  child:
                  Text
                  (
                    genre,
                    style:
                    TextStyle(fontSize: 11, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                  ),
                ),
                Container
                (
                  height: 15,
                  //color: Colors.blue,
                  child:
                  Visibility
                  (
                    visible: rank != '',
                    child: Text
                    (
                      rank,
                      style:
                      TextStyle(fontSize: 11, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                    ),
                  ),
                ),
              ],
            ),
            Container
            (
              alignment: Alignment.centerLeft,
              height: 40,
              child:
              Text
              (
                content,
                style:
                TextStyle(fontSize: 11, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
              ),
            ),
            SizedBox(height: 10,),
            Expanded
            (
              child:
              Row
              (
                mainAxisAlignment: MainAxisAlignment.end,
                children:
                [
                  GestureDetector
                  (
                    onTap: ()
                    {
                      print('tap');
                    },
                    child: Opacity(
                      opacity: 0.70,
                      child: Container(
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
                              child: Icon(CupertinoIcons.bell, size: 22, color:Colors.white),
                            ),
                            Padding
                            (
                              padding: const EdgeInsets.only(top: 18),
                              child: Text
                              (
                                StringTable().Table![200002]!,
                                style:
                                TextStyle(fontSize: 10, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  GestureDetector
                    (
                    onTap: ()
                    {
                      print('tap');
                    },
                    child: Opacity(
                      opacity: 0.70,
                      child: Container(
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
                                StringTable().Table![200002]!,
                                style:
                                TextStyle(fontSize: 10, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyCarousel extends StatefulWidget {
  @override
  _MyCarouselState createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  List<Color> colors = List.generate(10, (index) => Colors.grey);

  @override
  Widget build(BuildContext context)
  {
    return
    MaterialApp
    (
      home:
      CarouselSlider.builder
      (
        itemCount: 10,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex)
        {
          return
          GestureDetector
          (
            onTap: () {
              setState(() {
                colors[itemIndex] = Colors.blue;  // 원하는 색상으로 변경
              });
            },
            child: Container(
              color: colors[itemIndex],
              width: MediaQuery.of(context).size.width,
              child: Text('Item $itemIndex'),
            ),
          );
        },
        options: CarouselOptions(
          height: 400,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 2.0,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 0.8,
        ),
      ),
    );
  }
}
