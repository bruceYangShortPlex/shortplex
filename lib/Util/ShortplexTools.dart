import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../table/StringTable.dart';

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