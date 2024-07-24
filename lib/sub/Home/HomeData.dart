import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Network/Product_Res.dart';
import '../../table/UserData.dart';

class HomeData extends GetxController
{
  static HomeData get to => Get.find();

  static var _productIcons = <String>
  [
    'assets/images/user/my_popcon.png',
    'assets/images/shop/my_popcon2.png',
    'assets/images/shop/my_popcon3.png',
    'assets/images/shop/my_popcon4.png',
    'assets/images/shop/my_popcon5.png',
    'assets/images/shop/my_popcon6.png',
    'assets/images/user/my_pass_icon.png',
  ];

  static var _pageList = <ContentData>[];
  static var _watchingContentsDataList = <ContentData>[];
  static var _rankContentsDataList = <ContentData>[];
  static Map<String, List<ContentData>> _themesList = {};
  static var _recentList = <ContentData>[];
  var productList = <ProductItem>[].obs;

  get pageList => _pageList;
  get watchingContentsDataList => _watchingContentsDataList;
  get rankContentsDataList => _rankContentsDataList;
  get themesList => _themesList;
  get recentList => _recentList;
  get productIcons => _productIcons;

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
    if (_isSubscription)
    {
      index = 6;
    }
    else
    {
      if (_popcornCount == '40.00') {
        index = 1;
      }
      else if (_popcornCount == '80.00') {
        index = 2;
      }
      else if (_popcornCount == '140.00') {
        index = 3;
      }
      else if (_popcornCount == '200.00') {
        index = 4;
      }
      else if (_popcornCount == '300.00') {
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
}