class UserModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? username;
  String? password;
  String? confirmPassword;
  String? image;
  String? address;
  int? status;
  int? applied;
  String? myrole;
  String? mystatus;
  String? referCode;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.username,
    this.image,
    this.address,
    this.status,
    this.applied,
    this.myrole,
    this.mystatus,
    this.referCode,
  });

  UserModel.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    username = json["username"];
    image = json["image"];
    address = json["address"];
    status = json["status"];
    applied = json["applied"];
    myrole = json["myrole"];
    mystatus = json["mystatus"];
    referCode = json["referer_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["email"] = email;
    map["phone"] = phone;
    map["username"] = username;
    map["image"] = image;
    map["address"] = address;
    map["status"] = status;
    map["applied"] = applied;
    map["myrole"] = myrole;
    map["mystatus"] = mystatus;
    map["referer_id"] = referCode;
    return map;
  }
}
