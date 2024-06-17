import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager
{
  static RewardedAd? rewardedAd;

  static Future<void> initGoogleMobileAds()
  {
    // Google Mobile Ads SDK 초기화
    return MobileAds.instance.initialize();
  }

  static void loadRewardedAd(Function onReward)
  {
      RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback:
      RewardedAdLoadCallback
      (
        onAdLoaded: (RewardedAd ad)
        {
          print('reward load complete');
          // 광고 로드 성공 시
          ad.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward)
          {
            // 사용자가 광고를 시청하고 보상을 받았을 때 호출될 함수
            print('on reward complete');
            onReward(reward);
          });
        },
        onAdFailedToLoad: (LoadAdError error)
        {
          onReward(null);
          // 광고 로드 실패 시
          print('RewardedAd failed to load: $error');
        },
      ),
    );
  }

  // 여기에 광고 단위 ID를 입력하세요.
  static String get rewardedAdUnitId {
    if (Platform.isAndroid)
    {
      //real
      //'ca-app-pub-6209332264163024/6217002837'
      //test
      return "ca-app-pub-3940256099942544/5224354917";
    }
    else if
    (Platform.isIOS)
    {
      //real
      //ca-app-pub-6209332264163024/7309758509
      //test
      return "ca-app-pub-3940256099942544/1712485313";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
