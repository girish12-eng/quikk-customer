import 'package:flutter/cupertino.dart';
import 'package:quikk_customer/models/market_model.dart';
import 'package:quikk_customer/repository/market_repo.dart';

class MarketByCategoryController extends ChangeNotifier {
  late List<MarketModel> markets;
  bool loading = false;

  void init(String catId, String lat, String lng) async {
    markets = [];
    getMarketsByCategory(catId, lat, lng);
  }

  void getMarketsByCategory(String catId, String lat, String lng) async {
    loading = true;
    markets = await getMarketByCategoryRepo(catId, lat, lng);
    loading = false;
    notifyListeners();
  }
}
