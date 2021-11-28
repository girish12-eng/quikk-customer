import 'media.dart';

class Product {
  int? id;
  String? name;
  String? slug;
  String? description;
  String? unitPrice;
  String? tags;
  int? order;
  int? status;
  int? requested;
  String? creatorType;
  String? qty;
  int? creatorId;
  String? editorType;
  int? editorId;
  String? createdAt;
  String? updatedAt;
  String? image;
  List<Media>? media;

  Product(
      {this.id,
      this.name,
      this.slug,
      this.description,
      this.unitPrice,
      this.tags,
      this.order,
      this.status,
      this.requested,
      this.creatorType,
      this.creatorId,
      this.qty,
      this.editorType,
      this.editorId,
      this.createdAt,
      this.updatedAt,
      this.image,
      this.media});

  Product.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    slug = json["slug"];
    description = json["description"];
    unitPrice = json["unit_price"];
    tags = json["tags"];
    order = json["order"];
    status = json["status"];
    requested = json["requested"];
    qty = json["qty"];
    creatorType = json["creator_type"];
    creatorId = json["creator_id"];
    editorType = json["editor_type"];
    editorId = json["editor_id"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    image = json["image"];
    if (json["media"] != null) {
      media = [];
      json["media"].forEach((v) {
        media?.add(Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["slug"] = slug;
    map["description"] = description;
    map["unit_price"] = unitPrice;
    map["tags"] = tags;
    map["order"] = order;
    map["status"] = status;
    map["requested"] = requested;
    map["creator_type"] = creatorType;
    map["creator_id"] = creatorId;
    map["editor_type"] = editorType;
    map["editor_id"] = editorId;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["image"] = image;
    if (media != null) {
      map["media"] = media?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
