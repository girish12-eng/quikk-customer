class BannerModel {
  int? id;
  String? title;
  String? link;
  int? sort;
  String? image;

  BannerModel({
      this.id, 
      this.title, 
      this.link, 
      this.sort, 
      this.image});

  BannerModel.fromJson(dynamic json) {
    id = json["id"];
    title = json["title"];
    link = json["link"];
    sort = json["sort"];
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["title"] = title;
    map["link"] = link;
    map["sort"] = sort;
    map["image"] = image;
    return map;
  }

}