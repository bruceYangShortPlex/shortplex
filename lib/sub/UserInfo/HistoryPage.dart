import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shortplex/Util/ShortplexTools.dart';

import '../../Util/HttpProtocolManager.dart';
import '../../table/StringTable.dart';


class HistoryPage extends StatefulWidget
{
  HistoryPage({super.key, required this.PageTitle, required this.historyType});

  final String PageTitle;
  final WalletHistoryType historyType;
  bool loadingComplete = false;

  List<List<HistoryData>> mainlist = <List<HistoryData>>[];

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
                      TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
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
              mainlist.length == 0 && loadingComplete ?
              Container
              (
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child:
                Column
                (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    Image.asset('assets/images/user/notfound_icon.png'),
                    SizedBox(height: 20,),
                    Text
                    (
                      '충전 기록이 없어요',
                      style:
                      TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                    ),
                    SizedBox(height: 4,),
                    Text
                    (
                      '지금 바로 작업해라 하드코딩이다',
                      style:
                      TextStyle(fontSize: 11, color: Colors.grey, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                    ),
                    SizedBox(height: 20,),
                    Container
                    (
                      alignment: Alignment.center,
                      width: 90,
                      height: 26,
                      decoration: ShapeDecoration(
                        color: Color(0xFF00FFBF),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      child:  
                      Text
                      (
                        '하드코딩',
                        style:
                        TextStyle(fontSize: 13, color: Colors.black, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                      ),
                    )
                  ],
                ),

              ) 
              :
              ListView.builder
              (
                padding: EdgeInsets.all(0),
                itemCount: mainlist.length,
                itemBuilder: (context, index)
                {
                  return  historyMain(mainlist[index]);
                },
              ),
            ),
          ),
        ),
      );

  Widget historyMain(List<HistoryData> _itemlist)
  {
    return
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
              width: 390,
              height: 30,
              //color: Colors.yellow,
              alignment: Alignment.bottomLeft,
              child:
              Row
              (
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children:
                [
                  Text
                  (
                    GetDateString(_itemlist[0].createdAt).$1,
                    style:
                    TextStyle(fontSize: 13,
                      color: Colors.white,
                      fontFamily: 'NotoSans',
                      fontWeight: FontWeight.bold,),
                  ),
                  SizedBox(width: 10,),
                  Text
                  (
                    GetDateString(_itemlist[0].createdAt).$2,
                    style:
                    TextStyle(fontSize: 12,
                      color: Colors.grey,
                      fontFamily: 'NotoSans',
                      fontWeight: FontWeight.bold,),
                  ),
                ],
              ),

            ),
          ),
        ),
        Divider(height: 10,
          color: Colors.white38,
          indent: 10,
          endIndent: 10,
          thickness: 1,),
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
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(0),
              itemCount: _itemlist.length,
              itemBuilder: (context, index) {
                return historyItem(_itemlist[index]);
                //return Text(str);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget historyItem(HistoryData _data)
  {
    //print('_data.iconUrl : ${_data.iconUrl}');
    try {
      return
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
                    Container
                    (
                      //width: ((390 * 0.5) - 20),
                      height: 60,
                      //color: Colors.blue,
                      child:
                      Row
                      (
                        children:
                        [
                          Container
                          (
                            //color: Colors.red,
                            width: 50,
                            height: 50,
                            child: Image.asset(_data.iconUrl, fit: BoxFit.scaleDown,)
                          ),
                          SizedBox(width: 10,),
                          Container
                          (
                            width: 200.w,
                            //color: Colors.red,
                            //padding: const EdgeInsets.only(left: 10.0),
                            child:
                            Column
                            (
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                              [
                                Text
                                (
                                  _data.title,
                                  style:
                                  TextStyle(fontSize: 15,
                                    color: Colors.white,
                                    fontFamily: 'NotoSans',
                                    fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis),
                                ),
                                Visibility
                                (
                                  visible: _data.episode != 0,
                                  child: Text
                                    (
                                    SetTableStringArgument(100034, ['${_data.episode}']),
                                    style:
                                    TextStyle(fontSize: 10,
                                      color: Colors.white.withOpacity(0.6),
                                      fontFamily: 'NotoSans',
                                      fontWeight: FontWeight.bold,),
                                  ),
                                ),
                                Text
                                  (
                                  _data.time,
                                  style:
                                  TextStyle(fontSize: 10,
                                    color: Colors.white.withOpacity(0.6),
                                    fontFamily: 'NotoSans',
                                    fontWeight: FontWeight.bold,),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container
                  (
                    width: 104.w,
                    //color: Colors.blue,
                    padding: const EdgeInsets.only(right: 20),
                    child:
                    Column
                    (
                      children:
                      [
                        Container
                        (
                          height: 25,
                          //color: Colors.blue,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20),
                          child:
                          Text
                          (
                            _data.content1,
                            style:
                            TextStyle(
                              fontSize: 15, color: Color(0xFF00FFBF), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                          ),
                        ),
                        Visibility
                        (
                          visible: !_data.content2.isEmpty,
                          child:
                          Container
                          (
                            height: 25,
                            //color: Colors.blue,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 20),
                            child:
                            Text
                            (
                              _data.content2,
                              style:
                              TextStyle(
                                fontSize: 15, color: Color(0xFF00FFBF), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
              ],
            ),
            Divider(height: 10,
              color: Colors.white38,
              indent: 10,
              endIndent: 10,
              thickness: 1,),
          ],
        );
    }
    catch(e)
    {
      print(e);
      return Container();
    }
  }


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
                Expanded
                (
                  flex: 1,
                  child:
                  Padding
                    (
                    padding: const EdgeInsets.only(left: 30),
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
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text
                              (
                                _time,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white.withOpacity(0.6),
                                  fontFamily: 'NotoSans',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text
                              (
                                _time,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white.withOpacity(0.6),
                                  fontFamily: 'NotoSans',
                                  fontWeight: FontWeight.bold,
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

                Expanded
                (
                  flex: 1,
                  child:
                  Padding
                    (
                    padding: const EdgeInsets.only(right: 20),
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
                        fontWeight: FontWeight.bold,
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
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text
                          (
                          _noti2,
                          style: TextStyle(
                            fontSize: 15,
                            color: _textColor,
                            fontFamily: 'NotoSans',
                            fontWeight: FontWeight.bold,
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

class HistoryData
{
  String date = '05월 2024';
  String iconUrl = 'assets/images/user/my_bonus.png';
  String title = '황후마마';
  int episode = 0;
  String time = '1분 전';
  String content1 = '';
  String content2 = '';
  String createdAt = '';

  int GetKey()
  {
    var keyDate = DateTime.parse(createdAt);
    var key =  keyDate.year * 100 + keyDate.month;
    return key;
  }
}
