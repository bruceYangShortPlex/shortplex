import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shortplex/Util/LoginMananger.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget
{
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage>
{
  var loginManager = Get.find<LoginMananger>();

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
    print('loginManager.isLogin : ${loginManager.isLogin}' );
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
              Text('Login = ${loginManager.isLogin}'),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}