import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:quikk_customer/models/register_response_model.dart';
import 'package:quikk_customer/models/user_model.dart';
import 'package:quikk_customer/repository/user_repo.dart';
import 'package:quikk_customer/widgets/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewEnterUserDetailsScreenController extends ChangeNotifier {
  bool loading = false;
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController _nameTED = TextEditingController();
  final TextEditingController _emailTED = TextEditingController();
  final TextEditingController _referCodeTED = TextEditingController();
  late SharedPreferences _preferences;

  String? validateName(String v) {
    if (v.isEmpty) return 'This field is required';
    return null;
  }

  String? validateEmailFields(String v) {
    if (v.isEmpty) return 'This field id required';
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(v)) return 'Please enter valid email';
    return null;
  }

  void onSaveName(String v) {
    _nameTED.text = v;
  }

  void onSaveReferCode(String v) {
    _referCodeTED.text = _referCodeTED.text.isEmpty ? '' : v;
  }

  void onEmailSave(String v) {
    _emailTED.text = v;
  }

  void onContinueButtonPressed(BuildContext context, String phone) async {


    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      UserModel user = UserModel();
      user.username = _nameTED.text;
      user.email = _emailTED.text;
      user.phone = phone;
      user.password = '123456';
      user.confirmPassword = '123456';
      user.address = '';
      user.referCode = _referCodeTED.text;
      RegisterResponseModel? res = await registrationRepo(user);
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      if (res != null) {
        await setDeviceTokenRepo(res.token, fcmToken!);
        _preferences = await SharedPreferences.getInstance();
        _preferences.setString('token', res.token!);
        _preferences.setString('name', res.data!.name!);
        _preferences.setString('email', res.data!.email!);
        _preferences.setString('phone', res.data!.phone!);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BottomNavigationScreen(),
          ),
        );
      }
    }
  }

  TextEditingController get getNameTED {
    return _nameTED;
  }

  TextEditingController get getEmailTED {
    return _emailTED;
  }

  TextEditingController get getReferCodeTED {
    return _referCodeTED;
  }

  GlobalKey get getKey {
    return _key;
  }
}
