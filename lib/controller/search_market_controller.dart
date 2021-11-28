import 'package:flutter/cupertino.dart';
import 'package:quikk_customer/models/market_model.dart';
import 'package:quikk_customer/repository/market_repo.dart';

class SearchMarketController extends ChangeNotifier {
  List<MarketModel> _shops = [];

  void init() {
    _shops = [];
  }

  void onSearch(String v, String lat, String lng) async {
    print('ssssssssssssssss');
    if (v.isEmpty) {
      _shops = [];
    }
    if (v.isNotEmpty) {
      _shops = await searchMarketModel(v, lat, lng);
    }

    notifyListeners();
  }

  List<MarketModel> get getShops {
    return _shops;
  }
}
