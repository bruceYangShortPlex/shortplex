import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirstPage extends StatelessWidget
{
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

