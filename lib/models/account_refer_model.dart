class AccountReferModel {
  bool? success;
  int? coinBalance;
  String? referalCoin;
  String? userRefcode;

  AccountReferModel({
      this.success, 
      this.coinBalance, 
      this.referalCoin, 
      this.userRefcode});

  AccountReferModel.fromJson(dynamic json) {
    success = json["success"];
    coinBalance = json["coin_balance"];
    referalCoin = json["referal_coin"];
    userRefcode = json["user_refcode"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = success;
    map["coin_balance"] = coinBalance;
    map["referal_coin"] = referalCoin;
    map["user_refcode"] = userRefcode;
    return map;
  }

}