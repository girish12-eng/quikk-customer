class ItemProduct {
  String? shopId;
  int? productId;
  double? discountedPrice;
  double? unitPrice;
  int? quantity;
  String? shopProductVariationId;
  double? tax;
  double? packagingCharges;
  List? options = [];

  ItemProduct({
    this.shopId,
    this.productId,
    this.unitPrice,
    this.quantity,
    this.discountedPrice,
    this.shopProductVariationId,
    this.tax,
    this.packagingCharges,
    this.options,
  });

  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["shop_id"] = shopId;
    map["shop_product_variation_id"] = shopProductVariationId;
    map["product_id"] = productId;
    map["unit_price"] = unitPrice;
    map["quantity"] = quantity;
    map["discounted_price"] = discountedPrice;
    map["tax"] = tax;
    map['packaging_charges'] = packagingCharges;
    map["options"] = options;
    return map;
  }
}
