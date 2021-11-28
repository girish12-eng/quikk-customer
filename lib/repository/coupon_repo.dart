import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quikk_customer/helper/config.dart';
import 'package:quikk_customer/models/coupon_model.dart';

Future<List<CouponModel>> getCouponsRepo(String token) async {
  Uri url = Uri.parse(AppConfig.KBaseUrl + '/api/getcoupons?token=$token');
  var response = await http.get(url, headers: {
    'Authorization': 'Bearer $token',
  });

  print('[API CALL TO : getCouponsRepo]');
  print('[RESPONSE CODE : ${response.statusCode}]');
  print('[RESPONSE BODY : ${response.body}]');
  if (response.statusCode == 200) {
    List<CouponModel> coupons = [];
    for (Map data in json.decode(response.body)['data']) {
      coupons.add(CouponModel.fromJson(data));
    }
    return coupons;
  }
  return [];
}
