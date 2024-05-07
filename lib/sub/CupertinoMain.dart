import 'package:flutter/cupertino.dart';
import 'package:shortplex/sub/UserInfoPage.dart';
import 'first_page.dart';
import 'second_page.dart';

class CuperinoTabBar extends StatefulWidget {
  const CuperinoTabBar({super.key});

  @override
  State<CuperinoTabBar> createState() => _CuperinoTabBarState();
}

class _CuperinoTabBarState extends State<CuperinoTabBar>
{
  CupertinoTabBar? cupertinoTabBar;

  @override
  void initState()
  {
    super.initState();

    cupertinoTabBar = CupertinoTabBar
    (
      items: <BottomNavigationBarItem>
      [
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.ant)),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.alarm)),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.alt)),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.arrow_branch)),
      ]
    );

  }
  @override
  Widget build(BuildContext context)
  {
    return CupertinoApp
    (
      home: CupertinoTabScaffold
      (
        tabBar: cupertinoTabBar!,
        tabBuilder: (context, value)
        {
          switch(value)
          {
            case 0:
              {
                //통신하고 값전달해서 띄우는게 좋을까나?
                return HomePage();
              }
            case 1:
              return SecondPage();
            case 2:
              return Container
                (
                child: Center
                  (
                  child: Text('cupretino tab 3'),
                ),
              );
            case 3:
              return Container
                (
                child: Center
                  (
                  child: Text('cupretino tab 4'),
                ),
              );
            case 4:
              return UserInfoPage();
            default:
              return Placeholder();
          }
        },
      ),
    );
  }
}
