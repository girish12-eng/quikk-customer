class AddressModel {
  int? id;
  int? userId;
  String? type;
  String? location;
  String? completeAddress;
  String? lat;
  String? lng;
  String? createdAt;
  String? updatedAt;
  String? floor;
  String? howToReach;

  AddressModel(
      {this.id,
      this.userId,
      this.type,
      this.location,
      this.completeAddress,
      this.lat,
      this.lng,
      this.createdAt,
      this.updatedAt,
      this.floor,
      this.howToReach});

  AddressModel.fromJson(dynamic json) {
    id = json["id"];
    userId = json["user_id"];
    type = json["type"];
    location = json["location"];
    completeAddress = json["complete_address"];
    lat = json["lat"];
    lng = json["lng"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    floor = json["floor"];
    howToReach = json["how_to_reach"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["user_id"] = userId;
    map["type"] = type;
    map["location"] = location;
    map["complete_address"] = completeAddress;
    map["lat"] = lat;
    map["lng"] = lng;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["floor"] = floor;
    map["how_to_reach"] = howToReach;
    return map;
  }
}
