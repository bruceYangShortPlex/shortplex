import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget
{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('init');
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
  Widget build(BuildContext context)
  {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>
            [
              Text('This is a text'),
              SizedBox(height: 20,),
              CupertinoButton
                (
                color: Colors.blue,
                child: Text('Cupertino Button'),
                onPressed: ()
                {
                  // Get.to(MoviePlayerPage(LongVodeoUri: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
                  //     MiddelResolution: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
                  //     LowResolution: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"),);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
