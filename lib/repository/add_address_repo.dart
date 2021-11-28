import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quikk_customer/helper/config.dart';
import 'package:quikk_customer/models/addressmodel.dart';

Future<bool> addAddressRepo({
  required String token,
  required String completeAddress,
  required String type,
  required String location,
  String? floor,
  String? howToReach,
  required String lat,
  required String lng,
}) async {
  // String token = Provider
  //     .of<AuthProvider>(context, listen: false)
  //     .token;
  // print(token);
  var url = Uri.parse(AppConfig.KApiUrl + 'add-address');
  print(url);
  var res = await http.post(url, body: {
    'type': type,
    'complete_address': completeAddress,
    'location': location,
    'floor': floor ?? '',
    'how_to_reach': howToReach ?? '',
    'lat': lat,
    'lng': lng,
  }, headers: {
    'Authorization': 'Bearer $token',
  });
  print(res.statusCode);
  print(res.body);
  if (res.statusCode == 200 && json.decode(res.body)['success'] == true) {
    return true;
  } else {
    return false;
  }
}

Future<List<AddressModel>> getAddressRepo(String token) async {
  Uri url = Uri.parse(AppConfig.KApiUrl + 'get-address');
  var response = await http.post(url, headers: {
    'Authorization': 'Bearer $token',
  });
  if (response.statusCode == 200) {
    List<AddressModel> addresses = [];
    for (Map data in json.decode(response.body)['data']) {
      addresses.add(AddressModel.fromJson(data));
    }
    return addresses;
  }
  return [];
}

Future<bool> deleteAddressRepo(String token, String id) async {
  Uri url = Uri.parse(AppConfig.KApiUrl + 'delete-address');
  var response = await http.post(url, body: {
    'id': id,
  }, headers: {
    'Authorization': 'Bearer $token',
  });
  if (response.statusCode == 200 &&
      json.decode(response.body)['success'] == true) {
    return true;
  }
  return false;
}
