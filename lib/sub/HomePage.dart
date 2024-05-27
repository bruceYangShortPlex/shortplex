import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Util/ViedoPage.dart';

class HomePage extends StatefulWidget
{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  List<Widget> pageList = <Widget>[];
  var pageIndex = 0;
  var tweenInitBlock = true;

  @override
  void initState()
  {
    super.initState();
    print('init');

    _pageController = PageController
    (
        initialPage: 4,
        viewportFraction: 0.7
    )
      ..addListener(() {
        setState(() {
          pageIndex = _pageController.page!.round();
        });
      });

    pageIndex = _pageController.initialPage;

    for(int i = 0; i < 10; ++i)
      pageList.add(pageItem(i));

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
  Widget build(BuildContext context) {
    return
      CupertinoApp
      (
        home: CupertinoPageScaffold
        (
          child:
          Center
          (
            child:
            Column
            (
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>
              [
                homPageView(),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      );
  }

  Widget homPageView()
  {
    return
    Container
    (
      width: 390,
      height: 410,
      color: Colors.green,
      child:
      Stack
      (
        children:
        [
          PageView.builder
          (
            //physics: AlwaysScrollableScrollPhysics(),
            itemCount: pageList.length,
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index)
            {
              double startScale = 0.9;
              double  endScale = 0.9;

              if (index == pageIndex)
              {
                 endScale = 1;
                 if (tweenInitBlock == true)
                 {
                   startScale = 1;
                   tweenInitBlock = false;
                 }
              }

              return
              TweenAnimationBuilder<double>
              (
                tween: Tween<double>(begin: startScale, end: endScale),
                duration: Duration(milliseconds: 150),
                builder: (BuildContext context, double size, Widget? child)
                {
                  return
                  Transform.scale
                  (
                    scale: size,
                    child:
                    Card
                    (
                      child:
                      Center
                      (
                        child:
                        pageList[index],
                      ),
                    ),
                  );
                }
              );
            },
          ),
        ]
      ),
    );
  }

  Widget pageItem(int _id)
  {
    var id = _id;

    return

          Container
          (
            width: 260,
            height: 410,
            decoration: ShapeDecoration(
            color: Color(0xFFC4C4C4),
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            ),
            ),
          );

  }
}
