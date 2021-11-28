import 'package:flutter/cupertino.dart';
import 'package:quikk_customer/models/market_category_model.dart';
import 'package:quikk_customer/models/product_model.dart';
import 'package:quikk_customer/repository/market_repo.dart';
import 'package:quikk_customer/repository/product_repo.dart';

class MarketScreenController extends ChangeNotifier {
  late List<ProductModel>? _products;
  // late List<Variationss>? _groupVariation=[];
  late List<MarketCategoryModel>? _categories;
  bool _loading = false;
  bool _catProductLoading = false;
  bool _isVeg = false;
  int? _catSelected;



  void init(String shopId) {
    _catSelected = null;
    _products = [];
    _categories = [];
    _isVeg = false;
    getProductsOfMarket(shopId);
  }

  // Future<ProductList?> gettingProductList(String shopId) async{
  //   _loading = true;
  //   // allProductList= await variationRepo(shopId);
  //   print("allProductListDATA" + allProductList!.data!.products![15].variationss![2].toString());
  //   notifyListeners();
  //   return allProductList;
  // }

  void getMarketCategory(String shopId) async {
    _loading = true;
    _categories = await getMarketCategoryRepo(shopId);
    notifyListeners();
  }

  void onCategoryButtonPressed(String shopId, String carId, int index) async {
    if (_catSelected == index) {
      _catSelected = null;
      getProductsOfMarket(shopId);
      notifyListeners();
      return;
    }
    _catSelected = index;
    _catProductLoading = true;
    notifyListeners();
    _products = [];
    _products = [];
    _products = await getMarketCategoryProductRepo(shopId, carId);
    _catProductLoading = false;
    notifyListeners();
  }


  void getProductsOfMarket(String shopId) async {
    print("SHOP ID CHECK 2" +shopId.toString() );
    _loading = true;
    _products = await getProductRepo(shopId) ?? [];
    _loading = false;
    _catProductLoading = false;
    notifyListeners();
  }

  List<ProductModel>? get getProducts {
    return _products;
  }
  // List<Variationss>? get getVariations {
  //   return _variation;
  // }




  void toggleIsVeg() {
    _isVeg = !_isVeg;
    notifyListeners();
  }

  bool get getLoading {
    return _loading;
  }

  bool get getCatProductLoading {
    return _catProductLoading;
  }

  List<MarketCategoryModel>? get getMarketCategories {
    return _categories;
  }

  bool get getIsVeg {
    return _isVeg;
  }

  int? get getSelectedCat {
    return _catSelected;
  }
}
