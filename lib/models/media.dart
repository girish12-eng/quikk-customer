class Media {
  int? id;
  String? modelType;
  int? modelId;
  String? collectionName;
  String? name;
  String? fileName;
  String? mimeType;
  String? disk;
  int? size;
  // List<dynamic>? manipulations;
  // List<dynamic>? customProperties;
  // List<dynamic>? responsiveImages;
  int? orderColumn;
  String? createdAt;
  String? updatedAt;

  Media({
      this.id, 
      this.modelType, 
      this.modelId, 
      this.collectionName, 
      this.name, 
      this.fileName, 
      this.mimeType, 
      this.disk, 
      this.size, 
      // this.manipulations,
      // this.customProperties,
      // this.responsiveImages,
      this.orderColumn, 
      this.createdAt, 
      this.updatedAt});

  Media.fromJson(dynamic json) {
    id = json["id"];
    modelType = json["model_type"];
    modelId = json["model_id"];
    collectionName = json["collection_name"];
    name = json["name"];
    fileName = json["file_name"];
    mimeType = json["mime_type"];
    disk = json["disk"];
    size = json["size"];
    // if (json["manipulations"] != null) {
    //   manipulations = [];
    //   json["manipulations"].forEach((v) {
    //     manipulations?.add(dynamic.fromJson(v));
    //   });
    // }
    // if (json["custom_properties"] != null) {
    //   customProperties = [];
    //   json["custom_properties"].forEach((v) {
    //     customProperties?.add(dynamic.fromJson(v));
    //   });
    // }
    // if (json["responsive_images"] != null) {
    //   responsiveImages = [];
    //   json["responsive_images"].forEach((v) {
    //     responsiveImages?.add(dynamic.fromJson(v));
    //   });
    // }
    orderColumn = json["order_column"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["model_type"] = modelType;
    map["model_id"] = modelId;
    map["collection_name"] = collectionName;
    map["name"] = name;
    map["file_name"] = fileName;
    map["mime_type"] = mimeType;
    map["disk"] = disk;
    map["size"] = size;
    // if (manipulations != null) {
    //   map["manipulations"] = manipulations?.map((v) => v.toJson()).toList();
    // }
    // if (customProperties != null) {
    //   map["custom_properties"] = customProperties?.map((v) => v.toJson()).toList();
    // }
    // if (responsiveImages != null) {
    //   map["responsive_images"] = responsiveImages?.map((v) => v.toJson()).toList();
    // }
    map["order_column"] = orderColumn;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    return map;
  }

}