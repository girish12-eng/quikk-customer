import 'items.dart';

class OrderModel {
  int? id;
  int? userId;
  String? total;
  String? subTotal;
  String? deliveryCharge;
  String? tax;
  String? packagingCharges;
  int? status;
  int? otp;
  String? platform;
  String? deviceId;
  String? ip;
  int? paymentStatus;
  String? paymentStatusName;
  String? paidAmount;
  String? address;
  String? discount;
  String? burnCoinAmount;
  String? mobile;
  String? lat;
  String? long;
  String? misc;
  int? paymentMethod;
  String? createdAt;
  String? updatedAt;
  String? invoiceId;
  String? shopId;
  String? deliveryBoyId;
  String? deliveryBoyName;
  String? deliveryBoyTemp;
  String? deliveryBoyTempDate;
  String? deliveryBoyContact;
  String? deliveryBoyIsVaccinated;
  String? rating;
  int? productReceived;
  String? statusName;
  String? createdAtConvert;
  String? updatedAtConvert;
  List<Items>? items;

  OrderModel(
      {this.id,
      this.userId,
      this.total,
      this.subTotal,
      this.tax,
      this.packagingCharges,
      this.deliveryCharge,
      this.status,
      this.otp,
      this.platform,
      this.deviceId,
      this.ip,
      this.paymentStatus,
      this.paymentStatusName,
      this.paidAmount,
      this.address,
      this.discount,
      this.burnCoinAmount,
      this.mobile,
      this.lat,
      this.long,
      this.misc,
      this.paymentMethod,
      this.createdAt,
      this.updatedAt,
      this.invoiceId,
      this.shopId,
      this.deliveryBoyId,
      this.deliveryBoyName,
      this.deliveryBoyTemp,
      this.deliveryBoyTempDate,
      this.deliveryBoyContact,
      this.deliveryBoyIsVaccinated,
      this.rating,
      this.productReceived,
      this.statusName,
      this.createdAtConvert,
      this.updatedAtConvert,
      this.items});

  OrderModel.fromJson(dynamic json) {
    id = json["id"];
    userId = json["user_id"];
    total = json["total"];
    subTotal = json["sub_total"];
    tax = json["tax"];
    packagingCharges = json["packaging_charges"];
    deliveryCharge = json["delivery_charge"];
    status = json["status"];
    otp = json["otp"];
    platform = json["platform"];
    deviceId = json["device_id"];
    ip = json["ip"];
    paymentStatus = json["payment_status"];
    paymentStatusName = json["payment_status_name"];
    paidAmount = json["paid_amount"];
    address = json["address"];
    discount = json["discount"].toString();
    burnCoinAmount = json["burncoinamount"].toString();
    mobile = json["mobile"];
    lat = json["lat"];
    long = json["long"];
    misc = json["misc"];
    paymentMethod = json["payment_method"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    invoiceId = json["invoice_id"];
    shopId = json["shop_id"];
    deliveryBoyId = json["delivery_boy_id"].toString();
    deliveryBoyName = json["delivery_boy_name"].toString();
    deliveryBoyTemp = json["delivery_boy_temp"].toString();
    deliveryBoyTempDate = json["delivery_boy_temp_date"].toString();
    deliveryBoyContact = json["delivery_boy_contact"].toString();
    deliveryBoyIsVaccinated = json["delivery_boy_is_vaccinated"].toString();
    rating = json["rating"].toString();
    productReceived = json["product_received"];
    statusName = json["status_name"];
    createdAtConvert = json["created_at_convert"];
    updatedAtConvert = json["updated_at_convert"];
    if (json["items"] != null) {
      items = [];
      json["items"].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["user_id"] = userId;
    map["total"] = total;
    map["sub_total"] = subTotal;
    map["delivery_charge"] = deliveryCharge;
    map["status"] = status;
    map["platform"] = platform;
    map["device_id"] = deviceId;
    map["ip"] = ip;
    map["payment_status"] = paymentStatus;
    map["paid_amount"] = paidAmount;
    map["address"] = address;
    map["mobile"] = mobile;
    map["lat"] = lat;
    map["long"] = long;
    map["misc"] = misc;
    map["payment_method"] = paymentMethod;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["invoice_id"] = invoiceId;
    map["shop_id"] = shopId;
    map["delivery_boy_id"] = deliveryBoyId;
    map["product_received"] = productReceived;
    map["status_name"] = statusName;
    map["created_at_convert"] = createdAtConvert;
    map["updated_at_convert"] = updatedAtConvert;
    if (items != null) {
      map["items"] = items?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
