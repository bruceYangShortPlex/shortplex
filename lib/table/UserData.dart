import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shortplex/Network/UserInfo_Res.dart';
import '../Util/ShortplexTools.dart';

enum SelectResolutionType
{
  FHD,
  HD,
  SD,
}

class UserData extends GetxController
{
  static UserData get to => Get.find();

  var refreshCount = 0.obs;
  RxString name = 'Guest'.obs;
  RxString photoUrl = ''.obs;
  RxBool isLogin = false.obs;
  RxBool isFavoriteCheck = false.obs;
  RxString commentChange = ''.obs;
  RxBool isOpenPopup = false.obs;
  String email = '';
  String providerid = 'guest';
  String privacypolicies = 'true';
  String providerUid = '';
  RxBool isSubscription = false.obs;
  var popcornCount = 0.obs;
  var bonusCornCount = 0.obs;
  bool autoPlay = true;
  int usedPopcorn = 0;
  int usedBonusCorn = 0;
  String id = '';//barer token.
  String userId = ''; //server id
  SelectResolutionType selectResolution = SelectResolutionType.HD;

  String BirthDay = '';
  String Gender = '';
  String Country = '';
  String HP_Number = '';
  String HP_CountryCode = '';
  bool Acceptmarketing = true;

  InitValue()
  {
    name.value = 'Guest';
    photoUrl.value = '';
    isLogin.value = false;
    providerUid = 'guest';
    email = '';
    providerid = '';
    privacypolicies = 'true';
    isSubscription.value = false;
    popcornCount.value = 0;
    bonusCornCount.value = 0;
    BirthDay = '';
    Gender = '';
    HP_Number = '';
    HP_CountryCode = '';
    Country = '';
    Acceptmarketing = true;
  }

  Future SaveResoluton(int _index) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    selectResolution = SelectResolutionType.values[_index];
    await prefs.setInt('SR', selectResolution.index);

    print('save index : ${selectResolution.index} / name ${selectResolution.name}');
  }

  Future<SelectResolutionType> LoadResolution() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int index = prefs.getInt('SR') ?? 1;

    print('load index : $index');

    selectResolution = SelectResolutionType.values[index];

    print(selectResolution.name.toString());

    return selectResolution;
  }

  (String, String) GetPopupcornCount()
  {
    var formatter = NumberFormat('#,###');
    var popcornCount = formatter.format(this.popcornCount.value);
    var cornCount = formatter.format(this.bonusCornCount.value);
    return (popcornCount, cornCount);
  }

  String MoneyUpdate(String _currentPopcorn, String _currentBonuscorn)
  {
    String message = '';
    if (double.tryParse(_currentPopcorn) == false)
    {
      print('_currentPopcorn convert error');
      return message;
    }

    if (double.tryParse(_currentBonuscorn) == false)
    {
      print('_currentBonusPopcorn convert error');
      return message;
    }

    var currentPopcorn = double.parse(_currentPopcorn).toInt();
    var currentBonuscorn = double.parse(_currentBonuscorn).toInt();
    var addPopcorn = currentPopcorn - popcornCount.value;
    var addBonus = currentBonuscorn - bonusCornCount.value;

    if (addPopcorn > 0 && addBonus > 0)
    {
      message = SetTableStringArgument(300041, [addPopcorn.toString(), addBonus.toString()]);
    }
    else if (addPopcorn > 0)
    {
      message = SetTableStringArgument(300039, [addPopcorn.toString()]);
    }
    else if (addBonus > 0)
    {
      message = SetTableStringArgument(300040, [addBonus.toString()]);
    }

    popcornCount.value = currentPopcorn;
    bonusCornCount.value = currentBonuscorn;

    return message;
  }

  String GetProviderIcon()
  {
    String IconPath= '';
    if (providerid == 'guest')
    {
      IconPath = '';
    }
    else if (providerid == 'google')
    {
      IconPath = '';
    }
    else if (providerid == 'kakako')
    {
      IconPath = '';
    }
    else if (providerid == 'facebook')
    {
      IconPath = '';
    }
    else
    {
      print('아이콘을 찾지 못했습니다.');
    }

    return IconPath;
  }

  UpdateInfo(UserInfoRes? _data, [bool _refresh = true])
  {
    if (_data == null)
    {
      if (kDebugMode)
      {
        print('User Info Res is Null');
      }
      return;
    }

    for(var item in _data.data!.items!)
    {
      if (item.userId == userId)
      {
        BirthDay = item.birthDt;
        Gender = item.gender;
        HP_Number = item.hpNumber;
        HP_CountryCode = item.hpCountryCode;
        Country = item.countryCode;
        Acceptmarketing = item.acceptmarketing;

        print('Acceptmarketing : ${item.acceptmarketing}');

        break;
      }
    }

    if (_refresh) {
      refreshCount++;
      if (refreshCount.value == 0) {
        refreshCount++;
      }
    }

    if (kDebugMode)
    {
      print('User Info Update Complete');
    }
  }
}

class ContentData
{
  String? id;
  String? title;
  String? themeTitle;
  String? imagePath;
  String? thumbNail;
  bool isWatching = false;
  int? watchingEpisode;
  bool rank = false;
  int cost = 0;
  String? contentUrl;
  bool isLock = false;
  bool isCheck = false;
  String? contentTitle;
  String? releaseAt;
  String? landScapeImageUrl;
  String? description;
  String? genre;
  bool isAlarmCheck = false;
  String? shareUrl = '';

  ContentData
  (
    {
      required this.id,
      required this.title,
      required this.imagePath,
      required this.cost,
      required this.releaseAt,
      required this.landScapeImageUrl,
      required this.rank,
    }
  );

  bool get isNew
  {
    if (releaseAt!.isEmpty)
    {
      return false;
    }

    var release = DateTime.parse(releaseAt!);
    var current = DateTime.now();

    int differenceInDays = current.difference(release).inDays;

    return differenceInDays <= 14;
  }

  String GetReleaseDate()
  {
    if (releaseAt == null) {
      return '';
    }

    if (releaseAt!.isEmpty) {
      return '';
    }

    var date = DateTime.parse(releaseAt!);
    var year = date.year.toString().substring(2);
    var month = date.month.toString().padLeft(2, '0');
    var result = '$year.$month';
    return result;
  }
}
