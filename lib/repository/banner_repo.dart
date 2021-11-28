import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quikk_customer/helper/config.dart';
import 'package:quikk_customer/models/banner_model.dart';

Future<List<BannerModel>> getBannerRepo() async {
  Uri url = Uri.parse(AppConfig.KBaseUrl + '/api/get-app-banner');
  var response = await http.get(url);
  print('[API CALL TO : getBannerRepo]');
  print('[RESPONSE CODE : ${response.statusCode}]');
  print('[RESPONSE BODY : ${response.body}]');
  if (response.statusCode == 200) {
    List<BannerModel> banner = [];
    for (Map data in json.decode(response.body)['data']) {
      banner.add(BannerModel.fromJson(data));
    }
    return banner;
  }
  return [];
}
