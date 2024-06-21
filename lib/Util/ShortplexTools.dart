import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shortplex/sub/ContentInfoPage.dart';
import 'dart:io';
import '../table/StringTable.dart';
import '../table/UserData.dart';
import 'ExpandableText.dart';

void showDialogTwoButton(String _titie, String _content, VoidCallback _callback, [VoidCallback? _noCallBack = null])
{
  Get.defaultDialog
  (
    backgroundColor: Color(0x1E1E1E).withOpacity(1),
    title: _titie,
    titleStyle:
    TextStyle
    (
      fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
    titlePadding: EdgeInsets.only(top: 30),
    contentPadding: _content == '' ? EdgeInsets.only(top: 0) : EdgeInsets.only(top: 30),
    content :
    Text
    (
      _content,
      style: TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
    ),
    actions:
    [
      CupertinoButton
      (
        // style:
        // ButtonStyle
        // (
        //   backgroundColor:
        //   MaterialStatePropertyAll<Color>(Color(0x1E1E1E).withOpacity(0)),
        //   fixedSize: MaterialStateProperty.all(Size(100, 40)),
        //   //padding: MaterialStateProperty.all(EdgeInsets.only(left: 10)),
        // ),
        onPressed: ()
        {
          Get.back();
          if (_noCallBack != null) {
            _noCallBack();
          }
        },
        child:
        Text
        (
          StringTable().Table![600008]!,
          style: TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
        ),
      ),
      SizedBox(width: 30,),
      CupertinoButton
      (
        // style:
        // ButtonStyle
        // (
        //   backgroundColor:
        //   MaterialStatePropertyAll<Color>(Color(0x1E1E1E).withOpacity(0)),
        //   fixedSize: MaterialStateProperty.all(Size(100, 40)),
        //   //padding: MaterialStateProperty.all(EdgeInsets.only(left: 10)),
        // ),
        onPressed: ()
        {
          Get.back();
          _callback();
        },
        child:
        Text
        (
          StringTable().Table![600007]!,
          style: TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
        ),
      ),
    ],
  );
}

String SetTableStringArgument(int _talbeID, List<String> list)
{
  var source = StringTable().Table![_talbeID]!;
  return SetStringArgument(source, list);
}

String SetStringArgument(String _source, List<String> list)
{
  var dest = _source;
  for(int i = 0 ; i < list.length ; ++i)
  {
    dest = dest.replaceAll('{$i}', list[i]);
  }

  return dest;
}

(String, String, String) formatDuration(Duration duration)
{
  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);
  String formattedHours = hours.toString().padLeft(2, '0');
  String formattedMinutes = minutes.toString().padLeft(2, '0');
  String formattedSeconds = seconds.toString().padLeft(2, '0');

  return (formattedHours, formattedMinutes, formattedSeconds);
}

Widget profileRect(double _size, String _imageUrl)
{
  return
    Padding
    (
    padding: const EdgeInsets.all(8.0),
    child:
    Container
    (
      width: _size,
      height: _size,
      // decoration: const BoxDecoration
      // (
      //   border: Border
      //     (
      //     left: BorderSide(color: Color(0xFF00FFBF), width: 1),
      //     right:BorderSide(color: Color(0xFF00FFBF), width: 1),
      //     top :BorderSide(color: Color(0xFF00FFBF), width: 1),
      //     bottom:BorderSide(color: Color(0xFF00FFBF), width: 1),
      //   ),
      //   //borderRadius: BorderRadius.circular(15),
      //   shape: BoxShape.circle,
      //   color: Color(0xFF00FFBF),
      // ),
      child:
      ClipRRect
      (
        borderRadius: BorderRadius.circular(100),
        child:
        Container
        (
          color: Colors.black,
          child: _imageUrl.isEmpty ? Image.asset('assets/images/User/my_picture.png', fit: BoxFit.cover,) :
          Image.network(_imageUrl, fit: BoxFit.cover),
        ),
      ),
    )
  );
}

