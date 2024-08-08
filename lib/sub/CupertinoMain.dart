import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shortplex/sub/Featured/FeaturedPage.dart';
import 'package:shortplex/sub/Reward/RewardPage.dart';
import 'package:shortplex/sub/UserInfo/UserInfoPage.dart';
import 'package:shortplex/table/StringTable.dart';
import 'Home/HomePage.dart';
import 'ReleasedContent/ReleasedContentsPage.dart';

// class CupertinoMain extends StatefulWidget {
//   const CupertinoMain({super.key});
//
//   @override
//   State<CupertinoMain> createState() => _CupertinoMainState();
// }
//
// class _CupertinoMainState extends State<CupertinoMain>
// {
//   static List<Widget> tabPages = <Widget>[
//     HomePage(), // 외부 클래스로 정의
//     FeaturedPage(),
//     ReleasedContentsPage(),
//     RewardPage(),
//     UserInfoPage(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     // 페이지 전환을 위한 MyBottomNavgationBarController 인스턴스화 (의존성 주입)
//     // Get.put : 수명이 페이지와 같음
//     Get.put(MainBottomNavgationBarController());
//
//     return
//       Scaffold
//         (
//         //backgroundColor: context.theme.colorScheme.background,
//         backgroundColor: Colors.transparent,
//         // 빈 AppBar 따로 정의
//         //appBar: EmptyAppBar(),
//         // MyBottomNavgationBarController의 변수가 변하면 화면(페이지) 변경
//         bottomNavigationBar: MainBottomNavgationBar(),
//         body:
//         //Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height, color: Colors.black,),
//         Obx(() => tabPages[MainBottomNavgationBarController.to.selectedIndex.value]),
//       );
//   }
// }


class CupertinoMain extends StatelessWidget{
  // 탭별 화면
  static List<Widget> tabPages = <Widget>[
    HomePage(), // 외부 클래스로 정의
    FeaturedPage(),
    ReleasedContentsPage(),
    RewardPage(),
    UserInfoPage(),
  ];

  @override
  Widget build(BuildContext context)
  {
    // 페이지 전환을 위한 MyBottomNavgationBarController 인스턴스화 (의존성 주입)
    // Get.put : 수명이 페이지와 같음
    Get.put(MainBottomNavgationBarController());

    if (Get.arguments is int)
    {
      MainBottomNavgationBarController.to.selectedIndex.value = Get.arguments;
    }

    return
    Scaffold
    (
      //backgroundColor: context.theme.colorScheme.background,
      backgroundColor: Colors.transparent,
      // 빈 AppBar 따로 정의
      //appBar: EmptyAppBar(),
      // MyBottomNavgationBarController의 변수가 변하면 화면(페이지) 변경
      bottomNavigationBar: MainBottomNavgationBar(),
      body:
      //Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height, color: Colors.black,),
      Obx(() => tabPages[MainBottomNavgationBarController.to.selectedIndex.value]),
    );
  }
}

enum MainPageType
{
  HOME,
  FeaturedPage,
  ReleasedContentsPage,
  RewardPage,
  UserInfoPage,
}

// BottomNavigationBar 상태 관리를 위한 GetX controller
class MainBottomNavgationBarController extends GetxController with GetSingleTickerProviderStateMixin
{
  // Get.fine 대신 클래스명 사용 가능
  static MainBottomNavgationBarController get to => Get.find();

  // 현재 선택된 탭 아이템 번호 저장
  final RxInt selectedIndex = 1.obs;

  // 탭 이벤트가 발생할 시 selectedIndex값을 변경해줄 함수
  void changeIndex(int index) {
    selectedIndex(index);
  }
}

class MainBottomNavgationBar extends GetView<MainBottomNavgationBarController> {
  const MainBottomNavgationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390.w,
      height: 80,
      color: Colors.black,
      child: Obx(() =>
      BottomNavigationBar
      (
          iconSize: 50,
        // 현재 인덱스를 selectedIndex에 저장
        currentIndex: controller.selectedIndex.value,
        // 요소(item)을 탭 할 시 실행)
        onTap: controller.changeIndex,
        // 선택에 따라 icon·label 색상 변경
        selectedItemColor: Color(0xFF00FFBF), //context.theme.colorScheme.onBackground,
        unselectedItemColor: Colors.grey,
        // 선택에 따라 label text style 변경
        //unselectedLabelStyle: TextStyle(fontSize: 12, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
        selectedLabelStyle: TextStyle(fontSize: 12, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
        // 탭 애니메이션 변경 (fixed: 없음)
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        // Bar에 보여질 요소. icon과 label로 구성.
        items: <BottomNavigationBarItem>[
            BottomNavigationBarItem
            (
                icon:
                ImageIcon
                (
                  AssetImage('assets/images/main/home_off.png'),
                  size: 30.0,
                ),
                    //   icon: controller.selectedIndex.value == 0
              //       ? Image.asset('assets/images/main/home_on.png')
              //       : Image.asset('assets/images/main/home_off.png'),
                 label: StringTable().Table![100001],
            ),
              BottomNavigationBarItem(
              icon:
              ImageIcon
              (
                AssetImage('assets/images/main/pick_off.png'),
                size: 30.0,
              ),
              // controller.selectedIndex.value == 1
              //     ? Image.asset('assets/images/main/pick_on.png')
              //     : Image.asset('assets/images/main/pick_off.png'),
                  label: StringTable().Table![100002]),
          BottomNavigationBarItem
            (
              icon:
              ImageIcon
              (
                AssetImage('assets/images/main/open_off.png'),
                size: 30.0,
              ),
              // controller.selectedIndex.value == 2
              //     ? Image.asset('assets/images/main/open_on.png')
              //     : Image.asset('assets/images/main/open_off.png'),
              label: StringTable().Table![100003]),
          BottomNavigationBarItem(
              icon:
              ImageIcon
              (
                AssetImage('assets/images/main/reword_off.png'),
                size: 30.0,
              ),
              // controller.selectedIndex.value == 3
              //     ? Image.asset('assets/images/main/reword_on.png')
              //     : Image.asset('assets/images/main/reword_off.png'),
              label: StringTable().Table![100004]),
          BottomNavigationBarItem
            (
              icon:
              ImageIcon
                (
                AssetImage('assets/images/main/my_off.png'),
                size: 30.0,
              ),
              // controller.selectedIndex.value == 4
              //     ? Image.asset('assets/images/main/my_on.png')
              //     : Image.asset('assets/images/main/my_off.png'),
              label: StringTable().Table![100005]),
        ],
      )),
    );
  }
}
