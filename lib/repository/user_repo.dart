import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:quikk_customer/helper/config.dart';
import 'package:quikk_customer/models/account_refer_model.dart';
import 'package:quikk_customer/models/register_response_model.dart';
import 'package:quikk_customer/models/user_model.dart';

Future<RegisterResponseModel?> registrationRepo(UserModel user) async {
  // List res=[];
// UserModel? userRes = UserModel();
//   Uri url = Uri.parse(AppConfig.KApiUrl + 'reg');
//   await http.post(
//     url,
//     body: {
//       'email': user.email,
//       'name': user.username,
//       'phone': user.phone,
//       'password': user.password,
//       'password_confirmation': user.confirmPassword,
//       'role': '2',
//       'address': user.address
//     },
//   ).then((response) {
//     print('[API CALL TO : registrationRepo]');
//     print('[RESPONSE CODE : ${response.statusCode}]');
//     print('[RESPONSE BODY : ${response.body}]');
//     if (response.statusCode == 200) {
//       // res[0] = json.decode(response.body)['data'];
//       // res[1] = json.decode(response.body)['token'];
//       userRes = json.decode(response.body)['data'];
//       return;
//     }
//   }).onError((error, stackTrace) {
//     print(error.toString());
//     Fluttertoast.showToast(
//       msg: Constant.KOnErrorText + error.toString(),
//       toastLength: Toast.LENGTH_LONG,
//     );
//     // res = [];
//     userRes = null;
//     return;
//   }).timeout(Duration(seconds: 10), onTimeout: () {
//     Fluttertoast.showToast(
//       msg: Constant.KOnTimeOutText,
//       toastLength: Toast.LENGTH_LONG,
//     );
//     // res = [];
//     userRes = null;
//     return;
//   });
//   return userRes;
  Uri url = Uri.parse(AppConfig.KApiUrl + 'reg');
  var response = await http.post(
    url,
    body: {
      'email': user.email,
      'name': user.username,
      'phone': user.phone,
      'password': user.password,
      'password_confirmation': user.confirmPassword,
      'role': '2',
      'address': user.address,
      'referer_id': user.referCode
    },
  );
  print('[API CALL TO : registrationRepo]');
  print('[RESPONSE CODE : ${response.statusCode}]');
  print('[RESPONSE BODY : ${response.body}]');
  if (response.statusCode == 200) {
    // List<dynamic> lol = [];
    // lol[0] = UserModel.fromJson(json.decode(response.body)['data']);
    // lol[1] = json.decode(response.body)['token'];
    // return lol;
    return RegisterResponseModel.fromJson(json.decode(response.body));
  }
  print('[RESPONSE BODY : ${json.decode(response.body)['message']}]');
  Fluttertoast.showToast(msg: json.decode(response.body)['message'].toString());
  return null;
}

Future<RegisterResponseModel?> loginRepo(UserModel user) async {
  print(user.email);
  print(user.password);
  Uri url = Uri.parse(AppConfig.KApiUrl + 'login');
  var response = await http.post(url, body: {
    'email': user.email,
    'password': user.password,
    'role': '2',
  });
  print('[API CALL TO : loginRepo]');
  print('[RESPONSE CODE : ${response.statusCode}]');
  print('[RESPONSE BODY : ${response.body}]');
  if (response.statusCode == 200) {
    return RegisterResponseModel.fromJson(json.decode(response.body));
  }
  Fluttertoast.showToast(
    msg: json.decode(response.body)['message'].toString(),
    toastLength: Toast.LENGTH_LONG,
  );
  return null;
}

Future<RegisterResponseModel?> checkIfLoginRepo(
    {String? phone, String? email}) async {
  Uri url = Uri.parse(AppConfig.KApiUrl + 'loginCustomer');
  if (phone != null) {
    var response = await http.post(url, body: {
      'phone': phone,
      'role': '2',
    });
    print('ffffffffffffffff');
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200 &&
        json.decode(response.body)['status'] == 200) {
      return RegisterResponseModel.fromJson(json.decode(response.body));
    }
    return null;
  }
  if (email != null) {
    var response = await http.post(url, body: {
      'email': email,
      'role': '2',
    });
    if (response.statusCode == 200 &&
        json.decode(response.body)['status'] == 200) {
      return RegisterResponseModel.fromJson(json.decode(response.body));
    }
    return null;
  }
}

Future<bool> setDeviceTokenRepo(String? token, String? fcmToken) async {
  print(fcmToken);
  Uri url = Uri.parse(AppConfig.KBaseUrl + '/api/update-device-token');
  var response = await http.post(
    url,
    body: {
      'device_token': fcmToken,
    },
    headers: {'Authorization': 'Bearer $token'},
  );
  print('[API CALL TO : setDeviceTokenRepo]');
  print('[RESPONSE CODE : ${response.statusCode}]');
  print('[RESPONSE BODY : ${response.body}]');
  if (response.statusCode == 200 && json.decode(response.body)['success']) {
    return true;
  }
  return false;
}

Future<void> addUserLocationToDbRepo({
  required String token,
  required String lat,
  required String lng,
}) async {
  print(' i ma in af;mkaldfndsnsdfjnsgd');
  Uri url = Uri.parse(AppConfig.KBaseUrl + '/api/get-user-location');
  var response = await http.post(
    url,
    body: {
      'type': '0',
      'lat': lat,
      'lng': lng,
    },
    headers: {'Authorization': 'Bearer $token'},
  );
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    print('success');
  } else {
    print('fails');
  }
}

Future<AccountReferModel?> getReferDetailsRepo(String token) async {
  Uri url = Uri.parse('${AppConfig.KBaseUrl}/api/getquikkusermoney');
  var response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
    },
  );
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    return AccountReferModel.fromJson(
      json.decode(response.body),
    );
  }
  return null;
}
