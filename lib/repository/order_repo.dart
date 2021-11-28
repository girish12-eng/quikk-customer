import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quikk_customer/helper/config.dart';
import 'package:quikk_customer/models/cart_model.dart';
import 'package:quikk_customer/models/item_product.dart';
import 'package:quikk_customer/models/order_model.dart';

Future<String?> getOrderIdRazorPayRepo(String amount) async {
  Uri url = Uri.parse(
      AppConfig.KBaseUrl + '/api/generate-order-id-razorpay?amount=$amount');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    return json.decode(response.body)['data'];
  }
  return null;
}

Future<List<OrderModel>> getOrderHistoryRepo(String token) async {
  Uri url = Uri.parse(AppConfig.KApiUrl + 'orders');
  var response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $token'},
  );
  print('[API CALL TO : getOrderHistoryRepo URL ]' +url.toString());
  print('[API CALL TO : getOrderHistoryRepo ]');
  print('[RESPONSE CODE : ${response.statusCode}]');
  print('[RESPONSE BODY : ${response.body}]');
  if (response.statusCode == 200) {
    List<OrderModel> orders = [];
    for (Map order in json.decode(response.body)['data']) {
      orders.add(OrderModel.fromJson(order));
    }
    return orders;
  }
  return [];
}

Future<List<Map<String, String>>?> submitOrderRepo(
  String token,
  List<CartModel> cart,
  String customerMobileNo,
  String customerAddress,
  String deliveryCharges,
  String customerLat,
  String customerLng,
  String totalAmount,
  String? couponId,
  String? discountAmount,
  double tax,
  double packagingCharge,
  String subtotal,
  String burnCoin,
  String earnCoin,
) async {
  Uri url = Uri.parse(AppConfig.KApiUrl + 'orders');

  List<Map> items = [];

  cart.forEach(
    (element) {
      if(element.variation.name==null){
        items.add(
          ItemProduct(
              shopId: cart[0].shopId.toString(),
              productId: element.product.id,
              unitPrice: double.parse(element.product.unitPrice!),
              discountedPrice: double.parse(element.product.discountPrice!),
              quantity: element.quantity,
              tax: tax,
              packagingCharges: packagingCharge,
              // shop_product_variation_id: element.variation_id,
              options: []).toJson(),
        );
      }else{
        items.add(
          ItemProduct(
              shopId: cart[0].shopId.toString(),
              productId: element.product.id,
              unitPrice: double.parse(element.variation.price!),
              discountedPrice: double.parse(element.variation.discountPrice!),
              quantity: element.quantity,
              tax: tax,
              packagingCharges: packagingCharge,
              shopProductVariationId: element.variation.id.toString(),
              options: []).toJson(),
        );
      }

    }
  );
  print('ssssssssss');

  print(items);
  print(deliveryCharges);
  print(customerLng);
  print(customerAddress);
  print(cart);
  print(totalAmount);
  var body = {
    "items": json.encode(items),
    "mobile": customerMobileNo,
    "address": customerAddress,
    "delivery_charge": deliveryCharges,
    "lat": customerLat,
    "long": customerLng,
    "remarks": 'remarks',
    'sub_total': subtotal,
    "total": totalAmount,
    "coupon_id": couponId,
    "discount": discountAmount,
    'tax': tax.toString(),
    'packaging_charges': packagingCharge.toString(),
    "shop_id": cart[0].shopId.toString(),
    "burn_coin": burnCoin,
    "earn_coin": earnCoin,
    // "image": base64Image != null ? base64Image : '',
    // "fileName": fileName != null ? fileName : '',
  };

  var response = await http.post(
    url,
    headers: {'Authorization': 'Bearer $token'},
    body: body,
  );
  print('[API CALL TO : submitOrderRepo]');
  print('[RESPONSE CODE : ${response.statusCode}]');
  print('[RESPONSE BODY : ${response.body}]');
  if (response.statusCode == 200) {
    print('order success');
    List<Map<String, String>> res = [];
    res.add(
        {'orderId': json.decode(response.body)['data']['order_id'].toString()});
    res.add({
      'total_amount': json.decode(response.body)['data']['order_id'].toString()
    });
    return res;
  }
  return null;
}

Future<bool> handlePaymentSuccessRepo(
  String token,
  String orderId,
  String amount,
  String paymentId,
) async {
  Uri url = Uri.parse(AppConfig.KApiUrl + 'orders/payment');
  Map<String, String> body = {
    'order_id': orderId,
    'amount': amount,
    'payment_method': '20',
    'payment_transaction_id': paymentId,
  };
  var response = await http.post(
    url,
    headers: {'Authorization': 'Bearer $token'},
    body: body,
  );
  print('[API CALL TO : handlePaymentSuccessRepo]');
  print('[RESPONSE CODE : ${response.statusCode}]');
  print('[RESPONSE BODY : ${response.body}]');
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}

Future<List> coinEligibilityRepo(String shopId, String subTotal) async {
  Uri url = Uri.parse(AppConfig.KBaseUrl +
      '/api/checkshopquikkmoney?shop_id=$shopId&sub_total=$subTotal');
  var response = await http.get(url);
  print('[API CALL TO : coinEligibilityRepo]');
  print('[RESPONSE CODE : ${response.statusCode}]');
  print('[RESPONSE BODY : ${response.body}]');
  if (response.statusCode == 200) {
    return [
      json.decode(response.body)['min_order'],
      json.decode(response.body)['shopmore'],
    ];
  }
  return [];
}

Future<List> coinApplyRepo(String token, String shopId, String subTotal) async {
  print('i coinapply called $shopId');
  print('$token');
  Uri url = Uri.parse(AppConfig.KBaseUrl +
      '/api/applyquikkmoney?shop_id=$shopId&sub_total=$subTotal');
  var response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $token'},
  );
  print('[API CALL TO : coinApplyRepo]');
  print('[RESPONSE CODE : ${response.statusCode}]');
  print('[RESPONSE BODY : ${response.body}]');
  if (response.statusCode == 200) {
    return [
      json.decode(response.body)['earncoins'],
      json.decode(response.body)['burncoins'],
      json.decode(response.body)['burnamount'],
    ];
  }
  return [];
}

Future<bool> setRatingOrderRepo(String orderId, String rating) async {
  Uri url = Uri.parse(AppConfig.KBaseUrl + '/api/update-order-rating');
  var response = await http.post(
    url,
    body: {
      'order_id': orderId,
      'rating': rating,
    },
  );
  print('[API CALL TO : setRatingOrderRepo]');
  print('[RESPONSE CODE : ${response.statusCode}]');
  print('[RESPONSE BODY : ${response.body}]');
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}
