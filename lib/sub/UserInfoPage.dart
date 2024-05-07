import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'LoginPage.dart';

// void main() {
//   runApp(UserInfoPage());
// }

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}



class _UserInfoPageState extends State<UserInfoPage>
{
  @override
  Widget build(BuildContext context)
  {
    return GetCupertinoApp(
      home: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              SizedBox(
                width: 400,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('assets/images/shortplex.png',
                        width: 30, height: 30, fit: BoxFit.contain
                    ),

                    SizedBox(
                      width: 80,
                      height: 30,
                      child: CupertinoButton(
                        child: Text('Login'),
                        color: Colors.yellow,
                        onPressed: () {
                          Get.to(() => LoginPage());
                          print('Click');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}