import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shortplex/sub/UserInfoPage.dart';
import 'package:shortplex/table/StringTable.dart';
import 'first_page.dart';
import 'second_page.dart';

class CupertinoMain extends StatelessWidget{
  // 탭별 화면
  static List<Widget> tabPages = <Widget>[
    HomePage(), // 외부 클래스로 정의
    SecondPage(),
    HomePage(),
    SecondPage(),
    UserInfoPage(),
  ];

  @override
  Widget build(BuildContext context) {

    // 페이지 전환을 위한 MyBottomNavgationBarController 인스턴스화 (의존성 주입)
    // Get.put : 수명이 페이지와 같음
    Get.put(MainBottomNavgationBarController());

    return Scaffold(
      backgroundColor: context.theme.colorScheme.background,
      // 빈 AppBar 따로 정의
      //appBar: EmptyAppBar(),
      // MyBottomNavgationBarController의 변수가 변하면 화면(페이지) 변경
      body: Obx(() => SafeArea(
          child:
          // static 변수를 이용해 컨트롤러 접근
          tabPages[MainBottomNavgationBarController.to.selectedIndex.value])),
      // 2번에서 만든 BottomNavgationBar 컴포넌트
      bottomNavigationBar: MainBottomNavgationBar(),
    );
  }
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
      width: 1.sw,
      height: 60,
      color: Colors.black,
      child: Obx(() =>
        BottomNavigationBar
        (
        // 현재 인덱스를 selectedIndex에 저장
        currentIndex: controller.selectedIndex.value,
        // 요소(item)을 탭 할 시 실행)
        onTap: controller.changeIndex,
        // 선택에 따라 icon·label 색상 변경
        selectedItemColor: Colors.green, //context.theme.colorScheme.onBackground,
        unselectedItemColor: Colors.white,
        // 선택에 따라 label text style 변경
        //unselectedLabelStyle: TextStyle(fontSize: 10),
        //selectedLabelStyle: TextStyle(fontSize: 10),
        // 탭 애니메이션 변경 (fixed: 없음)
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        // Bar에 보여질 요소. icon과 label로 구성.
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            // 선택된 탭은 채워진 아이콘, 나머지는 line 아이콘
              icon: controller.selectedIndex.value == 0
                  ? Icon(CupertinoIcons.add_circled)
                  : Icon(CupertinoIcons.add_circled_solid),
              label: StringTable().Table![100001],),
              BottomNavigationBarItem(
              icon: controller.selectedIndex.value == 1
                  ?
              // Image.asset(
              //   'assets/icons/menu2_solid.svg',
              // )
              Icon(CupertinoIcons.alarm)  :
              Icon(CupertinoIcons.alarm_fill),
              label: "tap2"),
          BottomNavigationBarItem(
              icon: controller.selectedIndex.value == 2
                  ? Icon(CupertinoIcons.ant_circle)
                  : Icon(CupertinoIcons.ant_circle_fill),
              label: "tap3"),
          BottomNavigationBarItem(
              icon: controller.selectedIndex.value == 3
                  ? Icon(CupertinoIcons.app_badge)
                  : Icon(CupertinoIcons.app_badge_fill),
              label: "tap4"),
          BottomNavigationBarItem(
              icon: controller.selectedIndex.value == 4
                  ? Icon(CupertinoIcons.arrow_clockwise_circle)
                  : Icon(CupertinoIcons.arrow_clockwise_circle_fill),
              label: "tap5"),
        ],
      )),
    );
  }
}
