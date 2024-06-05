import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserData extends GetxController
{
  static UserData get to => Get.find();

  RxString name = 'Guest'.obs;
  RxString photoUrl = ''.obs;
  RxBool isLogin = false.obs;
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

  List<ContentData> ContentDatas = <ContentData>[];

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
    ContentDatas.clear();
  }

  (String, String) GetPopupcornCount()
  {
    var formatter = NumberFormat('#,###');
    var popcornCount = formatter.format(this.popcornCount.value);
    var cornCount = formatter.format(this.bonusCornCount);
    return (popcornCount, cornCount);
  }

  int GetContentCost(int _episode)
  {
    if (_episode >= ContentDatas.length)
    {
      return -1;
    }

    if (isSubscription.value == true)
    {
      return 0;
    }

    for(var item in ContentDatas)
    {
      if (item.id == _episode)
        {
          return item.cost!;
        }
    }

    return -1;
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
  int? id;
  String? title;
  String? imagePath;
  bool? isNew;
  bool? isWatching;
  String? watchingEpisode;
  int? rank;
  int? cost;
  String? contentUrl;
  bool isLock = true;
  bool isCheck = false;

  ContentData
  (
    {
      required this.id,
      required this.title,
      required this.imagePath,
      required this.cost,
    }
  );
}
