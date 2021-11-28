class Shop {
  int? id;
  int? userId;
  int? locationId;
  int? areaId;
  String? name;
  String? description;
  int? deliveryCharge;
  String? lat;
  String? long;
  String? openingTime;
  String? closingTime;
  String? address;
  int? status;
  int? currentStatus;
  String? creatorType;
  int? creatorId;
  String? editorType;
  int? editorId;
  String? createdAt;
  String? updatedAt;
  int? applied;
  String? slug;

  Shop({
      this.id, 
      this.userId, 
      this.locationId, 
      this.areaId, 
      this.name, 
      this.description, 
      this.deliveryCharge, 
      this.lat, 
      this.long, 
      this.openingTime, 
      this.closingTime, 
      this.address, 
      this.status, 
      this.currentStatus, 
      this.creatorType, 
      this.creatorId, 
      this.editorType, 
      this.editorId, 
      this.createdAt, 
      this.updatedAt, 
      this.applied, 
      this.slug});

  Shop.fromJson(dynamic json) {
    id = json["id"];
    userId = json["user_id"];
    locationId = json["location_id"];
    areaId = json["area_id"];
    name = json["name"];
    description = json["description"];
    deliveryCharge = json["delivery_charge"];
    lat = json["lat"];
    long = json["long"];
    openingTime = json["opening_time"];
    closingTime = json["closing_time"];
    address = json["address"];
    status = json["status"];
    currentStatus = json["current_status"];
    creatorType = json["creator_type"];
    creatorId = json["creator_id"];
    editorType = json["editor_type"];
    editorId = json["editor_id"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    applied = json["applied"];
    slug = json["slug"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["user_id"] = userId;
    map["location_id"] = locationId;
    map["area_id"] = areaId;
    map["name"] = name;
    map["description"] = description;
    map["delivery_charge"] = deliveryCharge;
    map["lat"] = lat;
    map["long"] = long;
    map["opening_time"] = openingTime;
    map["closing_time"] = closingTime;
    map["address"] = address;
    map["status"] = status;
    map["current_status"] = currentStatus;
    map["creator_type"] = creatorType;
    map["creator_id"] = creatorId;
    map["editor_type"] = editorType;
    map["editor_id"] = editorId;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["applied"] = applied;
    map["slug"] = slug;
    return map;
  }

}