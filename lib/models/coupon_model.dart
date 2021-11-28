class CouponModel {
  int? id;
  String? code;
  int? discount;
  String? discountType;
  String? description;
  int? shopId;
  int? minOrder;
  String? expiresAt;
  int? enabled;
  String? maxDiscount;
  String? createdAt;
  String? updatedAt;
  String? color;
  String? by;
  dynamic? image;

  CouponModel(
      {this.id,
      this.code,
      this.discount,
      this.discountType,
      this.description,
      this.shopId,
      this.minOrder,
      this.expiresAt,
      this.enabled,
      this.maxDiscount,
      this.createdAt,
      this.updatedAt,
      this.color,
      this.by,
      this.image});

  CouponModel.fromJson(dynamic json) {
    id = json["id"];
    code = json["code"];
    discount = json["discount"];
    discountType = json["discount_type"];
    description = json["description"];
    shopId = json["shop_id"];
    minOrder = json["min_order"];
    expiresAt = json["expires_at"];
    enabled = json["enabled"];
    maxDiscount = json["max_discount"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    color = json["color"];
    by = json["by"];
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["code"] = code;
    map["discount"] = discount;
    map["discount_type"] = discountType;
    map["description"] = description;
    map["shop_id"] = shopId;
    map["min_order"] = minOrder;
    map["expires_at"] = expiresAt;
    map["enabled"] = enabled;
    map["max_discount"] = maxDiscount;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["color"] = color;
    map["image"] = image;
    return map;
  }
}
