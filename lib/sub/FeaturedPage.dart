import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shortplex/Util/ShortsPlayer.dart';
import '../Util/ShortplexTools.dart';
import '../Util/ViedoPage.dart';
import '../table/StringTable.dart';

void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  runApp( FeaturedPage());
}

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

  @override
  void initState()
  {
    super.initState();
    // pageList.add(VideoPage(url: "https://cdn.gro.care/ec12312256ad_1683524903074.mp4",));
    // pageList.add(VideoPage(url: "https://cdn.gro.care/4dc9fddff1c8_1683731818849.mp4",));
    // pageList.add(VideoPage(url: "https://cdn.gro.care/045e95f617aa_1683612715343.mp4",));
    // pageList.add(VideoPage(url: "https://videos.pexels.com/video-files/17687288/17687288-uhd_2160_3840_30fps.mp4",));
    // pageList.add(VideoPage(url: "https://videos.pexels.com/video-files/6060027/6060027-uhd_2160_3840_25fps.mp4",));
    // pageList.add(VideoPage(url: "https://videos.pexels.com/video-files/17687288/17687288-uhd_2160_3840_30fps.mp4",));
    pageList.add(_testWidget('1'));
    pageList.add(_testWidget('2'));
    pageList.add(_testWidget('3'));

    urlList =
    [
      "https://videos.pexels.com/video-files/17687288/17687288-uhd_2160_3840_30fps.mp4",
      "https://videos.pexels.com/video-files/6060027/6060027-uhd_2160_3840_25fps.mp4",
      "https://videos.pexels.com/video-files/17687288/17687288-uhd_2160_3840_30fps.mp4"
    ];
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
          color: Colors.blue,
          child: Text(_title),
        ),
      ),
  );

  @override
  Widget build(BuildContext context)
  {
    return mainWiget(context);
  }

  Widget mainWiget(BuildContext context)=>
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
            PageView.builder
            (
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: urlList.length,
              controller:
              PageController
              (
                initialPage: 0, viewportFraction: 1),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index)
                {
                  return ShortsPlayer(shortsUrl: urlList[index]);
                  //VideoPage(url: urlList[index]);
                },
              ),
            ),
            // Container
            // (
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.height,
            //   color: Colors.green,
            //   child:
            //   Column
            //   (
            //     children:
            //     [
            //       Align
            //       (
            //         alignment: Alignment.topLeft,
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
            //     ],
            //   ),
            // ),
          ),
        );
}

