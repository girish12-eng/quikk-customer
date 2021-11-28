import 'product.dart';
import 'shop.dart';

class Items {
  int? id;
  int? orderId;
  int? shopId;
  int? productId;
  int? quantity;
  String? unitPrice;
  String? discountedPrice;
  String? itemTotal;
  String? createdAt;
  String? updatedAt;
  int? shopProductVariationId;
  String? options;
  int? optionsTotal;
  String? createdAtConvert;
  String? updatedAtConvert;
  Product? product;
  Shop? shop;

  Items({
      this.id, 
      this.orderId, 
      this.shopId, 
      this.productId, 
      this.quantity, 
      this.unitPrice, 
      this.discountedPrice, 
      this.itemTotal, 
      this.createdAt, 
      this.updatedAt, 
      this.shopProductVariationId, 
      this.options, 
      this.optionsTotal, 
      this.createdAtConvert, 
      this.updatedAtConvert, 
      this.product, 
      this.shop});

  Items.fromJson(dynamic json) {
    id = json["id"];
    orderId = json["order_id"];
    shopId = json["shop_id"];
    productId = json["product_id"];
    quantity = json["quantity"];
    unitPrice = json["unit_price"];
    discountedPrice = json["discounted_price"];
    itemTotal = json["item_total"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    shopProductVariationId = json["shop_product_variation_id"];
    options = json["options"];
    optionsTotal = json["options_total"];
    createdAtConvert = json["created_at_convert"];
    updatedAtConvert = json["updated_at_convert"];
    product = json["product"] != null ? Product.fromJson(json["product"]) : null;
    shop = json["shop"] != null ? Shop.fromJson(json["shop"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["order_id"] = orderId;
    map["shop_id"] = shopId;
    map["product_id"] = productId;
    map["quantity"] = quantity;
    map["unit_price"] = unitPrice;
    map["discounted_price"] = discountedPrice;
    map["item_total"] = itemTotal;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["shop_product_variation_id"] = shopProductVariationId;
    map["options"] = options;
    map["options_total"] = optionsTotal;
    map["created_at_convert"] = createdAtConvert;
    map["updated_at_convert"] = updatedAtConvert;
    if (product != null) {
      map["product"] = product?.toJson();
    }
    if (shop != null) {
      map["shop"] = shop?.toJson();
    }
    return map;
  }

}