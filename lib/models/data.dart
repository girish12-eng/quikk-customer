class Data {
  int? id;
  String? email;
  String? username;
  String? phone;
  String? address;
  String? name;
  String? balance;
  int? status;
  int? applied;
  String? image;
  String? myrole;

  Data({
      this.id, 
      this.email, 
      this.username, 
      this.phone, 
      this.address, 
      this.name, 
      this.balance, 
      this.status, 
      this.applied, 
      this.image, 
      this.myrole});

  Data.fromJson(dynamic json) {
    id = json["id"];
    email = json["email"];
    username = json["username"];
    phone = json["phone"];
    address = json["address"];
    name = json["name"];
    balance = json["balance"];
    status = json["status"];
    applied = json["applied"];
    image = json["image"];
    myrole = json["myrole"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["email"] = email;
    map["username"] = username;
    map["phone"] = phone;
    map["address"] = address;
    map["name"] = name;
    map["balance"] = balance;
    map["status"] = status;
    map["applied"] = applied;
    map["image"] = image;
    map["myrole"] = myrole;
    return map;
  }

}