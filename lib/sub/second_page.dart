import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shortplex/Util/LoginMananger.dart';
import 'package:flutter/cupertino.dart';

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
    super.initState();
  }

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