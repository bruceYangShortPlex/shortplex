import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: MyAnimatedWidget(),
    );
  }
}

class MyHomePage extends StatelessWidget
{

  void _showBottomSheet(BuildContext context)
  {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          child: Center(
            child: Text(
              'Hello from BottomSheet',
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      },
    );
  }

  void showBottomSheet()
  {
    Get.bottomSheet
    (
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.only(
      //     topRight: Radius.circular(20),
      //     topLeft: Radius.circular(20),
      //   ),
      // ),
      // clipBehavior: Clip.hardEdge,
      backgroundColor: Colors.white,
      SizedBox
      (
        width: 390,
        height: 900,
        // child:
        // Column
        // (
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     const Text(
        //       'bottom sheet',
        //       style: TextStyle(fontSize: 30),
        //     ),
        //     const SizedBox(height: 20),
        //     ElevatedButton(
        //       onPressed: Get.back,
        //       child: const Text('닫기'),
        //     )
        //   ],
        // ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter BottomSheet Example'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Show BottomSheet'),
          onPressed: () => _showBottomSheet(context),
        ),
      ),
    );
  }
}

class MyAnimatedWidget extends StatefulWidget {
  @override
  _MyAnimatedWidgetState createState() => _MyAnimatedWidgetState();
}

class _MyAnimatedWidgetState extends State<MyAnimatedWidget> {
  double _bottomOffset = -840;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tween Animation Example'),
      ),
      body: Stack
      (
        children: <Widget>[
          Center(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _bottomOffset = _bottomOffset == -840 ? 0 : -840;
                });
              },
              child: Text('Animate'),
            ),
          ),
          TweenAnimationBuilder<double>
          (
            tween: Tween<double>(begin: 0, end: _bottomOffset),
            duration: const Duration(milliseconds: 300),
            builder: (BuildContext context, double offset, Widget? child) {
              return Positioned(
                bottom: offset,
                left: 0,
                right: 0,
                child:
                GestureDetector
                (
                  onTap: ()
                  {
                    if (_bottomOffset == 0)
                    {
                      setState(() {
                        _bottomOffset = -840;
                      });
                    }
                  },
                  child: Container
                  (
                    width: MediaQuery.of(context).size.width,
                    height: 840,
                    color: Colors.transparent,
                    alignment: Alignment.bottomCenter,
                    child:
                    Container
                    (
                      height: 650,
                      color: Colors.blue,
                      child: Center(child: Text('Animated Container', style: TextStyle(color: Colors.white, fontSize: 24))),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}


