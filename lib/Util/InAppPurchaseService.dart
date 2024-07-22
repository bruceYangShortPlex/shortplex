import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

import '../sub/Home/HomeData.dart';
import 'HttpProtocolManager.dart';

/// 인앱 결제 서비스
class InAppPurchaseService extends GetxService
{
  static InAppPurchaseService get to => Get.find();

  // Instance ▼ ============================================

  /// 구매를 위한 인스턴스를 가져옵니다.
  final Rx<InAppPurchase> iap = InAppPurchase.instance.obs;

  // 구매 세부 정보에 대한 업데이트 스트림을 수신하는 구독
  late Rx<StreamSubscription?> subscription = (null as StreamSubscription?).obs;

  // Data ▼ ================================================

  /// 구매를 위한 인스턴스를 가져옵니다.
  RxString productID = '여기에 제품 ID'.obs;
  // Playstore 또는 앱 스토어에서 쿼리한 제품 목록 유지
  RxList<ProductDetails> products = <ProductDetails>[].obs;
  // 과거 구매 사용자 목록
  RxList<PurchaseDetails> purchases = <PurchaseDetails>[].obs;

  // Function ▼ ============================================
  Future<bool> getProducts() async
  {
    var result = false;
    if (HomeData.to.productList.isNotEmpty)
    {
      if (kDebugMode) {
        print('Already List');
      }

      return true;
    }

    await HttpProtocolManager.to.Get_Products().then((value)
    {
      if (value != null)
      {
        if (value.data!.items!.isEmpty)
        {
          print('Products list is Zero !!!!!!');
        }
        else
        {
          print('Get_Products result : ${value.data!.items!.length}');
          HomeData.to.productList.value = value.data!.items!;
          result = true;
        }
      }
    },);

    return result;
  }
  /// 상품 목록 조회 방법
  ///
  /// Future<void>
  Future<void> fetchUserProducts() async
  {
    List<String> _kProductIds = <String>[];

    for(var item in HomeData.to.productList)
    {
      _kProductIds.add(item.id);
    }

    if (Platform.isIOS)
    {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      iap.value
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(PaymentQueueDelegate());
    }

    // 구매를 위한 인스턴스를 가져옵니다.
    ProductDetailsResponse response = await iap.value.queryProductDetails(_kProductIds.toSet());

    if (response.error != null)
    {
      print('response.productDetails : ${response.error}');
      return;
    }

    if (response.productDetails.isEmpty)
    {
      print('response.productDetails : ${response.productDetails}');
    }

    // 제품 목록 데이터 추가
    products.assignAll(response.productDetails);
  }

  /// 과거 구매 사용자를 검색하는 방법
  ///
  /// @return Future<void>
  Future<void> fetchPastPurchases() async {
    /// 모든 이전 구매를 복원합니다.
    /// `applicationUserName`은 초기 `PurchaseParam`에서 전송된 내용과 일치해야 합니다.
    /// 초기 `PurchaseParam`에 `applicationUserName`이 지정되지 않은 경우 null을 사용합니다.
    /// 복원된 구매는 [PurchaseStatus.restored] 상태로 [purchaseStream]을 통해 전달됩니다.
    /// 이러한 구매를 수신하고, 영수증을 확인하고, 콘텐츠를 전달하고, 각 구매에 대해 [finishPurchase] 메서드를 호출하여 구매 완료를 표시해야 합니다.
    /// 이것은 소비된 제품을 반환하지 않습니다.
    /// `사용하지 않는 소모품을 복원하려면 자체 서버에서 사용자에 대한 소모품 정보를 유지해야 합니다.`
    // await iap.value.restorePurchases();
  }

  /// 상품을 이미 구매했는지 여부를 확인하는 방법입니다.
  ///
  /// @return void
  bool verifyPurchases()
  {
    try
    {
      PurchaseDetails purchase = purchases.firstWhere
      (
            (purchase) => purchase.productID == productID.value,
      );
      if (purchase.status == PurchaseStatus.purchased)
      {
        // 구매 완료
        return true;
      }
    } catch (e)
    {
      // 구매 미완료
    }

    return false;
  }

  /// 제품 구매 방법
  ///
  /// [prod] 구매할 제품
  ///
  /// @return 구매 성공 여부
  @required
  void purchaseProduct(ProductDetails prod) async
  {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);
    await iap.value.buyConsumable(purchaseParam: purchaseParam, autoConsume: false).then((value)
    {
      if (value)
      {
        productID.value = prod.id;
      }
    },);
  }

  /// 구매 세부 정보에 대한 업데이트 스트림을 수신하는 구독
  ///
  /// @return Future<void>
  Future<void> Initialize() async
  {
    try
    {
      print('InAppPurchaseService Initialize Start');
      await getProducts();
      // 인앱 구매가 가능한지 체크

      final bool isAvailable = await iap.value.isAvailable();
      if (isAvailable) {
        print('InAppPurchaseService iap.value.isAvailable true');
        // 구매 가능한 상품 목록 조회
        await fetchUserProducts();
        // 과거 구매 사용자 목록 조회
        // await fetchPastPurchases();
        // 상품을 이미 구매했는지 체크
        verifyPurchases();
        // 구매 세부 정보에 대한 업데이트 스트림을 수신하는 구독
        subscription.value = iap.value.purchaseStream.listen((data)
        {
          // 구매 세부 정보를 업데이트
          purchases.addAll(data);
          // 상품을 이미 구매했는지 체크
          verifyPurchases();
        });
      }
      else {
        print('isAvailable fail');
      }
    }
    catch(e)
    {
      print('iap init fail : $e');
    }
  }

  @override
  Future<void> onInit() async 
  {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose()
  {
    if (Platform.isIOS)
    {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      iap.value.getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }

    // 구독 해제
    subscription.value?.cancel();

    super.onClose();
  }

  void BuyProduct(String _id)
  {
    if (products.any((element) => element.id == _id))
    {
      var details = products.firstWhere((element) => element.id == _id);
      purchaseProduct(details);
    }
  }
}

class PaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}