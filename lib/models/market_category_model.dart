class MarketCategoryModel {
  String? name;
  int? categoryId;

  MarketCategoryModel({
      this.name, 
      this.categoryId});

  MarketCategoryModel.fromJson(dynamic json) {
    name = json["name"];
    categoryId = json["category_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["category_id"] = categoryId;
    return map;
  }

}