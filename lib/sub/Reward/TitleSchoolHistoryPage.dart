import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Util/ShortplexTools.dart';
import '../../table/StringTable.dart';
import '../ContentInfoPage.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await StringTable().InitTable();
  runApp(const TitleSchoolHistoryPage());
}


class TitleSchoolHistoryPage extends StatefulWidget {
  const TitleSchoolHistoryPage({super.key});

  @override
  State<TitleSchoolHistoryPage> createState() => _TitleSchoolHistoryPageState();
}

class _TitleSchoolHistoryPageState extends State<TitleSchoolHistoryPage>
{
  var recordCommentList = <EpisodeCommentData>[];
  DateTime? pickedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    for(int i = 0; i < 3; ++i)
    {
      var commentData = EpisodeCommentData
        (
        name: '황후마마가 돌아왔다.',
        comment: '이건 재미있다. 무조건 된다고 생각한다.',
        date: '24.09.06',
        episodeNumber: '',
        iconUrl: '',
        ID: i,
        isLikeCheck: i % 2 == 0,
        likeCount: '12',
        replyCount: '3',
        isOwner: i == 0,
        commentType: CommentType.NORMAL,
      );
      recordCommentList.add(commentData);
    }
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
                    StringTable().Table![300002]!,
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
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column
            (
              children:
              [
                SizedBox(height: 60,),
                DateSelect(),
                Container
                (
                  width: 390,
                  height: 260,
                  color: Colors.grey,
                ),
                SizedBox(height: 30,),
                titleSchoolRecord(),
              ],
            ),

          ),
        ),
      ),
    );

  Widget DateSelect()
  {
    return
    Row
    (
      mainAxisAlignment: MainAxisAlignment.center,
      children:
      [
        IconButton
        (
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 1),
          color: Colors.white,
          iconSize: 20,
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white,), onPressed: ()
          {
            pickedDate = pickedDate?.subtract(Duration(days: 1));
            setState(() {

            });
          },
        ),
        SizedBox(width: 20,),
        Text
        (
          DateFormat('yy.MM.dd').format(pickedDate!),
          style:
          TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
        ),
        IconButton
        (
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 1),
          color: Colors.white,
          iconSize: 20,
          icon: const Icon(CupertinoIcons.calendar, color: Colors.white,),
          onPressed: () async
          {
            pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2024),
              lastDate: DateTime.now(),
            );

            setState(() {

            });
          },
        ),
        SizedBox(width: 10,),
        IconButton
        (
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 1),
          color: Colors.white,
          iconSize: 20,
          icon: const Icon(Icons.arrow_forward_ios, color: Colors.white,), onPressed: ()
          {
            pickedDate = pickedDate?.add(Duration(days: 1));
            setState(() {

            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return mainWidget(context);
  }

  Widget titleSchoolRecord()
  {
    return
      Container
        (
          width: 390,
          //color: Colors.blue,
          child:
          Column
            (
            children:
            [
              for(int i = 0; i < recordCommentList.length; ++i)
                RecordItem(i, recordCommentList[i]),
            ],
          )
      );
  }

  Widget RecordItem(int _rank, EpisodeCommentData _data)
  {
    var borderColor = _rank == 0 ? const Color(0xFFFFB700) : _rank == 1 ? const Color(0xFFAAAAAA) : const Color(0xFFA44E00);
    return
      Column
        (
        children:
        [
          Container
            (
            //width: 332,
            //height: 69,
            decoration: ShapeDecoration(
              color: Color(0xCC242424),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 2, color: borderColor),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            alignment: Alignment.center,
            child:
            Row
              (
              children:
              [
                SizedBox(width: 10,),
                Container
                  (
                  //color: Colors.red,
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(left: 10,),
                    child:
                    Image.asset('assets/images/main/shortplex.png', width: 30, height: 55,)
                ),
                SizedBox(width: 10,),
                Padding
                  (
                  padding: const EdgeInsets.only(top: 20),
                  child:
                  CommentWidget
                    (
                    _data.ID,
                    _data.iconUrl!,
                    _data.episodeNumber!,
                    _data.name!,
                    _data.date!,
                    _data.isLikeCheck!,
                    _data.comment!,
                    _data.likeCount!,
                    _data.replyCount!,
                    _data.isOwner!,
                    _data.commentType!,
                    false,
                        (id)
                    {
                      //TODO : 좋아요 버튼 처리
                      print(id);
                    },
                        (id)
                    {
                      //TODO : 댓글의 답글 열기 버튼 처리

                    },
                        (id)
                    {
                      //TODO : 삭제 버튼 처리
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
        ],
      );
  }

}
