import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SelectResolutionType
{
  FHD,
  HD,
  SD,
}

class UserData extends GetxController
{
  static UserData get to => Get.find();

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
  RxInt popcornCount = 0.obs;
  int bonusCornCount = 0;
  bool autoPlay = true;
  int usedPopcorn = 0;
  int usedBonusCorn = 0;
  String recommendedName = '';
  String id = '';//barer token.
  String userId = ''; //server id
  SelectResolutionType selectResolution = SelectResolutionType.HD;


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
    bonusCornCount = 0;
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
    var cornCount = formatter.format(this.bonusCornCount);
    return (popcornCount, cornCount);
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

    var result = '';
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
