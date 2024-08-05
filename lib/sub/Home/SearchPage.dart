import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shortplex/Util/HttpProtocolManager.dart';
import 'package:shortplex/sub/ContentInfoPage.dart';
import 'package:shortplex/table/StringTable.dart';

import '../../table/UserData.dart';

const int _pageSize = 15;

class SearchPage extends StatefulWidget
{
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
{
  final PagingController<int, Widget> _pagingController =
  PagingController(firstPageKey: 0);

  final searchIDs = [100021,500001,500002,500003,500004,500005,500006,800021];
  int downloadPage = 0;
  @override
  void initState()
  {
    _pagingController.addPageRequestListener((pageKey)
    {
      _fetchPage(pageKey);
    });

    if (Get.arguments != null) {
      selectedType = Get.arguments as SearchGroupType;
    }

    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
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
            backgroundColor: Colors.black.withOpacity(0.85),
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
                  // child:
                  // Text
                  // (
                  //   StringTable().Table![400021]!,
                  //   style:
                  //   TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
                  // ),
                ),
                Container(width: MediaQuery.of(context).size.width * 0.3, height: 50,)
              ],
            ),
          ),
          child:
          Container
          (
            padding: EdgeInsets.only(top: 60),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            //color: Colors.blue,
            child:
            Column
            (
              children:
              [
                Row
                (
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:
                  [
                    searchTypeSelectButton(SearchGroupType.ALL, StringTable().Table![100021]!),
                    searchTypeSelectButton(SearchGroupType.ROMANCE, StringTable().Table![500001]!),
                    searchTypeSelectButton(SearchGroupType.FANTASY, StringTable().Table![500002]!),
                    searchTypeSelectButton(SearchGroupType.ROFAN, StringTable().Table![500003]!),
                  ],
                ),
                SizedBox(height: 10,),
                Row
                (
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:
                  [
                    searchTypeSelectButton(SearchGroupType.ACTION, StringTable().Table![500004]!),
                    searchTypeSelectButton(SearchGroupType.HISTORICAL, StringTable().Table![500005]!),
                    searchTypeSelectButton(SearchGroupType.JAEBEOL, StringTable().Table![500006]!),
                    searchTypeSelectButton(SearchGroupType.EVENT, StringTable().Table![800021]!),
                    //SizedBox(width: 73,)
                  ],
                ),
                SizedBox(height: 30,),
                GridViw(),
              ],
            ),
          ),
        ),
      ),
    );

  SearchGroupType selectedType = SearchGroupType.ALL;

  Widget searchTypeSelectButton(SearchGroupType _type, String _title, )
  {
    //var index = _index;
    return
    GestureDetector
    (
      onTap: ()
      {
        if (selectedType == _type) {
          return;
        }
        downloadPage = 0;
        setState(()
        {
          selectedType = _type;
          _pagingController.refresh();
        });
      },
      child:
      Container
      (
        width: 73,
        height: 30,
        decoration: ShapeDecoration
        (
          color: Color(0xFF1E1E1E),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.50, color:  selectedType == _type ? Color(0xFF00FFBF) : Color(0xFF878787)),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 1),
        child:
        Text
        (
          _title,
          style:
          TextStyle
          (
            fontSize: 11,
            color: selectedType == _type ? Colors.white : Colors.grey,
            fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
        ),
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async
  {
    try
    {
      var newItems = <Widget>[];
      Get.lazyPut(() => HttpProtocolManager());

      var url = 'https://www.quadra-system.com/api/v1/home/all?page=$downloadPage&itemsPerPage=15&genre_cd=${searchIDs[selectedType.index]}';
      if (selectedType == SearchGroupType.ALL)
      {
        url = 'https://www.quadra-system.com/api/v1/home/all?page=$downloadPage&itemsPerPage=15';
      }
      await HttpProtocolManager.to.Get_SearchData(url).then((value)
      {
        for (var item in value!.data!.items!)
        {
          var data = ContentData
          (
            id: item.id,
            title: item.title ?? '타이틀 없음',
            imagePath: item.posterPortraitImgUrl,
            cost: 0,
            releaseAt: item.releaseAt ?? '',
            landScapeImageUrl: item.posterLandscapeImgUrl,
            rank: item.topten,
          );
          data.thumbNail = item.thumbnailImgUrl;
          data.contentTitle = item.subtitle ?? '';

          newItems.add(gridItem(data));
        }
        downloadPage++;
      });

      final isLastPage = newItems.length < _pageSize;
      if (isLastPage)
      {
        _pagingController.appendLastPage(newItems);
      }
      else
      {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    }
    catch (error)
    {
      _pagingController.error = error;
    }
  }

  Widget gridItem(ContentData _item)
  {
    return
    GestureDetector
    (
      onTap: ()
      {
        Get.to(() => ContentInfoPage(), arguments: _item);
      },
      child:
      Container
      (
        width: 105,
        height: 160,
        // decoration: ShapeDecoration(
        //   color: Color(0xFFC4C4C4),
        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        // ),
        child:
        ClipRRect
        (
          borderRadius: BorderRadius.circular(7),
          child:
          _item.thumbNail != null && _item.thumbNail!.isNotEmpty ?
          Image.network(_item.thumbNail!, fit: BoxFit.cover,) : SizedBox(),
        ),
      ),
    );
  }

  Widget GridViw()
  {
    return
    Expanded
    (
      child:
      Container
      (
        width: 390,
        height: MediaQuery.of(context).size.height - 160,
        child:
        PagedGridView<int, Widget>
        (
          pagingController: _pagingController,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount
          (
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 105 / 160,
            crossAxisCount: 3,
          ),
          builderDelegate:
          PagedChildBuilderDelegate<Widget>
          (
            itemBuilder: (context, item, index) =>
            GridTile
            (
              child: item,
            ),
          ),
        ),
      ),
    );
  }
}
