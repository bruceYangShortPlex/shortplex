import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../table/StringTable.dart';
import 'ExpandableText.dart';

void showDialogTwoButton(int _titieID, int _contentID, VoidCallback _callback)
{
  Get.defaultDialog
  (
    backgroundColor: Color(0x1E1E1E).withOpacity(1),
    title: StringTable().Table![_titieID]!,
    titleStyle:
    TextStyle
    (
      fontSize: 16, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
    titlePadding: EdgeInsets.only(top: 30),
    contentPadding: _contentID == 0 ? EdgeInsets.only(top: 0) : EdgeInsets.only(top: 30),
    content : _contentID != 0 ?
    Text(StringTable().Table![_contentID]!, style: TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),) : Text(''),
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
        },
        child:
        Text
        (
          StringTable().Table![600008]!,
          style: TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
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
          style: TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
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

Widget CommentWidget
      (
        int _index,
        String _iconUrl,
        String _episodeNumber,
        String _name,
        String _date,
        bool _likeCheck,
        String _commant,
        String _replyCount,
        String _likeCount,
        bool _isOwner,
        bool _isBest,
        Function(int) _callClickLike, Function(int) _callOpenCommant,Function(int) _callDelete)
{
  var index = _index;
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
                      child: _iconUrl == '' ?
                      Container
                      (
                        //color: Colors.black,
                        child: Image.asset('assets/images/User/my_picture.png', fit: BoxFit.cover,),
                      ) :
                      Image.network(_iconUrl,
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
                          visible: _isBest,
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
                                  'BEST',
                                  style: TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
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
                              SetTableStringArgument(100034, [_episodeNumber]),
                              style: TextStyle(fontSize: 12, color: Color(0xFF00FFBF), fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
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
                              _name == '' ? '...' : _name = _name.length > 10 ? _name.substring(0, 10) : _name,
                              style: TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
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
                                _date,
                                style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
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
                    ExpandableText(text: _commant),
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
              Padding
              (
                padding: const EdgeInsets.only(left: 32),
                child:
                Container
                (
                  //color: Colors.blue,
                  child: IconButton
                  (
                    padding: EdgeInsets.zero,
                    onPressed: ()
                    {
                      _callClickLike(index);
                    },
                    icon: Icon( _likeCheck == true ? CupertinoIcons.heart_solid : CupertinoIcons.heart,
                                color: Colors.white,size: 15,),
                  ),
                ),
              ),
              Container
              (
                width: 40,
                child:
                Text
                (
                  textAlign: TextAlign.start,
                  _likeCount,
                  style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                ),
              ),
              Padding
              (
                padding: const EdgeInsets.only(left: 0),
                child:
                Container
                (
                  //color: Colors.blue,
                  child: IconButton
                  (
                    padding: EdgeInsets.zero,
                    onPressed: ()
                    {
                      _callOpenCommant(index);
                    },
                    icon: Icon( CupertinoIcons.ellipses_bubble, color: Colors.white,size: 15,),
                  ),
                ),
              ),
              Container
              (
                //color: Colors.blue,
                width: 40,
                child:
                Text
                (
                  textAlign: TextAlign.start,
                  _replyCount,
                  style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.6), fontFamily: 'NotoSans', fontWeight: FontWeight.w100,),
                ),
              ),
              Visibility
              (
                visible: _isOwner,
                child:
                Align
                (
                  alignment: Alignment.centerRight,
                  child:
                  Padding
                  (
                    padding: const EdgeInsets.only(right: 0),
                    child:
                    Container
                    (
                      //color: Colors.blue,
                      child: IconButton
                      (
                        padding: EdgeInsets.zero,
                        onPressed: ()
                        {
                          _callOpenCommant(index);
                        },
                        icon: Icon( CupertinoIcons.delete, color: Colors.white,size: 15,),
                      ),
                    ),
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

