import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shortplex/Network/Content_Res.dart';

import '../../Network/Product_Res.dart';
import '../../Util/HttpProtocolManager.dart';
import '../../table/UserData.dart';
import '../Reward/RewardPage.dart';

class HomeData extends GetxController
{
  static HomeData get to => Get.find();

  static var _productIcons = <String>
  [
    'assets/images/user/my_popcorn.png',
    'assets/images/shop/my_popcorn2.png',
    'assets/images/shop/my_popcorn3.png',
    'assets/images/shop/my_popcorn4.png',
    'assets/images/shop/my_popcorn5.png',
    'assets/images/shop/my_popcorn6.png',
    'assets/images/user/my_pass_icon.png',
  ];

  static var _pageList = <ContentData>[];
  static var _watchingContentsDataList = <ContentData>[];
  static var _rankContentsDataList = <ContentData>[];
  static Map<String, List<ContentData>> _themesList = {};
  static var _recentList = <ContentData>[];
  var productList = <ProductItem>[].obs;
  RxList dailyMissionList = <DailyMissionData>[].obs;

  get pageList => _pageList;
  get watchingContentsDataList => _watchingContentsDataList;
  get rankContentsDataList => _rankContentsDataList;
  get themesList => _themesList;
  get recentList => _recentList;
  get productIcons => _productIcons;

  RxList listEpisode = <Episode>[].obs;

  String titleSchoolImageUrl = '';

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

  void SetThemesList(Map<String,List<ContentData>> _map)
  {
    _themesList = _map;
  }

  void SetRecentList(List<ContentData> _list)
  {
    _recentList = _list;
  }

  String GetPrice(String _pid)
  {
    var formatter = NumberFormat('#,###');
    if (productList.any((element) => element.id == _pid))
    {
      var item = productList.firstWhere((element) => element.id == _pid);
      var price = double.parse(item.price).toInt();

      var priceTag = '';
      if (item.currency == 'KRW');
      {
        priceTag = '₩';
      }

      return '$priceTag${formatter.format(price)}';
    }

    return formatter.format(99999);
  }

  String GetSubscriptionPrice()
  {
    var formatter = NumberFormat('#,###');
    if (productList.any((element) => element.productType == 'subscription'))
    {
      var item = productList.firstWhere((element) => element.productType == 'subscription');
      var price = double.parse(item.price).toInt();
      var priceTag = '';
      if (item.currency == 'KRW');
      {
        priceTag = '₩';
      }
      return '$priceTag${formatter.format(price)}';
    }

    return formatter.format(99999);
  }

  String GetShopIcon(String _popcornCount, bool _isSubscription)
  {
    var index = 0;
    var count = 0;
    if (double.tryParse(_popcornCount) != null)
    {
      count = double.parse(_popcornCount).toInt() ;
    }
    else
    {
      return productIcons[index];
    }

    if (_isSubscription)
    {
      index = 6;
    }
    else
    {
      if (20 < count && count <= 40 )
      {
        index = 1;
      }
      else if (40 < count && count <= 80 )
      {
        index = 2;
      }
      else if (80 < count && count <= 140 )
      {
        index = 3;
      }
      else if (140 < count && count <= 200 )
      {
        index = 4;
      }
      else if (200 < count)
      {
        index = 5;
      }
    }

    if (index >= productIcons.length)
    {
      index= 0;
    }

    //print('index : $index / _popcornCount : $_popcornCount');

    return productIcons[index];
  }

  String GetSubscriptionID()
  {
    if (productList.any((element) => element.productType == 'subscription'))
    {
      var item = productList.firstWhere((element) => element.productType == 'subscription');
      return item.id;
    }

    return '';
  }

  GetMisstionList()
  {
    dailyMissionList.clear();

    HttpProtocolManager.to.Get_DailyMissions().then((value)
    {
      if(value == null) {
        return;
      }

      for(var item in value.data!.items!)
      {
        var missionTestData = DailyMissionData();
        missionTestData.SetMissionType(item.nameCd);
        missionTestData.title = item.name;
        missionTestData.missionCompleteCount = item.mission_cnt;
        missionTestData.totalMissionCount = item.maxCnt;
        missionTestData.isReceive = !item.isActive;
        missionTestData.isVisible = item.visibility;
        dailyMissionList.add(missionTestData);
      }
    });
  }

  String GetShopID(String _pid)
  {
    var result = '';
    if (productList.any((element) => element.id == _pid))
    {
      var item = productList.firstWhere((element) => element.id == _pid);
      result = item.shopid;
    }

    return result;
  }

  Episode? GetEpisode(String _eid)
  {
    Episode result = listEpisode.firstWhere(
          (element) => element.id == _eid,
      orElse: ()
      {
        return null;
      },
    );

    return result;
  }

  Episode? EpisodeBuyUpdate(String _eid)
  {
    Episode? result;
    for(int i = 0; i < listEpisode.length; ++i)
    {
      if (listEpisode[i].id == _eid)
      {
        var item = listEpisode[i];
        item.owned = true;
        listEpisode[i] = item;
        result = item;
        break;
      }
    }
    
    return result;
  }
}