Widget VirtualKeybord(String _defaultString, TextEditingController _controller, FocusNode _focusNode, bool _isReadOnly, double _bottomHeight, VoidCallback _callback)
{
  //print(_bottomHeight);
  return
  Align
  (
    alignment: Alignment.bottomCenter,
    child:
    Container
    (
      child:
      Column
      (
        mainAxisAlignment: MainAxisAlignment.end,
        children:
        [
          Container
          (
            color: Colors.black,
            child:
            Row
            (
              children: <Widget>
              [
                profileRect(26, ''),
                Expanded
                (
                  child:
                  SizedBox
                  (
                    height: 32,
                    child:
                    CupertinoTextField
                    (
                      controller: _controller,
                      focusNode: _focusNode,
                      placeholder: _defaultString,
                      readOnly: _isReadOnly,
                      decoration: BoxDecoration(
                        color: Color(0xFF1E1E1E), // 배경색을 회색으로 설정
                        borderRadius: BorderRadius.circular(20),
                      ),
                      placeholderStyle:
                      TextStyle
                      (
                        fontSize: 12,
                        fontFamily: 'NotoSans',
                        color: Colors.grey,
                        fontWeight: FontWeight.w500//placeholder 글자색을 빨간색으로 설정
                      ),
                      style:  TextStyle
                        (
                          fontSize: 12,
                          fontFamily: 'NotoSans',
                          color: Colors.white,
                          fontWeight: FontWeight.w500//placeholder 글자색을 빨간색으로 설정
                      ),
                      padding:
                      EdgeInsets.only(left: 20, bottom: 2),
                      //decoration: ,
                      onEditingComplete: () {
                        _focusNode.unfocus();
                        _callback();
                      },
                    ),
                  ),
                ),
                CupertinoButton
                (
                  padding: EdgeInsets.only(right: 20, left: 10),
                  child:
                  Icon(Icons.send, color: Colors.grey,),
                  onPressed: ()
                  {
                    _focusNode.unfocus();
                    _callback();
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: _bottomHeight,)
        ],
      ),
    ),
  );
}

Widget CommentWidget
    (
      EpisodeCommentData _data,
      bool _isReply,
      Function(String) _callClickLike,
      Function(String) _callOpenComment,
      Function(String) _callEdit,
      Function(String) _callDelete
    )
{
  var id = _data.ID;
  var bannerStringID = _data.commentType == CommentType.TOP10 ? 500015 : 100037;
  var likeCount = _data.commentType == CommentType.TOP10 ? '???' : _data.likeCount!;

  return
  Container
  (
    width: 310,
    //height: 92,
    //color: Colors.yellow,
    child:
    Column
    (
      children:
      [
        Container
        (
          width: 310,
          //color: Colors.green,
          child:
          Row
          (
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Padding
              (
                padding: const EdgeInsets.only(right: 4.0, top: 5),
                child: Container
                (
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration
                  (
                    border: Border
                    (
                      left: BorderSide(color: Colors.white, width: 1),
                      right:BorderSide(color: Colors.white, width: 1),
                      top :BorderSide(color: Colors.white, width: 1),
                      bottom:BorderSide(color: Colors.white, width: 1),
                    ),
                      //borderRadius: BorderRadius.circular(15),
                      shape: BoxShape.circle,
                      //color: Color(0xFF00FFBF),
                    ),
                    child:
                    ClipRRect
                    (
                      borderRadius: BorderRadius.circular(100),
                      child: _data.iconUrl == '' ?
                      Container
                      (
                        //color: Colors.black,
                        child: Image.asset('assets/images/User/my_picture.png', fit: BoxFit.cover,),
                      ) :
                      Image.network(_data.iconUrl!,
                          fit: BoxFit.cover),
                      ),
                ),
              ),
              Column
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  Container
                  (
                    width: 310 - 36,
                    //color: Colors.blue,
                    child:
                    Row
                    (
                      children:
                      [
                        Visibility
                        (
                          visible: _data.commentType != CommentType.NORMAL,
                          child:
                          Padding
                          (
                            padding: const EdgeInsets.only(left: 2, top: 2),
                            child:
                            Container
                            (
                              width: 34,
                              height: 13,
                              decoration: ShapeDecoration(
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 0.80, color: Color(0xFF00FFBF)),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                              child:
                              FittedBox
                              (
                                alignment: Alignment.center,
                                child:
                                Text
                                (
                                  StringTable().Table![bannerStringID]!,
                                  style: TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                                ),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Padding
                        (
                          padding: const EdgeInsets.only(left: 8),
                          child:
                          Container
                          (
                            //color: Colors.red,
                            height: 20,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(bottom: 2),
                            child:
                            Text
                            (
                              _data.episodeNumber!.isEmpty ? '' : SetTableStringArgument(100034, [_data.episodeNumber!]),
                              style: TextStyle(fontSize: 12, color: Color(0xFF00FFBF), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                            ),
                          ),
                        ),
                        Padding
                        (
                          padding: const EdgeInsets.only(left: 8),
                          child:
                          Container
                          (
                            //color: Colors.red,
                            width: 110,
                            height: 20,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(bottom: 2),
                            child:
                            Text
                            (
                              _data.name == '' ? '...' : _data.name = _data.name!.length > 10 ? _data.name!.substring(0, 10) : _data.name!,
                              style: TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                            ),
                          ),
                        ),
                        Padding
                        (
                          padding: const EdgeInsets.only(left: 12),
                          child: Container
                          (
                            //color: Colors.blue,
                            width: 50,
                            //alignment: Alignment.center,
                            child:
                            FittedBox
                            (
                              fit: BoxFit.contain,
                              //alignment: Alignment.centerRight,
                              child:
                              Text
                              (
                                _data.date!.isEmpty ? '00.00.00' : _data.date!,
                                style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                              ),
                          ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container
                  (
                    alignment: Alignment.centerLeft,
                    width: 310 - 36,
                    //color: Colors.red,
                    child:
                    ExpandableText(text: _data.comment!, limitLine: 4,),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 5,),
        Container
        (
          width: 310,
          height: 20,
          //color: Colors.blueGrey,
          child:
          Row
          (
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children:
            [
              Expanded
              (
                child:
                Padding
                (
                  padding: const EdgeInsets.only(left: 32),
                  child:
                  Container
                  (
                    //color: Colors.blue,
                    child:
                    Row
                    (
                      children:
                      [
                        IconButton
                        (
                          padding: EdgeInsets.zero,
                          onPressed: ()
                          {
                            _callClickLike(id);
                          },
                          icon: Icon( _data.isLikeCheck == true ? CupertinoIcons.heart_solid : CupertinoIcons.heart,
                            color: Colors.white,size: 15,),
                        ),
                        Text
                        (
                          textAlign: TextAlign.start,
                          likeCount,
                          style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                        ),
                      ],
                    )
                  ),
                ),
              ),
              Expanded
              (
                child: Padding
                (
                  padding: const EdgeInsets.only(left: 0),
                  child:
                  Container
                  (
                    //color: Colors.red,
                    child:
                    Visibility
                    (
                      visible: !_isReply,
                      child: Row
                      (
                        children:
                        [
                          IconButton
                            (
                            padding: EdgeInsets.zero,
                            onPressed: ()
                            {
                              _callOpenComment(id);
                            },
                            icon: Icon( CupertinoIcons.ellipses_bubble, color: Colors.white,size: 15,),

                          ),
                          Text
                            (
                            textAlign: TextAlign.start,
                            _data.replyCount!,
                            style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                          ),
                        ],
                      ),
                    ),

                    ),
                ),
              ),
              Container
              (
                //color: Colors.blue,
                width: 50,
                alignment: Alignment.centerRight,
                child:
                Visibility
                (
                  visible: _data.isEdit!,
                  child:
                  IconButton
                  (
                    padding: EdgeInsets.zero,
                    onPressed: ()
                    {
                      _callEdit(id);
                    },
                    icon: Icon( CupertinoIcons.pencil, color: Colors.white,size: 15,),
                  ),
                ),
              ),
              Container
              (
                //color: Colors.blue,
                width: 50,
                alignment: Alignment.centerRight,
                child:
                Visibility
                (
                  visible: _data.isDelete!,
                  child:
                  IconButton
                  (
                    padding: EdgeInsets.zero,
                    onPressed: ()
                    {
                      _callDelete(id);
                    },
                    icon: Icon( CupertinoIcons.delete, color: Colors.white,size: 15,),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20,),
      ],
    ),
  );
}

void activeBottomSheet(Widget _widget)
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
    backgroundColor: Colors.black,
    SizedBox
    (
      width: 390.w,
      height: 750.h,
      child:
      _widget
    ),
  );
}

SnackbarController ShowCustomSnackbar(String _content, SnackPosition _position)
{
  return
  Get.snackbar
  (
    '',
    '',
    padding: EdgeInsets.only(bottom: 30),
    messageText:
    Center(
      child:
      Text
        (
        _content,
        style:
        TextStyle(fontSize: 16, color: Colors.blue, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),),
    ),
    //colorText: Colors.blue,
    backgroundColor: Colors.white,
    snackPosition: _position,
    duration: Duration(seconds: 3),
  );
}

String ConvertCommentDate(String _date)
{
  var result = DateTime.parse(_date);

  var year = result.year.toString().padLeft(2, '0');
  var month = result.month.toString().padLeft(2, '0');
  var day = result.day.toString().padLeft(2, '0');

  return '$year.$month.$day';
}

bool isEmulator() {
  // Android 에뮬레이터 확인
  return Platform.environment.containsKey('FLUTTER_TEST');
}

Widget ResolutionSettingButton(SelectResolution _value)
{
  return
  DropdownButton<SelectResolution>
  (
    value: _value,
    onChanged: (value)
    {
      _value = value!;
      UserData.to.SaveSetting();
    },
    items: SelectResolution.values
        .map<DropdownMenuItem<SelectResolution>>((SelectResolution value) {
      return DropdownMenuItem<SelectResolution>(
        value: value,
        child: Text(value.name),
      );
    }).toList(),
  );
}