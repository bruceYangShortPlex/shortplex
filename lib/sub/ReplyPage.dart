import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Util/ShortplexTools.dart';
import '../table/StringTable.dart';
import 'ContentInfoPage.dart';

class ReplyPage extends StatefulWidget
{
  const ReplyPage({super.key});

  @override
  State<ReplyPage> createState() => _ReplyPageState();
}

class _ReplyPageState extends State<ReplyPage>
{
  List<EpisodeCommentData> replyList = <EpisodeCommentData>[];
  var scrollController = ScrollController();

  var commentData = EpisodeCommentData
  (
    name: '',
    commant: '',
    date: '',
    episodeNumber: '',
    iconUrl: '',
    ID: -1,
    isLikeCheck: false,
    likeCount: '',
    replyCount: '',
    isOwner: false,
    isBest: false,
  );

  @override
  void initState()
  {
    super.initState();
    commentData = Get.arguments;
    print('data 1 : ${commentData}');

    for(int i = 0; i < 10; ++i)
    {
      var commentData = EpisodeCommentData
      (
        name: '황후마마가 돌아왔다.',
        commant: '이건 재미있다. 무조건 된다고 생각한다.',
        date: '24.09.06',
        episodeNumber: '11',
        iconUrl: '',
        ID: i,
        isLikeCheck: i % 2 == 0,
        likeCount: '12',
        replyCount: '3',
        isOwner: i == 0,
        isBest: true,
      );
      replyList.add(commentData);
    }

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        onEndOfPage();
      }
    });
  }

  @override
  void dispose()
  {
    scrollController.dispose();
    replyList.clear();
    super.dispose();
  }

  void onEndOfPage() async
  {
    try
    {
      //여기서 리스트 요청하고 만들고 해야한다.
      // Replace with your method to fetch data from the server.
      final newItems = await Future.delayed(Duration(seconds: 1),
              ()
          {
            for(int i = 0; i < 10; ++i)
            {
              var commentData = EpisodeCommentData
              (
                name: '황후마마가 돌아왔다.',
                commant: '이건 재미있다. 무조건 된다고 생각한다.',
                date: '24.09.06',
                episodeNumber: '11',
                iconUrl: '',
                ID: i,
                isLikeCheck: i % 2 == 0,
                likeCount: i.toString(),
                replyCount: '3',
                isOwner: i == 0,
                isBest: true,
              );
              replyList.add(commentData);
            }

            setState(()
            {

            });

          }
      );
    }
    catch (e)
    {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return mainWidget(context);
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
                StringTable().Table![100046]!,
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
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        //color: Colors.blue,
        child:
        ReplyPopup(scrollController, commentData, replyList),
      ),
      ),
    ),
  );
}

Widget ReplyPopup(ScrollController _scrollController,
    EpisodeCommentData _commentData, List<EpisodeCommentData> _replyList) {

  return SingleChildScrollView(
    controller: _scrollController,
    child: Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Container(
              child: CommentWidget(
                _commentData.ID,
                _commentData.iconUrl!,
                _commentData.episodeNumber!,
                _commentData.name!,
                _commentData.date!,
                _commentData.isLikeCheck!,
                _commentData.commant!,
                _commentData.likeCount!,
                _commentData.replyCount!,
                _commentData.isOwner!,
                _commentData.isBest!,
                (p0) {},
                (p0) {},
                (p0) {},
              ),
            ),
          ),
          for (int i = 0; i < _replyList.length; ++i)
            Padding(
              padding: const EdgeInsets.only(left: 80),
              child: Container(
                child: CommentWidget(
                  _replyList[i].ID,
                  _replyList[i].iconUrl!,
                  _replyList[i].episodeNumber!,
                  _replyList[i].name!,
                  _replyList[i].date!,
                  _replyList[i].isLikeCheck!,
                  _replyList[i].commant!,
                  _replyList[i].likeCount!,
                  _replyList[i].replyCount!,
                  _replyList[i].isOwner!,
                  _replyList[i].isBest!,
                  (p0) {},
                  (p0) {},
                  (p0) {},
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
