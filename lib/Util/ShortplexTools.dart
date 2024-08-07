import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shortplex/sub/ContentInfoPage.dart';
import 'package:shortplex/sub/UserInfo/AccountInfoPage.dart';
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
    titlePadding: const EdgeInsets.only(top: 30, left: 10, right: 10),
    contentPadding: _content == '' ? EdgeInsets.zero : const EdgeInsets.only(top: 30, left: 10, right: 10),
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

(String, String, String) SubstringDuration(Duration duration)
{
  if (duration == Duration.zero) {
    return ('','','');
  }

  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);
  String formattedHours = hours.toString().padLeft(2, '0');
  String formattedMinutes = minutes.toString().padLeft(2, '0');
  String formattedSeconds = seconds.toString().padLeft(2, '0');

  return (formattedHours, formattedMinutes, formattedSeconds);
}

(String, String, String) SubstringDate(String _date)
{
  if (_date.isEmpty) {
    return ('','','');
  }

  var date = DateTime.parse(_date);
  var year = date.year.toString();
  var month = date.month.toString().padLeft(2, '0');
  var day = date.day.toString().padLeft(2, '0');

  return (year, month, day);
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
          child: _imageUrl.isEmpty ? Image.asset('assets/images/user/my_picture.png', fit: BoxFit.cover,) :
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
                        child: Image.asset('assets/images/user/my_picture.png', fit: BoxFit.cover,),
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
                                _data.name == null || _data.name == '' ? '...' : _data.name = _data.name!.length > 10 ? _data.name!.substring(0, 10) : _data.name!,
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
                          icon:
                          Icon( _data.isLikeCheck == true ? CupertinoIcons.heart_solid : CupertinoIcons.heart,
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

SnackbarController ShowCustomSnackbar(String _content, SnackPosition _position, [Function? _callback])
{
  return
  Get.snackbar
  (
    '',
    '',
    padding: EdgeInsets.only(bottom: 30),
    messageText:
    Center
    (
      child:
      Text
      (
        _content,
        style:
        TextStyle(fontSize: 16, color: Colors.blue, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
      ),
    ),
    //colorText: Colors.blue,
    backgroundColor: Colors.white,
    snackPosition: _position,
    duration: Duration(seconds: 2),
    snackbarStatus: (status)
    {
      if (status == SnackbarStatus.CLOSED)
      {
        if (_callback != null) {
          _callback();
        }
      }
    },
  );
}

String GetReleaseTime(String _createTime)
{
  var current = DateTime.now().toUtc();
  var create = DateTime.parse(_createTime);
  var diff = current.difference(create);

  //print('diff.inDays : ${diff.inDays} / diff.inHours : ${diff.inHours} / diff.inMinutes : ${diff.inMinutes}');

  //7일 이후
  if (diff.inDays >= 7)
  {
    return ConvertDateString(_createTime);
  }
  //7일 이내
  if (diff.inDays > 0)
  {
    var result = diff.inDays.toString();
    return SetTableStringArgument( 300062, [result]);
  }
  //하루 이내
  if (diff.inHours > 0)
  {
    var result = diff.inHours.toString();
    return SetTableStringArgument(300061 , [result]);
  }
  //print('diff.inMinutes : ${diff.inMinutes} / create : $create  / current : $current');
  if (diff.inMinutes > 0)
  {
    var result = diff.inMinutes.toString();
    return SetTableStringArgument(300060 , [result]);
  }

  return StringTable().Table![300059]!;
}

String ConvertDateString(String _date)
{
  if (_date.isEmpty) {
    return '';
  }

  var result = DateTime.parse(_date);

  return DateToString(result);
}

String DateToString(DateTime _date)
{
  var year = _date.year.toString().padLeft(2, '0');
  var month = _date.month.toString().padLeft(2, '0');
  var day = _date.day.toString().padLeft(2, '0');

  return '$year.$month.$day';
}

bool isEmulator() {
  // Android 에뮬레이터 확인
  return Platform.environment.containsKey('FLUTTER_TEST');
}

String ConvertCodeToString(String _genre)
{
  List<String> stringList = _genre.split(',');
  List<int> intList = stringList.map((i) => int.parse(i)).toList();

  var resultString = '';
  for(var item in intList)
  {
    if (StringTable().Table!.containsKey(item))
    {
      if (resultString.isEmpty) {
        resultString = StringTable().Table![item]!;
      }
      else
      {
        resultString = '$resultString, ${StringTable().Table![item]!}';
      }
    }
  }

  return resultString;
}

extension InputValidate on String {
  //이메일 포맷 검증
  bool isValidEmailFormat() {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }
  //대쉬를 포함하는 010 휴대폰 번호 포맷 검증 (010-1234-5678)
  bool isValidPhoneNumberFormat() {
    return RegExp(r'^010-?([0-9]{4})-?([0-9]{4})$').hasMatch(this);
  }
}

String ConvertGenderToString(String _genderType)
{
  var stringID = 0;
  if (_genderType == GenderType.F.name)
  {
    stringID = 400058;
  }
  else if (_genderType == GenderType.M.name)
  {
    stringID = 400059;
  }

  if (stringID == 0)
  {
    return '';
  }

  return StringTable().Table![stringID]!;
}

String TranslateMonth(int _month)
{
  var index = 700000 + _month;
  return StringTable().Table![index]!;
}

String TranslateDay(int _day)
{
  var index = 700012 + _day;
  return StringTable().Table![index]!;
}

(String, String) GetDateString(String _createTime)
{
  var date = DateTime.parse(_createTime);
  return (TranslateMonth(date.month), date.year.toString());
}

(int, int) GetMonth(String _createTime)
{
  var date = DateTime.parse(_createTime);
  return (date.year, date.month);
}