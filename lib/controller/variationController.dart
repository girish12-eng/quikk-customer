// import 'package:flutter/cupertino.dart';
// import 'package:quikk_customer/models/product_list.dart';
// import 'package:quikk_customer/repository/product_repo.dart';
//
// class VariationController extends ChangeNotifier {
//
//
//   ProductList? allProductList;
//
//   void init(String shopId) {
//     gettingProductList(shopId);
//   }
//
//   Future<ProductList?> gettingProductList(String shopId) async{
//     allProductList= await variationRepo("35");
//     print("allProductListDATA" + allProductList!.data!.products![15].variationss![2].name.toString());
//     return allProductList;
//   }
// }