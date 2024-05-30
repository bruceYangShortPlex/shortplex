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
  runApp( FadeTest());
}

class FadeTest extends StatefulWidget {
  const FadeTest({super.key});

  @override
  State<FadeTest> createState() => _FadeTestState();
}

class _FadeTestState extends State<FadeTest> with SingleTickerProviderStateMixin
{
  late AnimationController _controller;

  bool _visible = false;

  @override
  void initState()
  {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
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
        child:
        Stack
        (
          children:
          [
            Container
            (
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.blueGrey,
              child:
              GestureDetector
              (
                onTap: ()
                {
                  if (_controller.status == AnimationStatus.completed)
                  {
                    _controller.reverse();
                    setState(() {
                      _visible = false;
                    });
                  }
                  else
                  {
                    _controller.forward();
                    setState(() {
                      _visible = true;
                    });
                  }
                },
                child:
                FadeTransition
                (
                  opacity: _controller,
                  child:
                  Container
                  (
                    color: Colors.blue,
                    child:
                    Column
                    (
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        IgnorePointer
                        (
                          ignoring: _visible == false,
                          child:
                          IconButton
                          (
                            onPressed: () =>
                            {
                              print('click')
                            },
                            icon: Icon(Icons.add, size: 100,)),
                        ),
                      ],
                    ),
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
