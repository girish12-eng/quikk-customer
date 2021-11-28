import 'package:flutter/material.dart';
import 'package:quikk_customer/models/product_model.dart';
import 'package:quikk_customer/repository/product_repo.dart';

class SearchProductController extends ChangeNotifier {
  late List<ProductModel> _products;
  // late List<Variationss>? _variation;
  int? marketId;

  void init(int id) {
    _products = [];
    marketId = id;
    // _variation=[];
  }

  void onSearch(String v) async {
    print('ssssssssssssssss');
    if (v.isEmpty) {
      _products = [];
    }
    if (v.isNotEmpty) {
      _products = await searchProductRepo(marketId.toString(), v);
    }
    notifyListeners();
  }

  List<ProductModel> get getProducts {
    return _products;
  }

  // List<Variationss>? get getVariations {
  //   return _variation;
  // }
}
