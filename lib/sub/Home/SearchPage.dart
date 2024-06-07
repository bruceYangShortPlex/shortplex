
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shortplex/sub/ContentInfoPage.dart';
import 'package:shortplex/table/StringTable.dart';

const int _pageSize = 30;
enum SearchType
{
  ALL,
  ROMANCE,
  FANTASY,
  ROFAN,
  ACTION,
  HISTORICAL,
  JAEBEOL,
  EVENT,
}

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

  @override
  void initState()
  {
    _pagingController.addPageRequestListener((pageKey)
    {
      _fetchPage(pageKey);
    });

    if (Get.arguments != null) {
      selectedType = Get.arguments as SearchType;
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
                    searchTypeSelectButton(SearchType.ALL, StringTable().Table![100021]!),
                    searchTypeSelectButton(SearchType.ROMANCE, StringTable().Table![500001]!),
                    searchTypeSelectButton(SearchType.FANTASY, StringTable().Table![500002]!),
                    searchTypeSelectButton(SearchType.ROFAN, StringTable().Table![500003]!),
                  ],
                ),
                SizedBox(height: 10,),
                Row
                (
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:
                  [
                    searchTypeSelectButton(SearchType.ACTION, StringTable().Table![500004]!),
                    searchTypeSelectButton(SearchType.HISTORICAL, StringTable().Table![500005]!),
                    searchTypeSelectButton(SearchType.JAEBEOL, StringTable().Table![500006]!),
                    searchTypeSelectButton(SearchType.EVENT, StringTable().Table![500006]!),
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

  SearchType selectedType = SearchType.ALL;

  Widget searchTypeSelectButton(SearchType _type, String _title, )
  {
    //var index = _index;
    return
    GestureDetector
    (
      onTap: ()
      {
        setState(()
        {
          selectedType = _type;
        });

        _pagingController.refresh();
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
            color: selectedType == _type ? Colors.white : Colors.white.withOpacity(0.6),
            fontFamily: 'NotoSans', fontWeight: FontWeight.bold,),
        ),
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async
  {
    print('_fetch page  selectedSearchIndex : ${selectedType}');
    try
    {
      // Replace with your method to fetch data from the server.
      final newItems = await Future<List<Widget>>.delayed(Duration(seconds: 1),
            ()
            {
              var list = <Widget>[];

              for(int i = 0 ; i < 30 ; ++i)
                {
                  list.add(gridItem());
                }

              //여기서 리스트 요청하고 만들고 해야한다.
              return list;
            }
      );

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

  Widget gridItem()
  {
    return
    GestureDetector
    (
      onTap: ()
      {
        //print('grid item on tap');
        Get.to(() => ContentInfoPage());
      },
      child: Container
      (
        width: 105,
        height: 160,
        decoration: ShapeDecoration(
          color: Color(0xFFC4C4C4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        ),
      ),
    );
  }

  Widget GridViw()
  {
    return
    Expanded
    (
      child: Container
      (
        width: 390,
        height: MediaQuery.of(context).size.height - 160,
        child:
        PagedGridView<int, Widget>
        (
          pagingController: _pagingController,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount
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
