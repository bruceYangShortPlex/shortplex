/// payment_provider : "shortplex"
/// payment_data : {"product_type":"episode","product_id":"EP33"}

class BuyEpisodeReq
{
  BuyEpisodeReq({
     required String paymentProvider,
     required EpisodePaymentData paymentData,}){
    _paymentProvider = paymentProvider;
    _paymentData = paymentData;
}

  BuyEpisodeReq.fromJson(dynamic json) {
    _paymentProvider = json['payment_provider'];
    _paymentData = json['payment_data'] != null ? EpisodePaymentData.fromJson(json['payment_data']) : null;
  }
  String _paymentProvider = '';
  EpisodePaymentData? _paymentData;

  String get paymentProvider => _paymentProvider;
  EpisodePaymentData? get paymentData => _paymentData;

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

/// product_type : "episode"
/// product_id : "EP33"

class EpisodePaymentData {
  EpisodePaymentData({
     required String productType,
     required String productId,}){
    _productType = productType;
    _productId = productId;
}

  EpisodePaymentData.fromJson(dynamic json) {
    _productType = json['product_type'];
    _productId = json['product_id'];
  }
  String _productType = '';
  String _productId = '';

  String get productType => _productType;
  String get productId => _productId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_type'] = _productType;
    map['product_id'] = _productId;
    return map;
  }
}