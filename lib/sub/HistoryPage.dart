import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HistoryPage extends StatefulWidget
{
  const HistoryPage({super.key, required this.PageTitle});

  final String PageTitle;

  @override
  State<HistoryPage> createState() => _HistoryPageState();

  Widget HistoryBuild(BuildContext context) =>
      SafeArea
      (
        child:
        CupertinoApp
        (
          home:
          CupertinoPageScaffold
          (
            backgroundColor: Colors.black,
            navigationBar:
            CupertinoNavigationBar
            (
              backgroundColor: Colors.transparent,
              leading:
              Row
                (
                mainAxisAlignment: MainAxisAlignment.start,
                children:
                [
                  Container
                    (
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 50,
                    //color: Colors.blue,
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                    child:
                    CupertinoNavigationBarBackButton
                      (
                      color: Colors.white,
                      onPressed: ()
                      {
                        Get.back();
                      },
                    ),
                  ),
                  Container
                    (
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 50,
                    //color: Colors.green,
                    alignment: Alignment.center,
                    child:
                    Text
                    (
                      PageTitle,
                      style:
                      TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                    ),
                  ),
                  Container(width: MediaQuery.of(context).size.width * 0.3, height: 50,)
                ],
              ),
            ),
            child:
            Container
              (
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              //color: Colors.yellow,
              child:
              Obx
                (() => HistoryListController.to.mainlist.length == 0 ? Container() :
              ListView.builder
              (
                padding: EdgeInsets.all(0),
                itemCount: HistoryListController.to.mainlist.length,
                itemBuilder: (context, index)
                {
                  return HistoryListController.to.mainlist[index];
                  //return Text(str);
                },
              ),
              ),
            ),
          ),
        ),
      );

  Widget historyMain(List<Widget> _itemlist) =>
  Column
  (
    mainAxisAlignment: MainAxisAlignment.start,
    children:
    [
      Align
      (
        alignment: Alignment.centerLeft,
        child:
        Padding
        (
          padding: const EdgeInsets.only(top: 60.0, left: 20),
          child:
          Container
          (
            width: 390.w,
            height: 30,
            //color: Colors.yellow,
            alignment: Alignment.bottomLeft,
            child:
            Text
            (
              '5월 2024',
              style:
              TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
            ),
          ),
        ),
      ),
      Divider(height: 10, color: Colors.white38, indent: 10, endIndent: 10, thickness: 1,),
      Container
      (
        //color: Colors.white,
        alignment: Alignment.topCenter,
        height: _itemlist.length * 70,
        padding: EdgeInsets.zero,
        child:
        Center
        (
          child:
          ListView.builder
          (
            padding: EdgeInsets.all(0),
            itemCount: _itemlist.length,
            itemBuilder: (context, index)
            {
              return _itemlist[index];
              //return Text(str);
            },
          ),
        ),
      ),
    ],
  );

  Widget historyItem(String _iconPath, String _title, String _time, String _price, [Color _textColor = Colors.white]) =>
  Column
  (
    children:
    [
      Row
      (
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
        [
          Padding
          (
            padding: const EdgeInsets.only(left: 30),
            child:
            Expanded
            (
              flex: 1,
              child:
              Container
              (
                width: ((390 * 0.5) - 20).w,
                height: 60,
                //color: Colors.blue,
                child:
                Row
                (
                  children:
                  [
                    Image.asset(_iconPath, width: 32, height: 32,),
                    Padding
                    (
                      padding: const EdgeInsets.only(left: 10.0),
                      child:
                      Column
                      (
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          Text
                          (
                            _title,
                            style:
                            TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                          ),
                          Text
                          (
                            _time,
                            style:
                            TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding
          (
            padding: const EdgeInsets.only(right: 20),
            child:
            Expanded
            (
              flex: 1,
              child:
              Container
              (
                width: ((390 * 0.5) - 20).w,
                height: 60,
                //color: Colors.blue,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20),
                child:
                Text
                (
                  _price,
                  style:
                  TextStyle(fontSize: 15, color: _textColor, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                ),
              ),
            ),
          ),
        ],
      ),
      Divider(height: 10, color: Colors.white38, indent: 10, endIndent: 10, thickness: 1,),
    ],
  );

  Widget historyContent(String _iconPath, String _episodes, String _title, String _time, String _noti1, String _noti2,
          [Color _textColor = Colors.white]) =>
      Column
      (
        children:
        [
          Row
          (
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
            [
              Padding
              (
                padding: const EdgeInsets.only(left: 30),
                child:
                Expanded
                (
                  flex: 1,
                  child:
                  Container
                  (
                    width: ((390 * 0.5) - 20).w,
                    height: 60,
                    //color: Colors.blue,
                    child:
                    Row
                    (
                      children:
                      [
                        Image.asset
                        (
                          _iconPath,
                          width: 32,
                          height: 50,
                        ),
                        Padding
                        (
                          padding: const EdgeInsets.only(left: 10.0),
                          child:
                          Column
                          (
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                              Text
                              (
                                _title,
                                style:
                                TextStyle
                                (
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontFamily: 'NotoSans',
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                              Text
                              (
                                _time,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white.withOpacity(0.6),
                                  fontFamily: 'NotoSans',
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                              Text
                              (
                                _time,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white.withOpacity(0.6),
                                  fontFamily: 'NotoSans',
                                  fontWeight: FontWeight.w100,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding
              (
                padding: const EdgeInsets.only(right: 20),
                child:
                Expanded
                (
                  flex: 1,
                  child:
                  Container
                  (
                    width: ((390 * 0.5) - 20).w,
                    height: 60,
                    //color: Colors.blue,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    child: _noti2 == '' ?
                    Text
                    (
                      _noti1,
                      style: TextStyle(
                        fontSize: 15,
                        color: _textColor,
                        fontFamily: 'NotoSans',
                        fontWeight: FontWeight.w100,
                      ),
                    ) :
                    Column
                    (
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        Text
                        (
                          _noti1,
                          style: TextStyle(
                            fontSize: 15,
                            color: _textColor,
                            fontFamily: 'NotoSans',
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        Text
                          (
                          _noti2,
                          style: TextStyle(
                            fontSize: 15,
                            color: _textColor,
                            fontFamily: 'NotoSans',
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider
          (
            height: 10,
            color: Colors.white38,
            indent: 10,
            endIndent: 10,
            thickness: 1,
          ),
        ],
      );
}

class _HistoryPageState extends State<HistoryPage>
{
  @override
  Widget build(BuildContext context)
  {
    return
    widget.HistoryBuild(context);
  }
}

class HistoryListController extends GetxController
{
  static HistoryListController get to => Get.find();
  RxList<Widget> mainlist = <Widget>[].obs;
}
