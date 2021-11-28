class MarketModel {
  int? id;
  String? name;
  int? userId;
  int? locationId;
  int? areaId;
  int? marketType;
  String? description;
  int? deliveryCharge;
  String? fssai;
  String? packageCharge;
  String? lat;
  String? long;
  String? rating;
  String? openingTime;
  String? closingTime;
  String? address;
  String? status;
  String? currentStatus;
  int? applied;
  String? createdAt;
  String? updatedAt;
  String? distance;
  String? image;

  MarketModel(
      {this.id,
      this.name,
      this.userId,
      this.locationId,
      this.areaId,
      this.marketType,
      this.description,
      this.deliveryCharge,
      this.fssai,
      this.packageCharge,
      this.lat,
      this.long,
      this.rating,
      this.openingTime,
      this.closingTime,
      this.address,
      this.status,
      this.currentStatus,
      this.applied,
      this.createdAt,
      this.updatedAt,
      this.distance,
      this.image});

  MarketModel.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    userId = json["user_id"];
    locationId = json["location_id"];
    areaId = json["area_id"];
    marketType = json["market_type"];
    description = json["description"];
    deliveryCharge = json["delivery_charge"];
    fssai = json["fssai"];
    packageCharge = json["packagecharge"];
    lat = json["lat"];
    long = json["long"];
    rating = json["rating"];
    openingTime = json["opening_time"];
    closingTime = json["closing_time"];
    address = json["address"];
    status = json["status"];
    currentStatus = json["current_status"];
    applied = json["applied"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    distance = json["distance"];
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["user_id"] = userId;
    map["location_id"] = locationId;
    map["area_id"] = areaId;
    map["description"] = description;
    map["delivery_charge"] = deliveryCharge;
    map["lat"] = lat;
    map["long"] = long;
    map["opening_time"] = openingTime;
    map["closing_time"] = closingTime;
    map["address"] = address;
    map["status"] = status;
    map["current_status"] = currentStatus;
    map["applied"] = applied;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["distance"] = distance;
    map["image"] = image;
    return map;
  }
}
