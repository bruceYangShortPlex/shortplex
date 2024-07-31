import 'Preorder_Res.dart';

/// payment_provider : "google"
/// payment_data : {"productId":"40003","orderId":"test-transaction-id"}
/// order_id : "OD57"

class PreorderPatchReq
{
  PreorderPatchReq(
  {
      required String paymentProvider,
      required PreorderPaymentData paymentData,
      required String orderId,}){
    _paymentProvider = paymentProvider;
    _paymentData = paymentData;
    _orderId = orderId;
}

  PreorderPatchReq.fromJson(dynamic json) {
    _paymentProvider = json['payment_provider'];
    _paymentData = json['payment_data'] != null ? PreorderPaymentData.fromJson(json['payment_data']) : null;
    _orderId = json['order_id'];
  }
  String _paymentProvider = '';
  PreorderPaymentData? _paymentData;
  String _orderId = '';

  String get paymentProvider => _paymentProvider;
  PreorderPaymentData? get paymentData => _paymentData;
  String get orderId => _orderId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['payment_provider'] = _paymentProvider;
    final _paymentData = this._paymentData;
    if (_paymentData != null) {
      map['payment_data'] = _paymentData.toJson();
    }
    map['order_id'] = _orderId;
    return map;
  }

}