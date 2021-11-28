import 'data.dart';

class RegisterResponseModel {
  String? status;
  String? message;
  Data? data;
  String? token;

  RegisterResponseModel({
      this.status, 
      this.message, 
      this.data, 
      this.token});

  RegisterResponseModel.fromJson(dynamic json) {
    status = json["status"].toString();
    message = json["message"];
    data = json["data"] != null ? Data.fromJson(json["data"]) : null;
    token = json["token"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = status;
    map["message"] = message;
    if (data != null) {
      map["data"] = data?.toJson();
    }
    map["token"] = token;
    return map;
  }

}