import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quikk_customer/helper/config.dart';
import 'package:quikk_customer/models/category_model.dart';
import 'package:quikk_customer/models/market_category_model.dart';
import 'package:quikk_customer/models/market_model.dart';

Future<List<MarketModel>?> getShopsRepo(
    String latitude, String longitude) async {
  final url = Uri.parse(AppConfig.KApiUrl + 'getShops');
  print("SHOPS ACTIVE===>>>$url");
  List<MarketModel> shops = [];
  var response = await http.get(url, headers: {
    "X-FOOD-LAT": "$latitude",
    "X-FOOD-LONG": "$longitude",
    "Accept": "application/json"
  });
  print(response.body);
  if (response.statusCode == 200 &&
      json.decode(response.body)['data']['shops'] != null) {
    for (Map shop in json.decode(response.body)['data']['shops']) {
      shops.add(MarketModel.fromJson(shop));
    }
    return shops;
  } else {
    return null;
  }
}

Future<List<CategoryModel>> getAllCategoriesRepo() async {
  Uri url = Uri.parse('${AppConfig.KBaseUrl}/api/get-all-categories');
  print("SHOPS ACTIVE getAllCategoriesRepo ===>>>$url");
  var response = await http.get(url);
  print('[API CALL TO : getAllCategoriesRepo ]');
  print('[RESPONSE CODE : ${response.statusCode}]');
  print('[RESPONSE BODY : ${response.body}]');
  print('[RESPONSE BODY : ${json.decode(response.body)['data']}');
  if (response.statusCode == 200) {
    List<CategoryModel> categories = [];
    for (Map category in json.decode(response.body)['data']) {
      categories.add(CategoryModel.fromJson(category));
    }
    return categories;
  }
  return [];
}

Future<List<MarketModel>> searchMarketModel(
    String search, String lat, String lng) async {
  Uri url = Uri.parse(AppConfig.KApiUrl + 'search/shops/' + search);
  print("SHOPS ACTIVE Girish2 ===>>>$url");
  print(url);
  var response = await http.get(url, headers: {
    'X-FOOD-LAT': lat,
    'X-FOOD-LONG': lng,
  });

  print('[API CALL TO : searchMarketModel]');
  print('[RESPONSE CODE : ${response.statusCode}]');
  print('[RESPONSE BODY : ${response.body}]');
  if (response.statusCode == 200) {
    List<MarketModel> shops = [];
    for (Map data in json.decode(response.body)['data']) {
      shops.add(MarketModel.fromJson(data));
    }
    return shops;
  }
  return [];
}

Future<int> getDeliveryChargeRepo(int amount) async {
  print('fdshgjfjfjkigkigkyujtyfhtehrth');
  print(amount);
  Uri url = Uri.parse(AppConfig.KBaseUrl + '/api/getdeliverycharges/$amount');
  var response = await http.get(url);

  print('[API CALL TO : getDeliveryChargeRepo]');
  print('[RESPONSE CODE : ${response.statusCode}]');
  print('[RESPONSE BODY : ${response.body}]');
  if (response.statusCode == 200) {
    return json.decode(response.body)['data'];
  }
  return 0;
}

Future<List<MarketModel>> getMarketByCategoryRepo(
    String catId, String lat, String lng) async {
  Uri url = Uri.parse(
      AppConfig.KBaseUrl + '/api/getcategoryShops?category_id=$catId');
  print("Girish3==>>> $url");
  var response = await http.get(
    url,
    headers: {
      'X-FOOD-LAT': lat,
      'X-FOOD-LONG': lng,
    },
  );

  print('[API CALL TO : getMarketByCategoryRepo]');
  print('[RESPONSE CODE : ${response.statusCode}]');
  print('[RESPONSE BODY : ${response.body}]');
  if (response.statusCode == 200) {
    List<MarketModel> markets = [];
    for (Map data in json.decode(response.body)['data']['shops']) {
      markets.add(MarketModel.fromJson(data));
    }
    return markets;
  }
  return [];
}

Future<List<MarketCategoryModel>?> getMarketCategoryRepo(String shopId) async {
  Uri url =
      Uri.parse(AppConfig.KBaseUrl + '/api/getshopallcatgory?shop_id=$shopId');
  print("Girisg4==>>> $url");
  var response = await http.get(url);
  if (response.statusCode == 200) {
    List<MarketCategoryModel> list = [];
    for (Map category in json.decode(response.body)['data']) {
      list.add(
        MarketCategoryModel.fromJson(category),
      );
    }
    return list;
  }
  return null;
}
