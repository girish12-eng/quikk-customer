class ProductModel {
  int? id;
  String? name;
  String? unitPrice;
  String? discountPrice;
  String? description;
  String? image;
  double? avgRating;
  int? type;
  int? recommend;
  String? quantity;
  int? stockCount;
  bool? inStock;
  List<Variationss>? variationss;

  ProductModel(
      {this.id,
      this.name,
      this.unitPrice,
      this.description,
      this.discountPrice,
      this.image,
      this.avgRating,
      this.quantity,
      this.type,
      this.recommend,
      this.stockCount,
      this.inStock,
      this.variationss});

  ProductModel.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    unitPrice = json["unit_price"];
    discountPrice = json["discount_price"];
    image = json["image"];
    avgRating = double.parse(json["avgRating"].toString());
    quantity = json["quantity"].toString();
    type = json["type"];
    recommend = json["recommend"];
    stockCount = json["stock_count"];
    inStock = json["in_stock"];
    if (json['variationss'] != null) {
      variationss = [];
      json['variationss'].forEach((v) {
        variationss?.add(Variationss.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["unit_price"] = unitPrice;
    map["discount_price"] = discountPrice;
    map["image"] = image;
    map["avgRating"] = avgRating;
    map["stock_count"] = stockCount;
    map["in_stock"] = inStock;
    return map;
  }
}

class Variationss {
  Variationss({
    int? id,
    int? shopProductId,
    int? productId,
    int? shopId,
    String? name,
    String? price,
    int? quantity,
    String? discountPrice,
  }) {
    _id = id;
    _shopProductId = shopProductId;
    _productId = productId;
    _shopId = shopId;
    _name = name;
    _price = price;
    _quantity = quantity;
    _discountPrice = discountPrice;
  }

  Variationss.fromJson(dynamic json) {
    _id = json['id'];
    _shopProductId = json['shop_product_id'];
    _productId = json['product_id'];
    _shopId = json['shop_id'];
    _name = json['name'];
    _price = json['price'];
    _quantity = json['quantity'];
    _discountPrice = json['discount_price'];
  }

  int? _id;
  int? _shopProductId;
  int? _productId;
  int? _shopId;
  String? _name;
  String? _price;
  int? _quantity;
  String? _discountPrice;

  int? get id => _id;

  int? get shopProductId => _shopProductId;

  int? get productId => _productId;

  int? get shopId => _shopId;

  String? get name => _name;

  String? get price => _price;

  int? get quantity => _quantity;

  String? get discountPrice => _discountPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['shop_product_id'] = _shopProductId;
    map['product_id'] = _productId;
    map['shop_id'] = _shopId;
    map['name'] = _name;
    map['price'] = _price;
    map['quantity'] = _quantity;
    map['discount_price'] = _discountPrice;
    return map;
  }
}
