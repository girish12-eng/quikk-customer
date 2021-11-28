import 'dart:convert';
import 'package:quikk_customer/helper/config.dart';
import 'package:http/http.dart' as http;
import 'package:quikk_customer/models/product_list.dart';
import 'package:quikk_customer/models/product_model.dart';

Future<ProductList?> variationRepo(String shopId) async {
  Uri url = Uri.parse(AppConfig.KApiUrl + 'shops/$shopId/products');
  var response = await http.get(url);
  print('[API CALL TO : variationRepoGIRISH]');
  print('[RESPONSE CODE : ${response.statusCode}]');
  print('[RESPONSE BODY : ${response.body}]');
  if (response.statusCode == 200) {
    ProductList products=ProductList.fromJson(jsonDecode(response.body));
    return products;
//     List<VariationResponse> products = List.empty(growable: true);
//     for (Map product in json.decode(response.body)['variationss']) {
//       products.add(
//         VariationResponse.fromJson(product),
//       );
//   return null;
// }
  }
  else{
    return Future.error("API not successfully hit");
  }
}


Future<List<ProductModel>?> getProductRepo(String shopId) async {
  Uri url = Uri.parse(AppConfig.KApiUrl + 'shops/$shopId/products');
  print('[API CALL TO : getProductRepo] ===>>$url');
  var response = await http.get(url);
  print('[API CALL TO : getProductRepo]');
  print('[RESPONSE CODE : ${response.statusCode}]');
  print('[RESPONSE BODYSAKEt : ${response.body}]');
  if (response.statusCode == 200) {
    List<ProductModel> products = [];
    for (Map product in json.decode(response.body)['data']['products']) {
      products.add(
        ProductModel.fromJson(product),
      );
    }
    return products;
  }

  return null;
}


Future<List<ProductModel>> searchProductRepo(
    String shopId, String search) async {
  Uri url =
      Uri.parse(AppConfig.KApiUrl + 'search/$shopId/shops/$search/products');
  var response = await http.get(url);
  print('[API CALL TO : searchProductRepo]');
  print('[RESPONSE CODE : ${response.statusCode}]');
  print('[RESPONSE BODY : ${response.body}]');

  if (response.statusCode == 200) {
    List<ProductModel> products = [];
    for (Map data in json.decode(response.body)['data']) {
      products.add(
        ProductModel.fromJson(data),
      );
    }
    return products;
  }
  return [];
}

Future<List<ProductModel>?> getMarketCategoryProductRepo(
    String shopId, String catId) async {
  print(catId);
  print(shopId);
  Uri url = Uri.parse(AppConfig.KBaseUrl +
      '/api/getshopallcatgoryproducts?shop_id=$shopId&category_id=$catId');
  print(url);
  var response = await http.get(url);
  print('[API CALL TO : getMarketCategoryProductRepo]');
  print('[RESPONSE CODE : ${response.statusCode}]');
  print('[RESPONSE BODY : ${response.body}]');
  if (response.statusCode == 200) {
    List<ProductModel> list = [];
    for (Map product in json.decode(response.body)['data']) {
      list.add(
        ProductModel.fromJson(product),
      );
    }
    return list;
  }
  return null;
}
