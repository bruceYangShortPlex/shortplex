import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shortplex/Network/Content_Res.dart';

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
  String? imagePath;
  bool isNew = false;
  bool isWatching = false;
  String? watchingEpisode;
  int rank = 0;
  int cost = 0;
  String? contentUrl;
  bool isLock = false;
  bool isCheck = false;
  String? contentTitle;
  String? releaseAt;
  String? landScapeImageUrl;
  List<Episode>? episodeList;

  ContentData
  (
    {
      required this.id,
      required this.title,
      required this.imagePath,
      required this.cost,
      required this.releaseAt,
      required this.landScapeImageUrl,
    }
  );

  String GetReleaseDate()
  {
    if (releaseAt == null) {
      return '';
    }

    if (releaseAt!.isEmpty) {
      return '';
    }

    var date = DateTime.parse(releaseAt!);

    var result = '${date.year}.${date.month}';
    return result;
  }
}
