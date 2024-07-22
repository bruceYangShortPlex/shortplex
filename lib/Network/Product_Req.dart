/// payment_provider : "google"
/// payment_data : {"productId":"PD3"}

class ProductReq
{
  ProductReq(
  {
     required String paymentProvider,
     required PaymentData paymentData,}){
    _paymentProvider = paymentProvider;
    _paymentData = paymentData;
}

  ProductReq.fromJson(dynamic json) {
    _paymentProvider = json['payment_provider'];
    _paymentData = json['payment_data'] != null ? PaymentData.fromJson(json['payment_data']) : null;
  }
  String _paymentProvider = '';
  PaymentData? _paymentData;

  String get paymentProvider => _paymentProvider;
  PaymentData? get paymentData => _paymentData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['payment_provider'] = _paymentProvider;
    final _paymentData = this._paymentData;
    if (_paymentData != null) {
      map['payment_data'] = _paymentData.toJson();
    }
    return map;
  }

}

/// productId : "PD3"

class PaymentData
{
  PaymentData({
     required String productId,}){
    _productId = productId;
}

  PaymentData.fromJson(dynamic json) {
    _productId = json['productId'] ?? '';
  }

  String _productId = '';
  String get productId => _productId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = _productId;
    return map;
  }
}