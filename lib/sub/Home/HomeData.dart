import 'package:get/get.dart';

import '../../table/UserData.dart';

class HomeData extends GetxController
{
  static HomeData get to => Get.find();

  static var _pageList = <ContentData>[];
  static var _watchingContentsDataList = <ContentData>[];
  static var _rankContentsDataList = <ContentData>[];
  static var _themesList = <List<ContentData>>[];

  get pageList => _pageList;
  get watchingContentsDataList => _watchingContentsDataList;
  get rankContentsDataList => _rankContentsDataList;
  get themesList => _themesList;

  void SetPageList(List<ContentData> _list)
  {
    _pageList = _list;
  }

  void SetWatchList(List<ContentData> _list)
  {
    _watchingContentsDataList = _list;
  }

  void SetRankList(List<ContentData> _list)
  {
    _rankContentsDataList = _list;
  }

  void SetThemesList(List<List<ContentData>> _list)
  {
    _themesList = _list;
  }

}