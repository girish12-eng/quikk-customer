/// status : 200
/// data : {"id":35,"name":"Quikk Store","market_type":3,"image":"https://quikkdelivery.com/storage/3472/app-icon-1.png","products":[{"id":348,"name":"Test","unit_price":"100.00","description":"","discount_price":"20.00","image":"https://quikkdelivery.com/storage/313/60d6f23e881af_test.jpg","recommend":0,"sorting":null,"avgRating":0,"type":0,"variationss":[{"id":8,"shop_product_id":13689,"product_id":348,"shop_id":35,"name":"Variation 3","price":"200.00","quantity":12,"discount_price":"100.00"},{"id":9,"shop_product_id":13689,"product_id":348,"shop_id":35,"name":"Variation 2","price":"150.00","quantity":12,"discount_price":"50.00"},{"id":10,"shop_product_id":13689,"product_id":348,"shop_id":35,"name":"Variation 1","price":"100.00","quantity":12,"discount_price":"20.00"}],"quantity":" 1 Kg","stock_count":36,"in_stock":true}]}

class ProductList {
  ProductList({
      int? status, 
      Data? data,}){
    _status = status;
    _data = data;
}

  ProductList.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? _status;
  Data? _data;

  int? get status => _status;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : 35
/// name : "Quikk Store"
/// market_type : 3
/// image : "https://quikkdelivery.com/storage/3472/app-icon-1.png"
/// products : [{"id":348,"name":"Test","unit_price":"100.00","description":"","discount_price":"20.00","image":"https://quikkdelivery.com/storage/313/60d6f23e881af_test.jpg","recommend":0,"sorting":null,"avgRating":0,"type":0,"variationss":[{"id":8,"shop_product_id":13689,"product_id":348,"shop_id":35,"name":"Variation 3","price":"200.00","quantity":12,"discount_price":"100.00"},{"id":9,"shop_product_id":13689,"product_id":348,"shop_id":35,"name":"Variation 2","price":"150.00","quantity":12,"discount_price":"50.00"},{"id":10,"shop_product_id":13689,"product_id":348,"shop_id":35,"name":"Variation 1","price":"100.00","quantity":12,"discount_price":"20.00"}],"quantity":" 1 Kg","stock_count":36,"in_stock":true}]

class Data {
  Data({
      int? id, 
      String? name, 
      int? marketType, 
      String? image, 
      List<Products>? products,}){
    _id = id;
    _name = name;
    _marketType = marketType;
    _image = image;
    _products = products;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _marketType = json['market_type'];
    _image = json['image'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(Products.fromJson(v));
      });
    }
  }
  int? _id;
  String? _name;
  int? _marketType;
  String? _image;
  List<Products>? _products;

  int? get id => _id;
  String? get name => _name;
  int? get marketType => _marketType;
  String? get image => _image;
  List<Products>? get products => _products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['market_type'] = _marketType;
    map['image'] = _image;
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 348
/// name : "Test"
/// unit_price : "100.00"
/// description : ""
/// discount_price : "20.00"
/// image : "https://quikkdelivery.com/storage/313/60d6f23e881af_test.jpg"
/// recommend : 0
/// sorting : null
/// avgRating : 0
/// type : 0
/// variationss : [{"id":8,"shop_product_id":13689,"product_id":348,"shop_id":35,"name":"Variation 3","price":"200.00","quantity":12,"discount_price":"100.00"},{"id":9,"shop_product_id":13689,"product_id":348,"shop_id":35,"name":"Variation 2","price":"150.00","quantity":12,"discount_price":"50.00"},{"id":10,"shop_product_id":13689,"product_id":348,"shop_id":35,"name":"Variation 1","price":"100.00","quantity":12,"discount_price":"20.00"}]
/// quantity : " 1 Kg"
/// stock_count : 36
/// in_stock : true

class Products {
  Products({
      int? id, 
      String? name, 
      String? unitPrice, 
      String? description, 
      String? discountPrice, 
      String? image, 
      int? recommend, 
      dynamic sorting, 
      int? avgRating, 
      int? type, 
      List<Variationss>? variationss, 
      String? quantity, 
      int? stockCount, 
      bool? inStock,}){
    _id = id;
    _name = name;
    _unitPrice = unitPrice;
    _description = description;
    _discountPrice = discountPrice;
    _image = image;
    _recommend = recommend;
    _sorting = sorting;
    _avgRating = avgRating;
    _type = type;
    _variationss = variationss;
    _quantity = quantity;
    _stockCount = stockCount;
    _inStock = inStock;
}

  Products.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _unitPrice = json['unit_price'];
    _description = json['description'];
    _discountPrice = json['discount_price'];
    _image = json['image'];
    _recommend = json['recommend'];
    _sorting = json['sorting'];
    _avgRating = json['avgRating'];
    _type = json['type'];
    if (json['variationss'] != null) {
      _variationss = [];
      json['variationss'].forEach((v) {
        _variationss?.add(Variationss.fromJson(v));
      });
    }
    _quantity = json['quantity'];
    _stockCount = json['stock_count'];
    _inStock = json['in_stock'];
  }
  int? _id;
  String? _name;
  String? _unitPrice;
  String? _description;
  String? _discountPrice;
  String? _image;
  int? _recommend;
  dynamic _sorting;
  int? _avgRating;
  int? _type;
  List<Variationss>? _variationss;
  String? _quantity;
  int? _stockCount;
  bool? _inStock;

  int? get id => _id;
  String? get name => _name;
  String? get unitPrice => _unitPrice;
  String? get description => _description;
  String? get discountPrice => _discountPrice;
  String? get image => _image;
  int? get recommend => _recommend;
  dynamic get sorting => _sorting;
  int? get avgRating => _avgRating;
  int? get type => _type;
  List<Variationss>? get variationss => _variationss;
  String? get quantity => _quantity;
  int? get stockCount => _stockCount;
  bool? get inStock => _inStock;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['unit_price'] = _unitPrice;
    map['description'] = _description;
    map['discount_price'] = _discountPrice;
    map['image'] = _image;
    map['recommend'] = _recommend;
    map['sorting'] = _sorting;
    map['avgRating'] = _avgRating;
    map['type'] = _type;
    if (_variationss != null) {
      map['variationss'] = _variationss?.map((v) => v.toJson()).toList();
    }
    map['quantity'] = _quantity;
    map['stock_count'] = _stockCount;
    map['in_stock'] = _inStock;
    return map;
  }

}

/// id : 8
/// shop_product_id : 13689
/// product_id : 348
/// shop_id : 35
/// name : "Variation 3"
/// price : "200.00"
/// quantity : 12
/// discount_price : "100.00"

class Variationss {
  Variationss({
      int? id, 
      int? shopProductId, 
      int? productId, 
      int? shopId, 
      String? name, 
      String? price, 
      int? quantity, 
      String? discountPrice,}){
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